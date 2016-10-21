User.create!(name:  "Example User",
             email: "example@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@hotmail.gov"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

publisher = Publisher.create!(name: "Example Corp")

site = Site.create!(name: "Example Sports", url: "example.sports.com", publisher: publisher)

User.take(25).each do |u|
  Seller.create!(user: u, publisher: publisher)
end

sellers = Seller.order(:created_at).take(6)
50.times do
  summary = Faker::Lorem.sentence(5)
  sellers.each { |seller| seller.proposals.create!(summary: summary, site: site) }
end
