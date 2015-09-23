require 'rails_helper'

RSpec.describe User, type: :model do

  fixtures :users
  let(:user) { User.new(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar") }

  describe "#attributes" do
    it "is valid" do
      # expect(user.valid?).to be_truthy
      expect(user.valid?).to be true
      expect(user).to be_valid
    end

    it "has a name" do
      user.name = "     "
      expect(user).not_to be_valid
    end

    it "has an email" do
      user.email = "    "
      expect(user).not_to be_valid
    end
  end

  context "when validating email" do
    it "accepts valid addresses" do
      valid_addresses = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.tw ]
      valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
      end
    end

    it "rejects invalid addresses" do
      invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com ]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end

    it "validates email uniqueness" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

  end

  context "when user is deleted" do
    it "destroys associated microposts" do
      user.save
      user.microposts.create!(content: "Lorem ipsum")
      # count_was = Micropost.count
      # expect { user.destroy }.to change{ Micropost.count }.from(count_was).to(count_was-1)
      expect { user.destroy }.to change(Micropost, :count).by(-1)
    end
  end

  context "when follows/unfollows a user" do
    it "should follow a user" do
      michael = users(:michael)
      archer = users(:archer)
      expect(michael.following?(archer)).not_to be true
      michael.follow(archer)
      expect(michael.following?(archer)).to be true
      expect(archer.followers).to include(michael)

      michael.unfollow(archer)
      expect(michael.following?(archer)).not_to be true
    end
  end

  context "verifying feeds" do

    let(:michael) { build(:michael) }
    let(:archer) { build(:archer) }
    let(:lana) { build(:lana) }

    it "verifies feed include posts from followed user" do
      lana.microposts.each do |post_following|
        expect(michael.feed).to include(post_following)
      end
    end

    it "verifies feed include posts from self" do
      michael.microposts.each do |post_self|
        expect(michael.feed).to include(post_self)
      end
    end

    it "verifies feed not include posts from unfollowed user" do
      archer.microposts.each do |post_unfollowed|
        expect(michael.feed).not_to include(post_unfollowed)
      end
    end
  end

end


















