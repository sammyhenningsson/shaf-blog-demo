Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id
      foreign_key :user_id, :users, index: true
      DateTime :created_at
      DateTime :updated_at
      String :title
      String :message
    end
  end
end
