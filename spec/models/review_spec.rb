require 'rails_helper'

describe Review do

  WEEKLY_REVIEWS = 8
  MONTHLY_REVIEWS = 12

  context 'generating reviews' do
    it 'generate a WEEKLY review after create a reviewable' do
      new_annotation = build :annotation

      expect{new_annotation.save!}.to change(Review, :count).by(1)
      expect(Review.last.date.to_date).to eq((new_annotation.created_at + 1.weeks).to_date)
    end

    it 'generate a WEEKLY review when a reviewable is being reviewed' do
      annotation = create :annotation

      first_week_review = annotation.reviews.last

      expect{first_week_review.mark_as_done}.to change(Review, :count).by(1)
      expect(annotation.reviews.last.date.to_date).to eq((first_week_review.date + 1.weeks).to_date)
    end

    it 'generate a MONTHLY review when a reviewable is being reviewed after the weekly period' do
      annotation = create :annotation # the first review is being generated here

      # marking all weekly reviews as done, except for the last one
      (WEEKLY_REVIEWS-1).times do
        annotation.reviews.last.mark_as_done
      end

      # the first monthly review
      last_week_review = annotation.reviews.last
      expect{last_week_review.mark_as_done}.to change(Review, :count).by(1)
      expect(annotation.reviews.last.date.to_date).to eq((last_week_review.date + 1.months).to_date)

      # the second monthly review
      last_month_review = annotation.reviews.last
      expect{last_month_review.mark_as_done}.to change(Review, :count).by(1)
      expect(annotation.reviews.last.date.to_date).to eq((last_month_review.date + 1.months).to_date)
    end

    it 'stop to geenerate reviews after the weekly+monthly period' do
      annotation = create :annotation # the first review is being generated here

      # marking all reviews as done, except for the last one
      (WEEKLY_REVIEWS+MONTHLY_REVIEWS-1).times do
        annotation.reviews.last.mark_as_done
      end

      last_review = annotation.reviews.last
      expect{last_review.mark_as_done}.to_not change(Review, :count)
    end
  end
end
