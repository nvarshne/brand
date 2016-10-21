class Site < ApplicationRecord
  belongs_to :publisher
  has_many :proposals, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :url, presence: true, length: { maximum: 50 }
  validates :publisher_id, presence: true
end
