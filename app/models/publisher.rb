class Publisher < ApplicationRecord
  has_many :sites
  has_many :sellers
  validates :name, presence: true
end
