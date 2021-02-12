module Profiles
  class User < Shaf::Profile
    name 'user'

    use :delete, from: Shaf::Profiles::ShafBasic

    attribute :name,
              type: String,
              doc: 'The name of the user'

    relation :posts,
             http_method: :get,
             doc: 'Link to the collection of all posts created by this user'

    relation :bookmarks,
             http_method: :get,
             doc: 'Link to the collection of all posts created by this user'
  end
end
