Sequel.migration do
  change do
    create_table(:bookmarks) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      foreign_key :user_id, :users
      foreign_key :post_id, :posts
    end
  end
end
