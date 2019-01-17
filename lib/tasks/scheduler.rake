desc "This task is called by the Heroku scheduler add-on"

task :send_review_reminders => :environment do
  ReviewMailer.today_reviews.deliver_now
end
