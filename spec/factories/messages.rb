FactoryGirl.define do

  factory :message do
    message { Faker::Lorem.sentence }
    user    { create(:user) }
    group   { create(:group) }
  end

end
