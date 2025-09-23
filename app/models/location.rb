class Location < ApplicationRecord
  belongs_to :user

  validates :lat, :lng, :recorded_at, presence: true
end
