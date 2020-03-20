# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User managing categories:' do
  context 'managing categories:' do
    before { login_as(user, scope: :user) }

    let(:user) { create :user }

    it 'user create a category:' do
      visit categories_path

      click_link 'New Category'

      fill_in 'Name', with: 'Some Name'

      click_button 'Create Category'

      expect(page).to have_text('Some Name')
    end
  end
end
