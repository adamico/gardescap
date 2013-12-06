require 'spec_helper'

describe User do
  describe "#role" do
    it "should exist" do
      User.new.should respond_to(:role)
    end
  end
end
