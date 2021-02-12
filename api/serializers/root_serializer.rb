require 'serializers/base_serializer'

class RootSerializer < BaseSerializer
  profile :root

  attribute :description, <<~DESC
    This is a demo of an API created with the Shaf framework.
    It's a simple blog where users can create and read posts.
    Bookmarks can be added for posts that are interesting.
    All actions are driven by hypermedia links.
    Authentication is done by sending the user name in
    the X-Auth-Token header (this only a demo...)
  DESC

  link :self, root_uri
  link :users, users_uri
  link :posts, posts_uri
end
