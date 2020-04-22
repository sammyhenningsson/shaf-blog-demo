require 'serializers/base_serializer'

class RootSerializer < BaseSerializer

  # A description of this API
  attribute :description, <<~DESC
    This is a demo of an API created with the Shaf framework.
    It's a simple blog where users can create and read posts.
    Bookmarks can be added for posts that are interesting.
    All actions are driven by hypermedia links.
    Authentication is done by sending the user name in
    the X-Auth-Token header (this only a demo...)
  DESC

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
