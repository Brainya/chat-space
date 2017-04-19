FactoryGirl.define do

  factory :group do
    name { Faker::Name::name }
    users { create_list(:user, 3)}
  end
  
end
