FactoryGirl.define do
  factory :post do
    content 'Something about my day :)'
    association :author, factory: :user
  end

end
