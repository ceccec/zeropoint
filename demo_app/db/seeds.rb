# frozen_string_literal: true

# Seed Users
puts 'Seeding users...'
users = []
5.times do |i|
  users << User.create!(
    email: "user#{i + 1}@example.com",
    username: "user#{i + 1}",
    password: 'password',
    password_confirmation: 'password',
    email_confirmed_at: Time.current,
    first_name: "First#{i + 1}",
    last_name: "Last#{i + 1}",
    bio: "This is user #{i + 1}'s bio.",
  )
end
admin = User.create!(
  email: 'admin@example.com',
  username: 'admin',
  password: 'password',
  password_confirmation: 'password',
  email_confirmed_at: Time.current,
  first_name: 'Admin',
  last_name: 'User',
  bio: 'Admin user bio.',
)
admin.add_role(:admin)

# Seed Posts
puts 'Seeding posts...'
20.times do |i|
  Post.create!(
    user: users.sample,
    title: "Sample Post #{i + 1}",
    content: "This is the content for post #{i + 1}. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    status: %w[published draft archived].sample,
    views: rand(0..100),
  )
end

# Seed Comments
puts 'Seeding comments...'
Post.find_each do |post|
  rand(2..5).times do
    Comment.create!(
      user: users.sample,
      post: post,
      content: "This is a comment on #{post.title}",
    )
  end
end

# Seed Likes
puts 'Seeding likes...'
Post.find_each do |post|
  users.sample(rand(1..3)).each do |user|
    Like.create!(user: user, post: post) unless post.liked_by?(user)
  end
end

# Seed Follows
puts 'Seeding follows...'
users.each do |user|
  (users - [ user ]).sample(2).each do |other|
    Follow.create!(follower: user, followed: other) unless user.following?(other)
  end
end

# Seed Tags
puts 'Seeding tags...'
Post.find_each do |post|
  post.tag_list.add(%w[ruby rails graphql ui demo].sample(2))
  post.save!
end

puts 'Seeding complete.'
