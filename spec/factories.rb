FactoryGirl.define do
  factory :user do
    first_name 'dude'
    sequence(:email) { |n| "dude#{n}@example.com" }
  end
end

FactoryGirl.define do
  factory :team do
    user1_id FactoryGirl.create(:user).id
    user2_id FactoryGirl.create(:user).id
  end
end

