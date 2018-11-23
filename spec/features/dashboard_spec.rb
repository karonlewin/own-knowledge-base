require 'rails_helper'

RSpec.feature 'User at dashboard:' do
  context 'reviewing annotations:' do
    before { login_as(user, :scope => :user) }

    let(:user)  { create :user }

    it 'user sees just 1 unreviewed annotations in 3 weeks:' do
      annotation = create :annotation
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 1.weeks) do
        visit dashboard_path

        expect(page).to have_text(reviews.first.id)
      end
    end

    it 'user sees just 1 unreviewed annotations in 3 weeks:' do
      annotation = create :annotation_2_weekly_reviews_done
      reviews    = annotation.reviews

      Timecop.travel(DateTime.now + 3.weeks) do
        visit dashboard_path

        expect(page).to_not have_text(reviews.first.id)
        expect(page).to_not have_text(reviews.second.id)
        expect(page).to have_text(reviews.last.id)
      end
    end

  end

end
