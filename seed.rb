require 'faker'

10.times do
  user = User.create(name: Faker::Name.first_name)
  rand(10).times do
    user.add_post(
      title: Faker::TvShows::FamilyGuy.character,
      message: Faker::TvShows::FamilyGuy.quote
    )
  end
end
