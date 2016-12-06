# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# generate data for user
User.create!(name: "example user",
			 email: "example@gmail.org",
			 password: "foobar",
			 password_confirmation: "foobar",
			 admin: true)
99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@gmail.org"
	password = "password"
	User.create!(name: name,
				 email: email,
				 password: password,
				 password_confirmation: password)
end

# generate data for category
Category.create!(name: "example category")
10.times do |n|
	category = "exCategory#{n+1}"
	Category.create!(name: category)
end

# generate data for product
Product.create!(name: "example product",
				price: 50.00,
				amount: 100)
98.times do |n|
	name = Faker::Commerce.product_name
	price = Faker::Commerce.price
	amount = 100
	Product.create!(name: name,
					price: price,
					amount: amount)
end

# generate data for classify
categories = Category.all
products = Product.all
products.each do |product|
	id = categories.sample.id
	Classify.create!(product_id: product.id, category_id: id)
end

# generate data for order
users = User.order(:created_at).take(20)
users.each do |user|
  id = products.sample.id
	user.orders.create!()
  user.orders.first.order_details.create!(amount: 1, product_id: id)
end

# generate data for order detail