FactoryGirl.define do
  factory :relationship do
    factory :one do
      follower factory: :michael
      followed factory: :lana
    end

    factory :two do
      follower factory: :michael
      followed factory: :mallory
    end

    factory :three do
      follower factory: :lana
      followed factory: :michael
    end

    factory :four do
      follower factory: :archer
      followed factory: :michael
    end
  end
end
