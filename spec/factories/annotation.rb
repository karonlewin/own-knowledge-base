# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :annotation do
    title { Faker::Book.unique.title }
    content { Faker::RickAndMorty.quote }
    association :category
    association :user

    factory :annotation_2_weekly_reviews_done do
      after :create do |annotation|
        2.times do
          annotation.reviews.last.mark_as_done
        end
      end
    end

    factory :annotation_on_the_last_weekly_review do
      after :create do |annotation|
        (ReviewGenerator::WEEKLY_REVIEWS - 1).times do
          annotation.reviews.last.mark_as_done
        end
      end
    end

    factory :annotation_on_the_last_review_ever do
      after :create do |annotation|
        (ReviewGenerator::TOTAL_REVIEWS - 1).times do
          annotation.reviews.last.mark_as_done
        end
      end
    end

    factory :annotation_to_be_reminded_by_email do
      user
      category { create :category, user: user }
    end
  end
end
