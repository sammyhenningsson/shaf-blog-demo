require 'policies/base_policy'

class UserPolicy < BasePolicy

  # Auto generated policy: Update this file to suite your API!
 
  alias :user :resource

  attribute :name

  link :collection, :'create-form', :up, :posts

  link :'edit-form', :delete do
    write?
  end

  link :bookmarks do
    read?
  end

  def read?
    true
  end

  def write?
    owner? user&.id
  end
end
