# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User at dashboard:' do
  before { login_as(user, scope: :user) }
  let(:user) { create :user }

  context 'reviewing annotations:' do
    xit 'user sees just 1 unreviewed annotation in 1 week from now:' do
      annotation = create :annotation, user: user
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(page).to have_selector('input#review_' << reviews.first.id.to_s, visible: :all)
      end
    end

    xit 'user sees just 1 unreviewed annotation in 3 weeks from now (first 2 reviews already done):' do
      annotation = create :annotation_2_weekly_reviews_done, user: user
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 3.weeks) do
        visit dashboard_path

        expect(page).to_not have_selector('input#review_' << reviews.first.id.to_s, visible: :all)
        expect(page).to_not have_selector('input#review_' << reviews.second.id.to_s, visible: :all)
        expect(page).to have_selector('input#review_' << reviews.last.id.to_s, visible: :all)
      end
    end

    xit 'user marking a review as done:' do
      annotation = create :annotation, user: user
      reviews    = annotation.reviews
      actual_review = reviews.first

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(actual_review.done).to eq nil
        expect(page).to have_selector('input#review_' << actual_review.id.to_s, visible: :all)

        expect do
          click_link "mark_review_as_done_#{actual_review.id}"
        end.to change(Review, :count).by(1)

        expect(page).to have_text 'Congratulations! Review done.'

        actual_review.reload
        expect(actual_review.done).to eq true
      end
    end

    xit 'user marking all reviews as done with 1 click:' do
      annotations = []
      reviews = []
      (1..3).each do |_n|
        annotation = create :annotation, user: user
        annotations << annotation
        reviews << annotation.next_review
      end

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(page).to have_selector('input#review_' << reviews.first.id.to_s, visible: :all)
        expect(page).to have_selector('input#review_' << reviews.second.id.to_s, visible: :all)
        expect(page).to have_selector('input#review_' << reviews.last.id.to_s, visible: :all)

        expect do
          click_link 'mark_all_reviews_as_done'
        end.to change(Review, :count).by(3)

        expect(page).to have_text 'Congratulations! All reviews done.'

        reviews.first.reload
        expect(reviews.first.done).to eq true
        reviews.second.reload
        expect(reviews.second.done).to eq true
        reviews.last.reload
        expect(reviews.last.done).to eq true
      end
    end

    xit 'user cannot read other user\'s reviews:' do
      annotation = create :annotation, user: user
      annotation_from_other_user = create :annotation

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(page).to have_selector('input#review_' << annotation.reviews.last.id.to_s, visible: :all)
        expect(page).to_not have_selector('input#review_' << annotation_from_other_user.reviews.last.id.to_s, visible: :all)
      end
    end
  end

  context 'distributing reviews:' do
    it 'user wants to distribute his reviews into the current week because its too much for one day:' do
      (1..30).each do |_n|
        annotation = create :annotation, user: user
      end

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path
        expect(page).to have_link('Done', count: 31) # considering the "mark all done" link

        click_link 'OMG, this is too much for one day!!!'

        # 30/7 = 4, 30%7 = 2 (but it'll be splited)
        # So it'll be: 4 + 1 + 1 from "mark all done"
        expect(page).to have_link('Done', count: 6)
        expect(page).to have_text 'Reviews randomized into the next week! Keep going!'
      end
    end
  end
end
