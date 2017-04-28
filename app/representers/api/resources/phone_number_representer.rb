class Api::Resources::PhoneNumberRepresenter < Api::Resources::Representer
  property :country
  property :description
  property :do_not_call
  property :extension
  property :number
  property :number_type
  property :operator
  property :primary
  property :sms_capable
end
