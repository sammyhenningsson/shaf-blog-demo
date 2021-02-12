require 'serializers/base_serializer'
require 'policies/user_policy'

class UserSerializer < BaseSerializer

  model User
  policy UserPolicy
  profile :user

  attribute :name

  curie :doc do
    doc_curie_uri('user')
  end

  link :collection, embed_depth: 0 do
    users_uri
  end

  link :self do
    user_uri(resource)
  end

  link :"edit-form" do
    edit_user_uri(resource)
  end

  link :"doc:delete" do
    user_uri(resource)
  end

  link :"doc:posts" do
    user_posts_uri(resource)
  end
  
  link :"doc:bookmarks" do
    user_bookmarks_uri(resource)
  end

  collection of: 'users' do
    curie(:doc) { doc_curie_uri('user') }

    link :self, users_uri
    link :up, root_uri
    link :"create-form" do
      new_user_uri
    end
  end
end
