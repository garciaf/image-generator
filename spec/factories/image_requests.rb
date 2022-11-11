FactoryBot.define do
  factory :image_request do
    prompt { Faker::Movie.quote }
    size { "#{Faker::Number.number(digits: 10)}x#{Faker::Number.number(digits: 10)}"}
  end
end
