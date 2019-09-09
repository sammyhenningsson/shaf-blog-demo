require 'spec_helper'

describe Post, type: :integration do

  it "returns a post" do
    post = Post.create
    get post_uri(post)
    status.must_equal 200
    link_rels.must_include(:self)
    links[:self][:href].must_equal post_uri(post)
    attributes.must_include(:'title')
    attributes.must_include(:'message')
  end

  it "lists all posts" do
    Post.create
    Post.create

    get posts_uri
    status.must_equal 200
    link_rels.must_include(:self)
    links[:self][:href].must_include posts_uri
    embedded(:'posts').size.must_equal 2

    each_embedded :'posts' do
      link_rels.must_include(:self)
      attributes.must_include(:'title')
      attributes.must_include(:'message')
    end
  end

  it "can create posts" do
    get posts_uri

    link_rels.must_include(:'doc:create-form')
    follow_rel :'doc:create-form'
    links[:self][:href].must_equal new_post_uri
    attributes[:href].must_equal posts_uri
    attributes[:method].must_equal "POST"
    attributes[:name].must_equal "create-post"
    attributes[:title].must_equal "Create Post"
    attributes[:type].must_equal "application/json"
    attributes[:fields].size.must_equal 2

    payload = fill_form attributes[:fields]
    post attributes[:href], payload
    status.must_equal 201
    link_rels.must_include(:self)
    headers["Location"].must_equal links[:self][:href]

    get posts_uri
    status.must_equal 200
    links[:self][:href].must_include posts_uri
    embedded(:'posts').size.must_equal 1

    embedded :'posts' do
      post = last_payload.first
      post[:title].must_equal "value for title"
      post[:message].must_equal "value for message"
    end
  end

  it "posts can be updated" do
    post = Post.create
    get post_uri(post)
    status.must_equal 200

    link_rels.must_include(:'doc:edit-form')
    follow_rel :'doc:edit-form'

    links[:self][:href].must_equal edit_post_uri(post)
    attributes[:href].must_equal post_uri(post)
    attributes[:method].must_equal "PUT"
    attributes[:name].must_equal "update-post"
    attributes[:title].must_equal "Update Post"
    attributes[:type].must_equal "application/json"
    attributes[:fields].size.must_equal 2

    payload = fill_form attributes[:fields]
    put attributes[:href], payload
    status.must_equal 200
    link_rels.must_include(:self)
  end

  it "posts can be deleted" do
    post = Post.create
    get post_uri(post)
    status.must_equal 200
    link_rels.must_include(:'doc:delete')

    follow_rel(:'doc:delete', method: :delete)
    status.must_equal 204

    get post_uri(post)
    status.must_equal 404
  end

end
