module Profiles
  class Bookmark < Shaf::Profile
    name 'bookmark'

    use :delete, from: Shaf::Profiles::ShafBasic

    attribute :post_title,
              type: String,
              doc: 'The title of the post'

    relation :user,
             http_method: :get,
             doc: 'Link to the user who owns this bookmark'

    relation :post,
             http_method: :get,
             doc: 'Link to the post that this bookmark is for'
  end
end
