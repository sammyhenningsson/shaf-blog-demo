require 'serializers/base_serializer'
require 'policies/post_policy'

class PostSerializer < BaseSerializer

  model Post
  policy PostPolicy

  # FIXME: Write documentation for attribute :title
  attribute :title

  # FIXME: Write documentation for attribute :message
  attribute :message

  # Auto generated doc:  
  # Link to the documentation for a given relation of the post resource.
  # This link is templated, which means that {rel} must be replaced by the
  # appropriate relation name.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      /doc/post/rels/delete
  #```
  curie :doc do
    doc_curie_uri('post')
  end

  # Auto generated doc:  
  # Link to the collection of all posts. Send a POST request to this uri to create a new post.  
  # Method: GET or POST  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /posts
  #```
  link :"doc:up" do
    posts_uri
  end

  # Auto generated doc:  
  # Link to this post.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /posts/5
  #```
  link :self do
    post_uri(resource)
  end

  # Auto generated doc:  
  # Link to a form to edit this resource.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /posts/5/edit
  #```
  link :"doc:edit-form" do
    edit_post_uri(resource)
  end

  # Auto generated doc:  
  # Link to delete this post.  
  # Method: DELETE  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      -X DELETE \
  #      /posts/5
  #```
  link :"doc:delete" do
    post_uri(resource)
  end

  # Link to the user who authored this post.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /posts/5/author
  #```
  link :"doc:author" do
    user_uri(resource.user)
  end

  # Link to add a bookmark for this post.  
  # Method: PUT  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      -X PUT \
  #      /posts/5/bookmark
  #```
  link :"doc:bookmark" do
    bookmark_post_uri(resource)
  end

  # Link to remove an exsisting bookmark for this post.  
  # Method: DELETE  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      -X DELETE \
  #      /posts/5/bookmark
  #```
  link :"doc:remove_bookmark" do
    bookmark_post_uri(resource)
  end

  collection of: 'posts' do
    curie(:doc) { doc_curie_uri('post') }

    link :self, posts_uri
    link :'doc:up', root_uri

    # Auto generated doc:  
    # Link to a form used to create new post resources.  
    # Method: GET  
    # Example:
    # ```
    # curl -H "Accept: application/hal+json" \
    #      -H "Authorization: abcdef \"
    #      /posts/form
    #```
    link :"doc:create-form" do
      new_post_uri
    end
  end
end
