# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :garde do
    date '2013-12-06'
    time 'MyString'
    factory :garde_active do
      after(:create) { |garde| garde.active! }
    end
  end
end
