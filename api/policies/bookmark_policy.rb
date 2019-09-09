require 'policies/base_policy'

class BookmarkPolicy < BasePolicy

  # Auto generated policy: Update this file to suite your API!
 
  alias :bookmark :resource

  attribute :post_title

  link :up, :user, :post

  link :'create-form', :'edit-form', :delete do
    write?
  end

  embed :post do
    owner? bookmark&.user_id
  end

  def read?
    true
  end

  def write?
    owner? bookmark&.user_id
  end
end
