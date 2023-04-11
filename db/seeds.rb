# creating users
# (0..10).each do
#     User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone: "1", password: "password", username: Faker::Internet.username)
# end

# # creating a list of categories
# Category.create(name: 'Leadership')
# Category.create(name: 'Time Management')
# Category.create(name: 'Goal-Setting')
# Category.create(name: 'Communicaiton')
# Category.create(name: 'Networking')
# Category.create(name: 'Emotional Intelligence')
# Category.create(name: 'Learning and Development')
# Category.create(name: 'Career Development')
# Category.create(name: 'Personal Development')

# create blogs
# - category
# - user
# - blog info

(0..100).each do |i|
    faker_title = Faker::Hacker.noun.capitalize + " " + Faker::Hacker.verb.capitalize
    faker_sub_title = Faker::Lorem.sentence
    num_paragraphs = rand(1..5)
    parapraphs = " "
    num_paragraphs.times do
        paragraphs += Faker::Lorem.paragraph(sentence_count:3) + "\n\n"
    end

    blog = blog.new(user_id: rand(1..10), title: faker_title, sub_title: faker_sub_title, content: paragraphs, image_path: "https://positive.b-cdn.net/wp-content/uploads/applying-flourishing.jpg")

    blog.categories = Category.all.sample(rand(0..6))
    blog.save 
end


