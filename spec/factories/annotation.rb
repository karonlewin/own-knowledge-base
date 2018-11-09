require 'faker'

FactoryBot.define do
  factory :annotation do
    title { Faker::RickAndMorty.character }
    content { Faker::RickAndMorty.quote }
  end
end
