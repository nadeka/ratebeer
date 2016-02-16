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
    style
  end

  factory :style, class:Style do
      name "lager"
      description "description"
  end

  factory :style2, class:Style do
      name "ipa"
      description "description"
  end

  factory :style3, class:Style do
      name "porter"
      description "description"
  end
end
