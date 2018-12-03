require 'rails_helper'

RSpec.feature 'User managing annotations:' do
  context 'listing annotations:' do
    before { login_as(user, :scope => :user) }

    let(:user)  { create :user }
    let!(:annotation) { create :annotation }

    it 'user see the date of next review from a new annotation:' do
      visit annotations_path

      expect(page).to have_text(annotation.reviews.first.date.strftime("%d/%m/%Y"))
    end

    it 'user see the date of next review from a old annotation with only 1 review done:' do
      annotation.reviews.first.mark_as_done
      visit annotations_path

      expect(page).to have_text(annotation.reviews.last.date.strftime("%d/%m/%Y"))
    end
  end
end