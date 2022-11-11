FactoryBot.define do
  factory :generated_image do
    association :image_request
    trait :synced do
      url { Faker::Internet.url }
    end
  end
end

