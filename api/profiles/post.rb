module Profiles
  class Post < Shaf::Profile
    name 'post'

    use :delete, from: Shaf::Profiles::ShafBasic

    attribute :title,
              type: String,
              doc: 'The title of the post'

    attribute :message,
              type: String,
              doc: 'The body of the post'

    relation :bookmark,
             http_method: :put,
             doc: 'Link to add a bookmark for this post'

    relation :remove_bookmark,
             http_method: :delete,
             doc: 'Link to remove an exsisting bookmark for this post'
  end
end
