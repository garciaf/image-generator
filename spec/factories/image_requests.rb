FactoryBot.define do
  factory :image_request do
    prompt { Faker::Movie.quote }
    size { "#{Faker::Number.number(digits: 10)}x#{Faker::Number.number(digits: 10)}" }

    trait :with_image do
      after(:build) do |image_request|
        image_request.images.attach(
          filename: 'test.png',
          io: File.open(File.expand_path('./spec/fixtures/test.png'))
        )
      end
    end
  end
end
