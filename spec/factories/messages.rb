FactoryGirl.define do

  factory :message do
    message { Faker::Lorem.sentence }
    user
    group
  end

end
