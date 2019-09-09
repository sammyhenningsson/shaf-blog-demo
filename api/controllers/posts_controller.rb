require 'policies/post_policy'

class PostsController < BaseController

  authorize_with PostPolicy

  resource_uris_for :post
  register_uri :post_author, '/posts/:id/author'
  register_uri :bookmark_post, '/posts/:id/bookmark'

  get :posts_path do
    authorize! :read
    collection = paginate(Post.order(:created_at).reverse)
    respond_with_collection collection, serializer: PostSerializer
  end

  get :new_post_path do
    authorize! :read
    cache_control(:private, http_cache_max_age: :short)
    respond_with create_form
  end

  post :posts_path do
    authorize! :create
    post = Post.create(
      post_params.merge(user_id: current_user.id)
    )
    headers('Location' => post_uri(post))
    respond_with post, status: 201
  end

  get :post_path do
    authorize! :read
    respond_with post
  end

  get :edit_post_path do
    authorize! :write
    cache_control(:private, http_cache_max_age: :short)
    respond_with edit_form
  end

  put :post_path do
    authorize! :write
    post.update(post_params)
    respond_with post
  end

  delete :post_path do
    authorize! :write
    post.destroy
    status 204
  end

  get :post_author_path do
    authorize! :read
    respond_with post.user
  end

  put :bookmark_post_path do
    authorize! :bookmark
    post_id = params[:id].to_i
    bookmark = current_user.add_bookmark(post_id: post_id)

    headers('Location' => bookmark_uri(bookmark))
    respond_with bookmark, status: 201
  end

  delete :bookmark_post_path do
    authorize! :bookmark
    post_id = params[:id].to_i
    bookmark = Bookmark.first(post_id: post_id, user_id: current_user.id)
    raise NotFoundError.new(clazz: Bookmark) unless bookmark

    bookmark.destroy
    status 204
  end

  def post_params
    safe_params(:title, :message)
  end

  def post
    @post ||= Post[params['id']].tap do |post|
      raise NotFoundError.new(clazz: Post, id: params['id']) unless post
    end
  end

  def create_form
    Post.create_form.tap do |form|
      form.self_link = new_post_uri
      form.href = posts_uri
    end
  end

  def edit_form
    post.edit_form.tap do |form|
      form.self_link = edit_post_uri(post)
      form.href = post_uri(post)
    end
  end
end
