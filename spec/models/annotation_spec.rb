require 'rails_helper'

describe Annotation do

  context 'generating the next review date (WEEKLY)' do
    let(:annotation) { build :annotation }

    it 'generate a weekly review after create a annotation' do
      new_annotation = build :annotation

      expect{new_annotation.save}.to change{Review.count}.from(Review.count).to(Review.count+20)
      # expect(Review.last.date.to_date).to eq((new_annotation.created_at + 7).to_date)

      puts new_annotation.created_at
      Review.all.each do |r| puts r.date.to_date end
    end

    xit 'generate a weekly review when an annotation it\'s being reviewed' do
      annotation.review
      expect(annotation.next_revision.to_date).to eq((DateTime.now + 7).to_date)
    end

  end

end
