require_relative "../test_helper"

class StaticFeatureToggleTest < ActiveSupport::TestCase

  it "returns nil for a non-existent feature" do
    StaticFeatureToggle.on?(:foobar).
      must_be_nil
  end

  it "returns nil for a nil feature" do
    StaticFeatureToggle.on?(nil).
      must_be_nil
  end

  describe "an opt-out feature" do
    it "is enabled for a group without a network" do
      StaticFeatureToggle.on?(:events, groups(:one)).
        must_equal true
    end

    it "is enabled for a group whose primary network has not opted out" do
      StaticFeatureToggle.on?(:events, groups(:fantastic_four)).
        must_equal true
    end

    it "is enabled for a group whose secondary network has opted out" do
      # my local political club is member of national network
      # which is not its primary network
      StaticFeatureToggle.on?(:events, groups(:my_local_political_club)).
        must_equal true
    end

    it "is disabled for groups whose primary network has opted out" do
      networks(:national_network).members.each do |group|
        StaticFeatureToggle.on?(:events, group).
          must_equal false
      end
    end
  end

  describe "an opt-in feature" do
    it "is disabled for a group without a network" do
      StaticFeatureToggle.on?(:google_groups, groups(:one)).
        must_equal false
    end

    it "is disabled for a group whose primary network has not opted in" do
      StaticFeatureToggle.on?(:google_groups, groups(:fantastic_four)).
        must_equal false
    end

    it "is disabled for a group whose secondary vnetwork has opted in" do
      StaticFeatureToggle.on?(:google_groups, groups(:my_local_political_club)).
        must_equal false
    end

    it "is enabled for groups whose primary network has opted in" do
      networks(:national_network).members.each do |group|
        StaticFeatureToggle.on?(:google_groups, group).
          must_equal true
      end
    end
  end
end
