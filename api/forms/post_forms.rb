class PostForms
  extend Shaf::Formable

  forms_for(Post) do
    field :title, type: "string", required: true
    field :message, type: "string"

    create do
      title 'Create Post'
      name  'create-post'
    end

    edit do
      instance_accessor
      title 'Update Post'
      name  'update-post'
    end
  end
end

