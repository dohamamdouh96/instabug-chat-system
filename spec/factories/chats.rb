FactoryBot.define do
    factory :chat do
      number { Faker::Number.number(10) }
      application_id  {nil}
    end
  end