require 'spec_helper'
require 'ostruct'

describe UserSerializer do

  let(:resource) do
    User.new.
      tap { |user| user.id = 5 }
  end
  let(:user) { OpenStruct.new(id: 5, name: 'Bengt') }

  describe "when current_user is nil" do
    before do
      serialize resource
    end

    it "serializes attributes" do
      attributes.keys.must_include(:name)
    end

    it "serializes links" do
      link_rels.must_include(:'self')
      link_rels.must_include(:'doc:up')
    end
  end

  describe "when current_user is present" do
    before do
      serialize resource, current_user: user
    end

    it "serializes attributes" do
      attributes.keys.must_include(:name)
    end

    it "serializes links" do
      link_rels.must_include(:'doc:up')
      link_rels.must_include(:'self')
      link_rels.must_include(:'doc:edit-form')
      link_rels.must_include(:'doc:delete')
    end
  end
end

