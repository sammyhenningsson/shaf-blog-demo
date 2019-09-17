require 'serializers/base_serializer'
require 'policies/user_policy'

class UserSerializer < BaseSerializer

  model User
  policy UserPolicy

  # FIXME: Write documentation for attribute :name
  attribute :name

  # Auto generated doc:  
  # Link to the documentation for a given relation of the user resource.
  # This link is templated, which means that {rel} must be replaced by the
  # appropriate relation name.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      /doc/user/rels/delete
  #```
  curie :doc do
    doc_curie_uri('user')
  end

  # Auto generated doc:  
  # Link to the collection of all users. Send a POST request to this uri to create a new user.  
  # Method: GET or POST  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /users
  #```
  link :collection do
    users_uri
  end

  # Auto generated doc:  
  # Link to this user.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /users/5
  #```
  link :self do
    user_uri(resource)
  end

  # Auto generated doc:  
  # Link to a form to edit this resource.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /users/5/edit
  #```
  link :"doc:edit-form" do
    edit_user_uri(resource)
  end

  # Auto generated doc:  
  # Link to delete this user.  
  # Method: DELETE  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      -X DELETE \
  #      /users/5
  #```
  link :"doc:delete" do
    user_uri(resource)
  end

  # Link to all posts written by this user
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /users/5/posts
  #```
  link :"doc:posts" do
    user_posts_uri(resource)
  end
  
  # Link to the users bookmarks   
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef" \
  #      /users/5/bookmarks
  #```
  link :"doc:bookmarks" do
    user_bookmarks_uri(resource)
  end

  collection of: 'users' do
    curie(:doc) { doc_curie_uri('user') }

    link :self, users_uri
    link :'doc:up', root_uri

    # Auto generated doc:  
    # Link to a form used to create new user resources.  
    # Method: GET  
    # Example:
    # ```
    # curl -H "Accept: application/hal+json" \
    #      -H "Authorization: abcdef \"
    #      /users/form
    #```
    link :"doc:create-form" do
      new_user_uri
    end
  end
end
