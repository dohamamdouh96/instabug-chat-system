FactoryBot.define do
    factory :message do
      number { Faker::Number.unique.number(digits:4) }
      body { Faker::Lorem.word }
      association :chat
    end
  end