puts 'Seeding data...'

# Create Company Roles
employer_role = CompanyRole.find_or_create_by!(name: 'employer') do |role|
  role.description = 'Owner or admin of the company'
  role.active = true
end

employee_role = CompanyRole.find_or_create_by!(name: 'employee') do |role|
  role.description = 'Standard employee role'
  role.active = true
end

# Create Users with Profiles
users = []
password = BCrypt::Password.create('password')

# Create admin user
admin = User.create!(
  email_address: 'admin@example.com',
  password_digest: password
)
admin.profile.update!(
  name: 'Admin User',
  bio: 'System Administrator',
  location: 'New York, NY',
  website: 'https://example.com'
)
users << admin

# Create employer users
2.times do |i|
  user = User.create!(
    email_address: "employer#{i + 1}@example.com",
    password_digest: password
  )
  user.profile.update!(
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraph,
    location: "#{Faker::Address.city}, #{Faker::Address.state}",
    website: Faker::Internet.url
  )
  users << user
end

# Create employee users
5.times do |i|
  user = User.create!(
    email_address: Faker::Internet.unique.email,
    password_digest: password
  )
  user.profile.update!(
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraph,
    location: "#{Faker::Address.city}, #{Faker::Address.state}",
    website: Faker::Internet.url
  )
  users << user
end

# Create Companies
companies = []
2.times do |i|
  company = Company.create!(
    name: Faker::Company.name,
    website: Faker::Internet.url,
    logo_url: Faker::Internet.url,
    owner: users[i + 1], # Assign to employer users
    active: true,
    settings: {
      theme: 'light',
      notifications: true,
      timezone: 'UTC'
    }
  )
  companies << company
end

# Create Company Users (associations)
# Assign employers to companies
companies.each_with_index do |company, index|
  CompanyUser.create!(
    company: company,
    user: company.owner,
    company_role: employer_role,
  )
end

# Assign employees to companies
users[3..-1].each do |user|
  company = companies.sample
  CompanyUser.create!(
    company: company,
    user: user,
    company_role: employee_role,
  )
end


puts "Created #{CompanyRole.count} company roles"
puts "Created #{User.count} users with profiles"
puts "Created #{Company.count} companies"
puts "Created #{CompanyUser.count} company-user associations"
puts "Created #{CompanyUser.employers.count} employer associations"
puts "Created #{CompanyUser.employees.count} employee associations"
puts '✅ Done seeding.'
