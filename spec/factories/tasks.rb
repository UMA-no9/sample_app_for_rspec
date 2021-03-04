FactoryBot.define do
  factory :task do    
    sequence(:title) { |n| "task_title(#{n})" }
    content { "task_content" }
    status { 0 }
    deadline { nil }
  end
end
