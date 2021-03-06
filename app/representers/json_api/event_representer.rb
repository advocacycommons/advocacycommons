require 'roar/json/json_api'

class JsonApi::EventRepresenter < Roar::Decorator
  include Roar::JSON::JSONAPI.resource :event

  attributes do
    property :all_day
    property :all_day_date
    property :browser_url
    property :capacity
    property :description
    property :end_date
    property :featured_image_url
    property :guests_can_invite_others
    property :instructions
    property :name
    property :origin_system
    property :osdi_type, as: :type
    property :share_url
    property :start_date
    property :status
    property :summary
    property :title
    property :total_accepted
    property :total_amount
    property :total_shares
    property :total_tickets
    property :transparency
    property :visibility
    property :rsvp_count

    property :location, decorator: Api::Resources::AddressRepresenter, class: EventAddress
    property :creator, extend: JsonApi::PeopleRepresenter, class: Person
  end
end
