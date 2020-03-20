# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    date { '2018-11-13 15:29:41' }
    done { false }
    annotation { nil }
    user
  end
end
