require 'policies/base_policy'

class PostPolicy < BasePolicy

  # Auto generated policy: Update this file to suite your API!
 
  alias :post :resource

  attribute :title
  attribute :message

  link :up

  link :author do
    UserPolicy.new(current_user, post.user).read? 
  end

  link :'create-form' do
    create?
  end

  link :'edit-form', :delete do
    write?
  end

  def read?
    true
  end

  def write?
    owner? post&.user_id
  end

  def create?
    authenticated?
  end
end
