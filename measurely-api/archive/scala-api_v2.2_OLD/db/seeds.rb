# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# Create sample set of clients
clients = Client.all
unless clients.count >= 50
  50.times do
  Client.create(
    clinician_id: SecureRandom.uuid, 
    client_id: SecureRandom.uuid, 
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name,
    sex: Faker::Gender.binary_type,
    birth_date: Faker::Date.birthday(18, 65),
    postcode: Faker::Address.zip_code,
    marital_status: Faker::Demographic.marital_status,
    sexuality: Faker::Demographic.sex,
    ethnicity: Faker::Demographic.race,
    indigenous: Faker::Demographic.race,
    children: Faker::Number.number(1),
    workforce_status: Faker::Job.employment_type,
    education: Faker::Job.education_level)
  end
end