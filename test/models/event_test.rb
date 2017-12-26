require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'basic associations' do
    one = events(:one)
    assert_kind_of TicketLevel, one.ticket_levels.first
    assert_kind_of Address, one.location
    assert_kind_of Person, one.creator
    assert_kind_of Person, one.organizer
    assert_kind_of Person, one.modified_by
    assert_kind_of Attendance, one.attendances.first
    assert_kind_of Reminder, one.reminders.first
  end

  test '#identifier' do
    event = Event.new
    assert_nil event.identifier('action_network')

    event = Event.new(identifiers: ['advocacycommons:3'])
    assert_nil event.identifier('action_network')
    assert_equal 'advocacycommons:3', event.identifier('advocacycommons')

    event = Event.new(identifiers: ['advocacycommons:3', 'action_network:100-200-abc'])
    assert_equal 'action_network:100-200-abc', event.identifier('action_network')
    assert_equal 'advocacycommons:3', event.identifier('advocacycommons')
    assert_nil event.identifier('foo')
  end

  test '#identifier_id' do
    event = Event.new
    assert_nil event.identifier_id('action_network')

    event = Event.new(identifiers: ['advocacycommons:3'])
    assert_nil event.identifier_id('action_network')
    assert_equal '3', event.identifier_id('advocacycommons')

    event = Event.new(identifiers: ['advocacycommons:3', 'action_network:100-200-abc'])
    assert_equal '100-200-abc', event.identifier_id('action_network')
    assert_equal '3', event.identifier_id('advocacycommons')
    assert_nil event.identifier_id('foo')
  end

  test '.add_attendance_counts' do
    events = Event.all
    Event.add_attendance_counts(events)

    #assert_equal 2, events.detect { |e| e.id == 1 }.invited_count
    assert_equal 2, events.detect { |e| e.id == 1 }.rsvp_count
    assert_equal 0, events.detect { |e| e.id == 1 }.attended_count

    #assert_equal 4, events.detect { |e| e.id == 2 }.invited_count
    assert_equal 0, events.detect { |e| e.id == 2 }.rsvp_count
    assert_equal 0, events.detect { |e| e.id == 2 }.attended_count

    #assert_equal 4, events.detect { |e| e.id == 2 }.invited_count
    assert_equal 5, events.detect { |e| e.id == 3 }.rsvp_count
    assert_equal 3, events.detect { |e| e.id == 3 }.attended_count
  end

  test '.upcoming' do
    ended_event = Event.create(origin_system: 'Action Network', title: 'title', start_date: 2.days.ago)
    upcoming_event_1 = Event.create(origin_system: 'Action Network', title: 'title', start_date: Date.today)
    upcoming_event_2 = Event.create(origin_system: 'Action Network', title: 'title', start_date: Date.today + 2.days)
    future_event = Event.create(origin_system: 'Action Network', title: 'title', start_date: Date.today + (Event::UPCOMING_EVENTS_DAYS + 1).days)

    assert_includes Event.upcoming, upcoming_event_1
    assert_includes Event.upcoming, upcoming_event_2
  end

  test '.start' do
    Event.all.each {|event| event.destroy}

    ended_event = Event.create(origin_system: 'Action Network', title: 'title', start_date: 2.days.ago, status: 'status')
    event_1 = Event.create(origin_system: 'Action Network', title: 'title', start_date: Date.today, status: 'status')
    event_2 = Event.create(origin_system: 'Action Network', title: 'title', start_date: Date.today + 1.days, status: 'status')

    assert_equal [event_1], Event.start(Date.today)
  end

  test '.origin_system_is_action_network?' do
    event = Event.create(origin_system: 'Action Network', title: 'title', origin_system: 'Action Network', title: 'title',
                               start_date: 2.days.ago, status: 'status')

    assert event.origin_system_is_action_network?
  end

  test '.origin_system_is_action_network? is not' do
    event = Event.create(origin_system: 'Affinity', title: 'title',
                               start_date: 2.days.ago, status: 'status')

    assert_not event.origin_system_is_action_network?
  end



  test 'create_remote_events' do
    event = Event.new(origin_system: 'Action Network', title: 'title', status: 'status', title: 'Original')
    event.groups << Group.first

    stub_request(:post, "https://actionnetwork.org/api/v2/events").to_return(:status => 200, :body => "", :headers => {}).times(1)

    stub_request(:post, "https://actionnetwork.org/api/v2/events").
      with(:body => {"identifiers"=>[], "title"=>"Original_ATT", "origin_system"=>"Affinity", "_links"=>{}},
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'Osdi-Api-Token'=>'test-token', 'User-Agent'=>'Ruby'}).
      to_return(body: File.read(Rails.root.join('test', 'fixtures', 'files', 'events', 'att_event.json')))

    stub_request(:post, "https://actionnetwork.org/api/v2/events").
      with(:body => {"identifiers"=>[], "title"=>"Original_NO_ATT", "origin_system"=>"Affinity", "_links"=>{}} ,
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'Osdi-Api-Token'=>'test-token', 'User-Agent'=>'Ruby'})
      .to_return(body: File.read(Rails.root.join('test', 'fixtures', 'files', 'events', 'no_att_event.json')))

    assert_difference 'Event.count', 1 do
      assert_difference 'AttendanceEvent.count', 1 do
        assert_difference 'NoAttendanceEvent.count', 1 do
          event.save
          assert_equal event.attendance_event.identifier_id('action_network'), 'bb75d46b-3f86-4a39-9193-b9d5bd873eae'
          assert_equal event.no_attendance_event.identifier_id('action_network'), '4f11250f-4bdc-4358-b839-dac9d18cd8c8'
          assert_equal event.attendance_event.name, "#{event.title}_ATT"
          assert_equal event.no_attendance_event.name, "#{event.title}_NO_ATT"
        end
      end
    end

    assert_difference 'Event.count', 0 do
      assert_difference 'AttendanceEvent.count', 0 do
        assert_difference 'NoAttendanceEvent.count', 0 do
          event.update(title: 'original edited')
        end
      end
    end

  end

  test 'create_remote_events, origin_system isn\'t Action Network' do
    event = Event.new(origin_system: 'Affinity', title: 'title', status: 'status', title: 'Original')
    event.groups << Group.first

    assert_difference 'Event.count', 1 do
      assert_difference 'AttendanceEvent.count', 0 do
        assert_difference 'NoAttendanceEvent.count', 0 do
          event.save
        end
      end
    end

  end
end
