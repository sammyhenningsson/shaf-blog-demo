require 'serializers/base_serializer'
require 'policies/post_policy'

class PostSerializer < BaseSerializer

  model Post
  policy PostPolicy
  profile :post

  attribute :title

  attribute :message

  curie :doc do
    doc_curie_uri('post')
  end

  link :collection, embed_depth: 0 do
    posts_uri
  end

  link :self do
    post_uri(resource)
  end

  link :"edit-form" do
    edit_post_uri(resource)
  end

  link :"doc:delete" do
    post_uri(resource)
  end

  link :"doc:author" do
    user_uri(resource.user)
  end

  link :"doc:bookmark" do
    bookmark_post_uri(resource)
  end

  link :"doc:remove_bookmark" do
    bookmark_post_uri(resource)
  end

  collection of: 'posts' do
    curie(:doc) { doc_curie_uri('post') }

    link :self, posts_uri
    link :up, root_uri

    link :"create-form" do
      new_post_uri
    end
  end
end
