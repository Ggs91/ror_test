Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

Like.reset_pk_sequence
Comment.reset_pk_sequence
Post.reset_pk_sequence
User.reset_pk_sequence

u1 = User.create!

50.times do
  User.create!
end

p1 = Post.create!(
  user: u1,
  description: "My first post !"
)

100.times do |i|
  Comment.create!(
    user: User.find(rand(1..50)),
    post: p1,
    content: "Great post !"
  )
end

Comment.all.each do |comment|
  5.times do |i|
    Like.create!(
      user: User.find(rand(1..50)),
      likeable: comment
    )
  end
end

puts "-----#{User.all.size} Users created-----"
puts "-----#{Post.all.size} Posts created-----"
puts "-----#{Comment.all.size} Comments created-----"
puts "-----#{Like.all.size} Likes created-----"
