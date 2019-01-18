class ReviewMailer < ApplicationMailer
  default from: 'reminders@own-knowledge-base.com'

  def today_reviews
    users = User.all
    users.each do |user|
      @reviews = Review.by_user_id(user.id).today_reviews
      if (@reviews.count > 0)
        mail(to: user.email, subject: 'Hi! There are some reviews to be done.')
      end
    end
  end
end
