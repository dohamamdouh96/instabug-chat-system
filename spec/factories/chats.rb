FactoryBot.define do
    factory :chat do
      number { Faker::Number.unique.number(digits:4) }
      association :application
    end
  end