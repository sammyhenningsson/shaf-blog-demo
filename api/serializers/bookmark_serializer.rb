require 'serializers/base_serializer'
require 'policies/bookmark_policy'

class BookmarkSerializer < BaseSerializer

  model Bookmark
  policy BookmarkPolicy

  # The title of the post
  attribute :post_title do
    resource.post.title
  end
  # Auto generated doc:  
  # Link to the documentation for a given relation of the bookmark resource.
  # This link is templated, which means that {rel} must be replaced by the
  # appropriate relation name.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      /doc/bookmark/rels/delete
  #```
  curie :doc do
    doc_curie_uri('bookmark')
  end

  # Auto generated doc:  
  # Link to the collection of all bookmarks. Send a POST request to this uri to create a new bookmark.  
  # Method: GET or POST  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /bookmarks
  #```
  link :collection do
    bookmarks_uri
  end

  # Auto generated doc:  
  # Link to this bookmark.  
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /bookmarks/5
  #```
  link :self do
    bookmark_uri(resource)
  end

  # Auto generated doc:  
  # Link to delete this bookmark.  
  # Method: DELETE  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      -X DELETE \
  #      /bookmarks/5
  #```
  link :"doc:delete" do
    bookmark_uri(resource)
  end

  # Link to the user who owns this bookmark
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /users/5
  #```
  link :"doc:user" do
    user_uri(resource.user_id)
  end

  # Link to the post that this bookmark is for
  # Method: GET  
  # Example:
  # ```
  # curl -H "Accept: application/hal+json" \
  #      -H "Authorization: abcdef \"
  #      /posts/5
  #```
  link :"doc:post" do
    post_uri(resource.post_id)
  end

  collection of: 'bookmarks' do
    curie(:doc) { doc_curie_uri('bookmark') }

    link :self, bookmarks_uri
    link :up, root_uri

    # Auto generated doc:  
    # Link to a form used to create new bookmark resources.  
    # Method: GET  
    # Example:
    # ```
    # curl -H "Accept: application/hal+json" \
    #      -H "Authorization: abcdef \"
    #      /bookmarks/form
    #```
    link :"create-form" do
      new_bookmark_uri
    end
  end
end
