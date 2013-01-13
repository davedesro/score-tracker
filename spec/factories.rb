FactoryGirl.define do
  factory :user do
    first_name 'dude'
    sequence(:email) { |n| "dude#{n}@example.com" }
  end
end

FactoryGirl.define do
  factory :team do |t|
    t.association :player1, factory: :user
    t.association :player2, factory: :user
  end
end

