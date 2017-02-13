require 'test_helper'

class Api::PersonRepresenterTest < ActiveSupport::TestCase
  test 'to_json' do
    person = Person.new(family_name: 'Simpson')

    json = JSON.parse(Api::PersonRepresenter.new(person).to_json)

    assert_equal 'Simpson', json['family_name'], 'family_name'
  end

  test 'custom_fields' do
    person = Person.create!(
      custom_fields: { foo: 'bar', baz: 'bat' },
      email: 'person@example.com',
      password: 'secret'
    )

    json = JSON.parse(Api::PersonRepresenter.new(person).to_json)

    assert_equal 'bar', json['custom_fields']['foo'], 'custom_fields foo'
    assert_equal 'bat', json['custom_fields']['baz'], 'custom_fields baz'
  end
end
