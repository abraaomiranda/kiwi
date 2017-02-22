FactoryGirl.define do
  factory :post do
    content "Something about my day :)"
    association :user
  end

end
