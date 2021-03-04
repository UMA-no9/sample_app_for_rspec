FactoryBot.define do
  factory :user do    
    sequence(:email) { |n| "hogehoge#{n}@hoge.hoge" }
    password  { "hogehoge" }
    password_confirmation  { "hogehoge" }
  end
end
