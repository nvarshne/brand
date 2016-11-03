publisher1 = Publisher.create!(name: "Org Inc",
                               activated: true,
                               activated_at: Time.zone.now)
site1 = publisher1.sites.create!(name: "Org Inc Sports",
                                 url: "sports.com")
site2 = publisher1.sites.create!(name: "Org Inc Life",
                                 url: "life.com")
publisher2 = Publisher.create!(name: "Org Deux",
                               activated: true,
                               activated_at: Time.zone.now)
site3 = publisher2.sites.create!(name: "2Money",
                                 url: "money.com")

password = "foobar"
User.create!(name:  "Example Admin",
             email: "example@gmail.com",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             admin: true)

User.create!(name: "Example Lead",
             email: "lead@gmail.com",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             publisher: publisher1,
             lead: true)

User.create!(name: "Example Team Member",
             email: "member@gmail.com",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             publisher: publisher1)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@hotmail.gov"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               publisher: publisher1)
end

users = User.where(admin: false).order(:created_at).take(6)
50.times do
  summary = Faker::Lorem.sentence(5)
  users.each { |user| user.proposals.create!(summary: summary, site: site1) }
end
