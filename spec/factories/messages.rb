FactoryGirl.define do

  factory :user do
    email    { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    name     { Faker::Name::name }
  end

  factory :group do
    name { Faker::Name::name }
  end

  factory :message do
    message "hello world"
    user
    group
  end

end
