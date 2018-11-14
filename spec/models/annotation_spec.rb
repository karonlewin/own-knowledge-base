require 'rails_helper'

describe Annotation do

  context 'generating reviews' do
    it 'generate a weekly review after create a annotation' do
      new_annotation = build :annotation

      expect{new_annotation.save!}.to change(Review, :count).by(1)
      expect(Review.last.date.to_date).to eq((new_annotation.created_at + 1.weeks).to_date)
    end

    it 'generate a weekly review when an annotation is being reviewed' do
      annotation = create :annotation

      first_week_review = annotation.reviews.last

      expect{first_week_review.mark_as_done}.to change(Review, :count).by(1)
      expect(annotation.reviews.last.date.to_date).to eq((first_week_review.date + 1.weeks).to_date)
    end
  end
end
