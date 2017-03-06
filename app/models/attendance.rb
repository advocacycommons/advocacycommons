class Attendance < ApplicationRecord
  attr_accessor :event_uuid
  attr_accessor :person_uuid

  has_many :tickets
  belongs_to :person
  belongs_to :event

  after_save :add_identifier

  scope :any_identifier, ->(identifier) { where('? = any (identifiers)', identifier) }

  def add_identifier
    identifier = "advocacycommons:#{id}"

    if identifiers.nil?
      self.identifiers = [identifier]
      save
    elsif identifiers.include?(identifier)
      true
    else
      identifiers << identifier
      save
    end
  end

  def identifier(system_prefix)
    identifiers.detect { |i| i["#{system_prefix}:"] }
  end

  def identifier_id(system_prefix)
    identifier(system_prefix)&.split(':')&.second
  end
end
