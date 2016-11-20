class Proposal < ApplicationRecord
  belongs_to :user
  belongs_to :site
  delegate :publisher, to: :site, allow_nil: false
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :site_id, presence: true
  validates :summary, presence: true, length: { maximum: 200 }
end
