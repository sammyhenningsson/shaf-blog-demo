require 'policies/bookmark_policy'

class BookmarksController < BaseController

  authorize_with BookmarkPolicy

  resource_uris_for :bookmark

  get :bookmarks_path do
    authorize! :read
    collection = paginate(Bookmark.order(:created_at).reverse)
    respond_with_collection collection, serializer: BookmarkSerializer
  end

  get :bookmark_path do
    authorize! :read
    respond_with bookmark
  end

  delete :bookmark_path do
    authorize! :write
    bookmark.destroy
    status 204
  end

  def bookmark_params
    safe_params(:user_id, :post_id)
  end

  def bookmark
    @bookmark ||= Bookmark[params['id']].tap do |bookmark|
      raise NotFoundError.new(clazz: Bookmark, id: params['id']) unless bookmark
    end
  end
end
