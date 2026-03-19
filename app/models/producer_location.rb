# frozen_string_literal: true

class ProducerLocation < ApplicationRecord
  acts_as_tenant :organization
  belongs_to :user
  belongs_to :location
end
