require 'policies/base_policy'

class UserPolicy < BasePolicy

  # Auto generated policy: Update this file to suite your API!
 
  alias :user :resource

  attribute :name

  link :up, :'create-form', :posts

  link :'edit-form', :delete do
    write?
  end

  def read?
    true
  end

  def write?
    owner? user&.id
  end
end
