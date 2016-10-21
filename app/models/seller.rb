class Seller < ApplicationRecord
  belongs_to :user
  belongs_to :publisher
  has_many :proposals, dependent: :destroy
end
