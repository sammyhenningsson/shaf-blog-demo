require 'spec_helper'

describe User, type: :integration do

  it "returns a user" do
    user = User.create
    get user_uri(user)
    status.must_equal 200
    link_rels.must_include(:self)
    links[:self][:href].must_equal user_uri(user)
    attributes.must_include(:'name')
  end

  it "lists all users" do
    User.create
    User.create

    get users_uri
    status.must_equal 200
    link_rels.must_include(:self)
    links[:self][:href].must_include users_uri
    embedded(:'users').size.must_equal 2

    each_embedded :'users' do
      link_rels.must_include(:self)
      attributes.must_include(:'name')
    end
  end

  it "can create users" do
    get users_uri

    link_rels.must_include(:'doc:create-form')
    follow_rel :'doc:create-form'
    links[:self][:href].must_equal new_user_uri
    attributes[:href].must_equal users_uri
    attributes[:method].must_equal "POST"
    attributes[:name].must_equal "create-user"
    attributes[:title].must_equal "Create User"
    attributes[:type].must_equal "application/json"
    attributes[:fields].size.must_equal 1

    payload = fill_form attributes[:fields]
    post attributes[:href], payload
    status.must_equal 201
    link_rels.must_include(:self)
    headers["Location"].must_equal links[:self][:href]

    get users_uri
    status.must_equal 200
    links[:self][:href].must_include users_uri
    embedded(:'users').size.must_equal 1

    embedded :'users' do
      user = last_payload.first
      user[:name].must_equal "value for name"
    end
  end

  it "users can be updated" do
    user = User.create
    get user_uri(user)
    status.must_equal 200

    link_rels.must_include(:'doc:edit-form')
    follow_rel :'doc:edit-form'

    links[:self][:href].must_equal edit_user_uri(user)
    attributes[:href].must_equal user_uri(user)
    attributes[:method].must_equal "PUT"
    attributes[:name].must_equal "update-user"
    attributes[:title].must_equal "Update User"
    attributes[:type].must_equal "application/json"
    attributes[:fields].size.must_equal 1

    payload = fill_form attributes[:fields]
    put attributes[:href], payload
    status.must_equal 200
    link_rels.must_include(:self)
  end

  it "users can be deleted" do
    user = User.create
    get user_uri(user)
    status.must_equal 200
    link_rels.must_include(:'doc:delete')

    follow_rel(:'doc:delete', method: :delete)
    status.must_equal 204

    get user_uri(user)
    status.must_equal 404
  end

end
