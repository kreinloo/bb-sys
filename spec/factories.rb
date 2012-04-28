FactoryGirl.define do

  factory :user do
    name      "testUser"
    email     "mail@example.org"
    password  "very_good_password"
    password_confirmation "very_good_password"
  end

  factory :post do
    title "Sample post"
    body "Sample body"
    user
  end

  factory :reply do
    body "Sample reply"
    post
    user
  end

end
