require 'spec_helper'
require 'ostruct'

describe PostSerializer do

  let(:resource) do
    Post.new.
      tap { |post| post.id = 5 }
  end
  let(:user) { OpenStruct.new(id: 5, name: 'Bengt') }

  describe "when current_user is nil" do
    before do
      serialize resource
    end

    it "serializes attributes" do
      attributes.keys.must_include(:title)
      attributes.keys.must_include(:message)
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
      attributes.keys.must_include(:title)
      attributes.keys.must_include(:message)
    end

    it "serializes links" do
      link_rels.must_include(:'doc:up')
      link_rels.must_include(:'self')
      link_rels.must_include(:'doc:edit-form')
      link_rels.must_include(:'doc:delete')
    end
  end
end

