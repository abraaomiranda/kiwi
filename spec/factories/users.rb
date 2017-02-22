FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test_#{n}@emxepla.com"}
    sequence(:username) {|n| "teste_exemple_#{n}"}
    name 'Test Example'
    password 'xablau'
  end

end
