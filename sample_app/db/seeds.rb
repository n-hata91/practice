#ユーザ
User.create!(name: "Example User",
            email: "example@railstutorial.org",
            password: "foobar",
            password_confirmation: "foobar",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

#マイクロポスト
users = User.order(:created_at).take(6) #takeメソッドで最初の6人だけにポストを追加
36.times do #36post分を追加
  content = Faker::Lorem.sentence(1) #引数は文字の長さ？
  users.each { |user| user.microposts.create!(content: content)}
end

#リレーションシップ
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed)}
followers.each { |follower| follower.follow(user)}