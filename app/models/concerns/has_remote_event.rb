module HasRemoteEvent
  extend ActiveSupport::Concern

  included do
    after_create :create_remote_events, if: :origin_system_is_action_network?
  end

  private

  def create_remote_events
    Api::ActionNetwork::Event.export!(self, self.group, false)
    self.reload
    AttendanceEvent.create_and_sync(self)
    NoAttendanceEvent.create_and_sync(self)
  end
end
