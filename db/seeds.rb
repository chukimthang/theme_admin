unless User.find_by(email: "super_admin@gmail.com")
  user = User.new(
    id: 1,
    email: "super_admin@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    role: User.roles[:super_admin]
  )
  user.save

  Profile.create(full_name: "Super admin", user: user)
end

unless User.find_by(email: "chukimthang94@gmail.com")
  user = User.new(
    id: 2,
    email: "chukimthang94@gmail.com",
    password: "123456",
    password_confirmation: "123456"
  )
  user.save

  Profile.create(full_name: "Chu Kim Thang", user: user)
end

CONSTANT::HOBBIES.each do |value|
  Hobby.find_or_create_by(name: value)
end
