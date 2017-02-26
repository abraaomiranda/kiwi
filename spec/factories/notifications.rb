FactoryGirl.define do
  factory :notification do
    association :owner, factory: :user
    association :recipient, factory: :user
    message 'está seguindo você'
    reference_class 'User'
    after(:build) do |notification|
      notification.reference_id  = notification.owner_id
    end
  end

end
