require 'rails_helper'

describe Annotation do

  WEEKLY_REVIEWS = 8
  MONTHLY_REVIEWS = 12

  context 'generating reviews' do
    let(:annotation) { build :annotation }

    it 'generate all reviews after create a annotation' do
      new_annotation = build :annotation

      expect{new_annotation.save!}.to change(Review, :count).by(20)

      review_dates_array = []
      review_date = new_annotation.created_at

      WEEKLY_REVIEWS.times do
        review_date += 7.days
        review_dates_array << (review_date).to_date
      end

      MONTHLY_REVIEWS.times do
        review_date += 1.months
        review_dates_array << (review_date).to_date
      end

      generated_reviews = new_annotation.reviews.reduce([]) {|array, review| array << review.date.to_date}
      expect(review_dates_array).to eq(generated_reviews)
    end
  end
end
