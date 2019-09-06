class UserForms
  extend Shaf::Formable

  forms_for(User) do
    field :name, type: "string", required: true

    create do
      title 'Create User'
      name  'create-user'
    end
  end
end

