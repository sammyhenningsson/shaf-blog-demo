require 'policies/user_policy'

class UsersController < BaseController

  authorize_with UserPolicy

  resource_uris_for :user
  register_uri :user_posts, '/users/:id/posts'
  register_uri :user_bookmarks, '/users/:id/bookmarks'

  get :users_path do
    authorize! :read
    collection = paginate(User.order(:created_at))
    respond_with_collection collection, serializer: UserSerializer
  end

  get :new_user_path do
    authorize! :read
    cache_control(:private, http_cache_max_age: :short)
    respond_with create_form
  end

  post :users_path do
    authorize! :read
    user = User.create(user_params)
    headers('Location' => user_uri(user))
    respond_with user, status: 201
  end

  get :user_path do
    authorize! :read
    cache_control(:private, http_cache_max_age: :short)
    respond_with user
  end

  get :edit_user_path do
    authorize! :write, user
    cache_control(:private, http_cache_max_age: :short)
    respond_with edit_form
  end

  put :user_path do
    authorize! :write, user
    user.update(user_params)
    respond_with user
  end

  delete :user_path do
    authorize! :write, user
    user.destroy
    status 204
  end

  get :user_posts_path do
    authorize! :read
    user_id = params[:id].to_i
    posts = paginate(Post.where(user_id: user_id))
    respond_with_collection posts, serializer: PostSerializer
  end

  get :user_bookmarks_path do
    authorize! :read
    user_id = params[:id].to_i
    bookmarks = paginate(Bookmark.where(user_id: user_id))
    respond_with_collection bookmarks, serializer: BookmarkSerializer
  end

  def user_params
    safe_params(:name)
  end

  def user
    @user ||= User[params['id']].tap do |user|
      raise NotFoundError.new(clazz: User, id: params['id']) unless user
    end
  end

  def create_form
    User.create_form.tap do |form|
      form.self_link = new_user_uri
      form.href = users_uri
    end
  end

  def edit_form
    user.edit_form.tap do |form|
      form.self_link = edit_user_uri(user)
      form.href = user_uri(user)
    end
  end
end
