FactoryGirl.define do
  factory :micropost do
    sequence(:content) { |n| "Faker::Lorem.sentence(5)" }
    created_at 42.days.ago
    user factory: :michael

    factory :orange do
      content "I just ate an orange!"
      created_at 10.minutes.ago
      user factory: :michael
    end

    factory :tau_manifesto do
      content "Check out the @tauday site by @mhartl: http://tauday.com"
      created_at 3.years.ago
      user factory: :michael
    end

    factory :cat_video do
      content "Sad cats are sad: http://youtu.be/PKffm2uI4dk"
      created_at 2.hours.ago
      user factory: :michael
    end

    factory :most_recent do
      content "Writing a short test"
      created_at  Time.zone.now
      user factory: :michael
    end

  end
end



















