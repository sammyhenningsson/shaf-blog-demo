Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      String :name, unique: true
      String :auth_token_digest, unique: true
    end
  end
end
