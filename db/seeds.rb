User.create! name: "Sub22",
             email: "sub22@gmail.com",
             password: "123456789",
             password_confirmation: "123456789",
             admin: true,
             activated: true,
             activated_at: Time.zone.now
50.times do |n|
name = "Tung0#{n+1}"
email = "example-#{n+1}@gmail.com"
password = "password"
User.create! name: name,
             email: email,
             password: password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now
end

users = User.order(:created_at).take(6)
50.times do
  content = "This is my content, follow me"
  users.each { |user| user.microposts.create!(content: content) }
end
