require 'spec_helper'

describe Bookmark, type: :integration do

  it "returns a bookmark" do
    bookmark = Bookmark.create
    get bookmark_uri(bookmark)
    status.must_equal 200
    link_rels.must_include(:self)
    links[:self][:href].must_equal bookmark_uri(bookmark)
    attributes.must_include(:'user_id')
    attributes.must_include(:'post_id')
  end

  it "lists all bookmarks" do
    Bookmark.create
    Bookmark.create

    get bookmarks_uri
    status.must_equal 200
    link_rels.must_include(:self)
    links[:self][:href].must_include bookmarks_uri
    embedded(:'bookmarks').size.must_equal 2

    each_embedded :'bookmarks' do
      link_rels.must_include(:self)
      attributes.must_include(:'user_id')
      attributes.must_include(:'post_id')
    end
  end

  it "can create bookmarks" do
    get bookmarks_uri

    link_rels.must_include(:'doc:create-form')
    follow_rel :'doc:create-form'
    links[:self][:href].must_equal new_bookmark_uri
    attributes[:href].must_equal bookmarks_uri
    attributes[:method].must_equal "POST"
    attributes[:name].must_equal "create-bookmark"
    attributes[:title].must_equal "Create Bookmark"
    attributes[:type].must_equal "application/json"
    attributes[:fields].size.must_equal 2

    payload = fill_form attributes[:fields]
    post attributes[:href], payload
    status.must_equal 201
    link_rels.must_include(:self)
    headers["Location"].must_equal links[:self][:href]

    get bookmarks_uri
    status.must_equal 200
    links[:self][:href].must_include bookmarks_uri
    embedded(:'bookmarks').size.must_equal 1

    embedded :'bookmarks' do
      bookmark = last_payload.first
    end
  end

  it "bookmarks can be updated" do
    bookmark = Bookmark.create
    get bookmark_uri(bookmark)
    status.must_equal 200

    link_rels.must_include(:'doc:edit-form')
    follow_rel :'doc:edit-form'

    links[:self][:href].must_equal edit_bookmark_uri(bookmark)
    attributes[:href].must_equal bookmark_uri(bookmark)
    attributes[:method].must_equal "PUT"
    attributes[:name].must_equal "update-bookmark"
    attributes[:title].must_equal "Update Bookmark"
    attributes[:type].must_equal "application/json"
    attributes[:fields].size.must_equal 2

    payload = fill_form attributes[:fields]
    put attributes[:href], payload
    status.must_equal 200
    link_rels.must_include(:self)
  end

  it "bookmarks can be deleted" do
    bookmark = Bookmark.create
    get bookmark_uri(bookmark)
    status.must_equal 200
    link_rels.must_include(:'doc:delete')

    follow_rel(:'doc:delete', method: :delete)
    status.must_equal 204

    get bookmark_uri(bookmark)
    status.must_equal 404
  end

end
