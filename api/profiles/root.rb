module Profiles
  class Root < Shaf::Profile
    name 'root'

    doc <<~DESC
      This is a demo of an API created with the Shaf framework.
      It's a simple blog where users can create and read posts.
      Bookmarks can be added for posts that are interesting.
      All actions are driven by hypermedia links.
      Authentication is done using Basic Auth by sending the user name and
      an empty password (this only for demo purposes..)
    DESC

    relation :users,
             http_method: :get,
             doc: 'Link to the collection of all users'

    relation :users,
             http_method: :get,
             doc: 'Link to the collection of all posts'
  end
end
