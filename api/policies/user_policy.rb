require 'policies/base_policy'

class UserPolicy < BasePolicy

  # Auto generated policy: Update this file to suite your API!
 
  alias :user :resource

  attribute :name

  link :up, :'create-form'

  link :'edit-form', :delete do
    write?
  end

  def read?
    true
  end

  def write?
    return false unless current_user && user
    current_user.id == user.id
  end
end
