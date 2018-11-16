require 'rails_helper'

RSpec.feature 'User at dashboard:' do

  before(:all) do
    annotation = create :annotation_2_weekly_reviews_done
    byebug
  end


  it 'User see all annotations that need to be revised' do
    annotation = create :annotation

    visit dashboard_path

    expect(page).to have_text(annotation.title)
  end

end
