class LocationView < ApplicationRecord
  belongs_to :user
  validates :seconds_viewed, numericality: { greater_than_or_equal_to: 0 }
end
