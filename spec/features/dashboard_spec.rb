require 'rails_helper'

RSpec.feature 'User at dashboard:' do

  before { login_as(user, :scope => :user) }
  let(:user)  { create :user }

  context 'reviewing annotations:' do
    it 'user sees just 1 unreviewed annotation in 1 week from now:' do
      annotation = create :annotation, user: user
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(page).to have_selector('input#review_' << reviews.first.id.to_s, visible: :all)
      end
    end

    it 'user sees just 1 unreviewed annotation in 3 weeks from now (first 2 reviews already done):' do
      annotation = create :annotation_2_weekly_reviews_done, user: user
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 3.weeks) do
        visit dashboard_path

        expect(page).to_not have_selector('input#review_' << reviews.first.id.to_s, visible: :all)
        expect(page).to_not have_selector('input#review_' << reviews.second.id.to_s, visible: :all)
        expect(page).to have_selector('input#review_' << reviews.last.id.to_s, visible: :all)
      end
    end

    it 'user marking a review as done:' do
      annotation = create :annotation, user: user
      reviews    = annotation.reviews
      actual_review = reviews.first

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(actual_review.done).to eq nil
        expect(page).to have_selector('input#review_' << actual_review.id.to_s, visible: :all)

        expect{
          click_link "mark_review_as_done_#{actual_review.id}"
        }.to change(Review, :count).by(1)

        expect(page).to have_text 'Congratulations! Review done.'

        actual_review.reload
        expect(actual_review.done).to eq true
      end

    end

    it 'user cannot read other user\'s reviews:' do
      annotation = create :annotation, user: user
      annotation_from_other_user = create :annotation

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(page).to have_selector('input#review_' << annotation.reviews.last.id.to_s, visible: :all)
        expect(page).to_not have_selector('input#review_' << annotation_from_other_user.reviews.last.id.to_s, visible: :all)
      end
    end
  end
end
