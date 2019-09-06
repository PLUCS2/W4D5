FactoryBot.define do
  factory :user do
      username {Faker::Music.band}
      password {'starwars'}
  end

end