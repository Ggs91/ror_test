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
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

p1 = Post.create!(
  user: u1,
  description: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4)
)

100.times do |i|
  Comment.create!(
    user: User.find(rand(1..50)),
    post: p1,
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)
  )
end

Comment.all.each do |comment|
  random_likes_number = rand(0..5)
  random_likes_number.times do |i|
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
