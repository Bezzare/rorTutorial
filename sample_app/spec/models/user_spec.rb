require 'rails_helper'

RSpec.describe User, type: :model do

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
      count_was = Micropost.count
      expect { user.destroy }.to change{ Micropost.count }.from(count_was).to(count_was-1)
    end
  end

end


















