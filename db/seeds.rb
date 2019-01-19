# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find(1)
receipt = Receipt.create(name: 'Day 1', description: "Hello", user: user)

line1 = Line_item.create(receipt, item: "Milk", price: 5)
line2 = Line_item.create(receipt, item: "Cereal", price: 6)

tag1 = Line_item_user.create(line_item: line1, user: user, status: 0)
tag2 = Line_item_user.create(line_item: line2, user: user, status: 1)



