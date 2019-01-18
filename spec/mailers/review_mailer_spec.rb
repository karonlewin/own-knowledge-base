require 'rails_helper'

RSpec.describe ReviewMailer, type: :mailer do
  describe 'sending reminders of reviews:' do
    let(:mail) { ReviewMailer.today_reviews }
    let!(:annotation) { create :annotation_to_be_reminded_by_email }
    let!(:other_annotation) { create :annotation_to_be_reminded_by_email, user: annotation.user }

    before do
      Timecop.travel(DateTime.now + 1.weeks)
    end

    after do
      Timecop.return
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Hi! There are some reviews to be done.')
      expect(mail.to).to eq([annotation.user.email])
      expect(mail.from).to eq(['reminders@own-knowledge-base.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(annotation.title)
      expect(mail.body.encoded).to match(annotation.reviews.last.date.strftime("%d/%m/%Y"))
      expect(mail.body.encoded).to match(other_annotation.title)
      expect(mail.body.encoded).to match(other_annotation.reviews.last.date.strftime("%d/%m/%Y"))
    end
  end
end
