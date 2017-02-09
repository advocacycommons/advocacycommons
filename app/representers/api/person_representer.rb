require 'roar/json/hal'

class Api::PersonRepresenter < Roar::Decorator
  include Roar::JSON::HAL

  property :created_at, as: :created_date
  property :id
  property :updated_at, as: :modified_date

  property :identifiers, exec_context: :decorator

  property :additional_name
  property :birthdate
  property :employer
  property :ethnicities
  property :family_name
  property :gender
  property :gender_identity
  property :given_name
  property :honorific_prefix
  property :honorific_suffix
  property :languages_spoken
  property :party_identification
  property :source

  collection :email_addresses, decorator: Api::EmailAddressRepresenter
  collection :personal_addresses, as: :postal_addresses, decorator: Api::AddressRepresenter

  def identifiers
    ["osdi:#{ActiveModel::Naming.singular(represented)}-#{represented.id}"]
  end
end
