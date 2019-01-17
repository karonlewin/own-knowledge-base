class ReviewMailer < ApplicationMailer
  default from: 'notifications@own-knowledge-base.com'

  def today_reviews
    # users = User.all
    # users.each do |user|
      user = User.first
      @reviews = Review.by_user_id(user.id).today_reviews
      mail(to: user.email, subject: 'Welcome to My Awesome Site')
    # end
  end
end
