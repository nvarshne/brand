class Proposal < ApplicationRecord
  belongs_to :user
  belongs_to :site
  delegate :publisher, to: :site, allow_nil: false
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :site_id, presence: true
  validates :summary, presence: true, length: { maximum: 200 }

  #Integration Types (mutually exclusive)
  "Custom"
  "Sponsored"

  # Proposal Types
  "Photo Gallery"
  "Product Gallery"
  "Video Series/Gallery"
  "Influencer Video"
  "Editorial Video"
  "Editorial Post/Article"
  "Whitepaper"
  "Research"
  "Publisher Blog Post"
  "Influencer Blog Posts"
  "Influencer Product Placement"
  "Editorial Product Placement"
  "Quiz"
  "Infographic"
  "Game"
  "Editorial Social Post"
  "Influencer Social Post"
  "Audio Playlist"
  "Video Playlist"
  "Content Hub"
  "In-App Experience"
  "First to Market/Beta Tests"

  #Site Categories. Up to 3 per proposal
  "Lifestyle"
  "Music"
  "News"
  "Finance"
  "Entertainment"
  "Celebrity"
  "Blog"
  "Sports"
  "Fashion"
  "Beauty"
  "Social"
  "Video"
  "Automotive"
  "Travel"
  "Education"
  "Opinion"
  "Employment"
  "Real Estate"
  "Local Community"
  "Kids"
  "Technology & Computing"
  "Home & Garden"
  "Parenting & Family"
  "Science"
  "Video"
  "Food & Drink"
  "Special Interest"
  "Review Sites"

  #Objectives and corresponding KPIs. Mandatory primary objecive, optional secondary objecive
  "Awareness"
  "Key Performance Indicators (KPI):"
  "Reach"
  "Impressions"
  "Video Views"
  "Page Views"

  "Engagement"
  "Key Performance Indicators (KPI):"
  "CTR"
  "Like Rate"
  "Comment Rate"
  "Share Rate"
  "Total Engagement Rate"

  "Direct Response"
  "Key Performance Indicators (KPI):	"
  "Conversion rate"
  "Revenue"
  "Orders"
  "Return on ad spend (ROAS)"
  "Email/data capture"
  "Click through rate"
  "Store visitation rate"
  "Click to call"
  "Sign-up rate"
end
