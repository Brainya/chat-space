FactoryGirl.define do

  factory :message do
    message "hello world"
    user
    group
  end

end
