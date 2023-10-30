require 'faker'

5.times do
  name = Faker::Name.first_name
  loop do
    break if name.size > 2
    name = Faker::Name.first_name
  end

  user = User.create(name: name)
  rand(10).times do
    user.add_post(
      title: Faker::TvShows::FamilyGuy.character,
      message: Faker::TvShows::FamilyGuy.quote
    )
  end
end
