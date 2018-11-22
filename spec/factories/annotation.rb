require 'faker'

FactoryBot.define do
  factory :annotation do
    title { Faker::Name.unique.name }
    content { Faker::RickAndMorty.quote }

    factory :annotation_2_weekly_reviews_done do
      after :create do |annotation|
        2.times do
          annotation.reviews.last.mark_as_done
        end
      end
    end

    factory :annotation_on_the_last_weekly_review do
      after :create do |annotation|
        (ReviewGenerator::WEEKLY_REVIEWS-1).times do
          annotation.reviews.last.mark_as_done
        end
      end
    end

    factory :annotation_on_the_last_review_ever do
      after :create do |annotation|
        (ReviewGenerator::TOTAL_REVIEWS-1).times do
          annotation.reviews.last.mark_as_done
        end
      end
    end
  end
end
