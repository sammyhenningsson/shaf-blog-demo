require 'serializers/base_serializer'

class RootSerializer < BaseSerializer

  # Auto generated doc:  
  # Link to the root resource. All clients should fetch this resource
  # when starting to interact with this API.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/json" \
  #      -H "Authorization: abcdef" \
  #      /
  #```
  link :self, root_uri
  
  # Auto generated doc:  
  # Link to the collection of users.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef" \
  #      /users
  #```
  link :users, users_uri
  
  # Auto generated doc:  
  # Link to the collection of posts.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef" \
  #      /posts
  #```
  link :posts, posts_uri
end
