FactoryGirl.define do
  factory :user do
    username "Kate"
    password "Secret1"
    password_confirmation "Secret1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "brewery"
    year 1900
  end

  factory :beer do
    name "beer"
    brewery
    style "Lager"
  end
end
