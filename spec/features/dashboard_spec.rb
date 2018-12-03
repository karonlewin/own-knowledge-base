require 'rails_helper'

RSpec.feature 'User at dashboard:' do
  context 'reviewing annotations:' do
    before { login_as(user, :scope => :user) }

    let(:user)  { create :user }

    it 'user sees just 1 unreviewed annotation in 1 week from now:' do
      annotation = create :annotation
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(page).to have_text(reviews.first.id)
      end
    end

    it 'user sees just 1 unreviewed annotation in 3 weeks from now (first 2 reviews already done):' do
      annotation = create :annotation_2_weekly_reviews_done
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 3.weeks) do
        visit dashboard_path

        expect(page).to_not have_text(reviews.first.id)
        expect(page).to_not have_text(reviews.second.id)
        expect(page).to have_text(reviews.last.id)
      end
    end

    it 'user marking a review as done:' do
      annotation = create :annotation
      reviews    = annotation.reviews
      actual_review = reviews.first

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(actual_review.done).to eq nil
        expect(page).to have_text(actual_review.id)

        expect{
          click_link "mark_review_as_done_#{actual_review.id}"
        }.to change(Review, :count).by(1)

        expect(page).to have_text 'Congratulations! Review done.'

        actual_review.reload
        expect(actual_review.done).to eq true
      end

    end
  end
end
