FactoryGirl.define do

  factory :group do
    name { Faker::Name::name }

    to_create do |instance|
      instance.save validate: false
    end
  end

end
