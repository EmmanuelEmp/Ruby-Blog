FactoryBot.define do
  factory :page do
    user { create(:user) }
    sequence(:title) { |n| "Page Title #{n}" }
    sequence(:summary) { |n| "<p>Page summarg goes here #{n}</p>" }
    sequence(:content) { |n| "<p>Page content goes here #{n}</p>" }
    created_at { Time.zone.now }
    published { false }
  end
end
