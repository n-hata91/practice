5.times do |i|
  Post.create(title: "title#{i}", body: "body#{i}")
end