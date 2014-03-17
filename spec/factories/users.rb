# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "utilisateur#{i}"}
    email { |user| "#{user.name.downcase}@example.com" }
    password "lemotdepasse1234"
    password_confirmation "lemotdepasse1234"
    factory :admin do
      admin true
    end
  end
end
