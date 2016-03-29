FactoryGirl.define do
  factory :auction do
    title "MyString"
    details "MyString"
    ends_on "2016-03-29"
    reserve_price "9.99"
    aasm_state "MyString"
  end
end
