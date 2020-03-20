# frozen_string_literal: true

class ReviewMailer < ApplicationMailer
  default from: 'reminders@own-knowledge-base.com'

  def today_reviews
    users = User.all
    users.each do |user|
      @reviews = Review.today_reviews(user.id)
      if @reviews.count > 0
        mail(to: user.email, subject: 'Hi! There are some reviews to be done.')
      end
    end
  end
end
