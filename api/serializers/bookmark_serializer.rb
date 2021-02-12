require 'serializers/base_serializer'
require 'policies/bookmark_policy'

class BookmarkSerializer < BaseSerializer

  model Bookmark
  policy BookmarkPolicy
  profile :bookmark

  attribute :post_title do
    resource.post.title
  end

  curie :doc do
    doc_curie_uri('bookmark')
  end

  link :collection, embed_depth: 0 do
    bookmarks_uri
  end

  link :self do
    bookmark_uri(resource)
  end

  link :"doc:delete" do
    bookmark_uri(resource)
  end

  link :"doc:user" do
    user_uri(resource.user_id)
  end

  link :"doc:post" do
    post_uri(resource.post_id)
  end

  collection of: 'bookmarks' do
    curie(:doc) { doc_curie_uri('bookmark') }

    link :self, bookmarks_uri
    link :up, root_uri

    link :"create-form" do
      new_bookmark_uri
    end
  end
end
