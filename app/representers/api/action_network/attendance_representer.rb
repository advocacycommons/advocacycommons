class Api::ActionNetwork::AttendanceRepresenter < Api::AttendanceRepresenter
  property :event_uuid, as: 'action_network:event_id'
  property :person_uuid, as: 'action_network:person_id'
end
