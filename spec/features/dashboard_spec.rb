require 'rails_helper'

RSpec.feature 'User at dashboard:' do


  it 'User see all annotations that need to be revised' do
    visit dashboard_path

    expect(page).to have_text(annotation)
  end

end
