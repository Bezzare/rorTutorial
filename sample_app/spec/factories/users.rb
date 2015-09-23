FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password_digest User.digest('password')
    activated true
    activated_at Time.zone.now
    initialize_with { User.where(email: email).first_or_create }

    factory :michael do
      name "Michael Example"
      email "michael@example.com"
      admin true
    end

    factory :foo do
      name "Foo Bar"
      email "foo@example.com"
    end

    factory :archer do
      name "Sterling Archer"
      email "duchess@example.gov"
    end

    factory :lana do
      name "Lana Kane"
      email "hands@example.gov"
    end

    factory :mallory do
      name "Mallory Archer"
      email "boss@example.gov"
    end

  end
end
