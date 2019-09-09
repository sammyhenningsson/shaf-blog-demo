class BasePolicy
  include HALPresenter::Policy::DSL

  def authenticated?
    !!current_user&.id
  end

  def owner?(user_id)
    return false unless authenticated?
    return false unless user_id

    current_user.id == user_id
  end
end
