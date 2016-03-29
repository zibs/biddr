FactoryGirl.define do

  factory :auction do
    association :user, factory: :user
    title {Faker::Hipster.sentence}
    details {Faker::Hipster.sentence}
    ends_on "2017-03-29"
    reserve_price "10.99"
  end

end
