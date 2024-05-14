# frozen_string_literal: true

class OfferedProduct < ApplicationRecord
  belongs_to :offering
  belongs_to :product

  # TODO: Solve bug when trying to save an offering with acts_as_tenant
  # acts_as_tenant :organization, through: :offering
end
