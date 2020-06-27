5.times do |i|
  Post.create(title: "title#{i}", body: "body#{i}")
end

rails db:migrate:reset
rails db:seed
rails db
select * from posts where id = 1;