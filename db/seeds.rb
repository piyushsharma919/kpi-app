puts 'Seeding data...'

User.destroy_all

password = BCrypt::Password.create('password')

User.create!(
  email_address: 'one@example',
  password_digest: password
)

5.times do
  User.create!(
    email_address: Faker::Internet.unique.email,
    password_digest: password
  )
end

puts '✅ Done seeding.'
