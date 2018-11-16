require 'rails_helper'

RSpec.feature 'User at dashboard:' do


  it 'User see all annotations that need to be revised' do
    annotation = create :annotation

    visit dashboard_path

    expect(page).to have_text(annotation.title)
  end

end
