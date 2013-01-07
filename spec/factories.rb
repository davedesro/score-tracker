FactoryGirl.define do
  factory :user do
    name 'Dude'
    employee_id '8'
    tagline 'whatever, man'
    password 'foobarfoobar'
    password_confirmation 'foobarfoobar'
    first_name 'dude'
    last_name 'doctometrist'
    email 'dude@example.com'
  end
end
