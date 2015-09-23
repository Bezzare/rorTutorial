require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#attributes" do

    let(:user) { User.new(name: "Example User", email: "user@example.com",
                          password: "foobar", password_confirmation: "foobar") }

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

end
