# frozen_string_literal: true

class OfferedProduct < ApplicationRecord
  belongs_to :offering
  belongs_to :product

  acts_as_tenant :organization, through: :offering
end
