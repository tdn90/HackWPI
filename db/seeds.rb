# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find(1)

group = Group.create(admin: user, name: "Test Group")
group.save!
group.users << user

group.save!

receipt = Receipt.create(name: 'Day 1', description: "Hello", user: user, group: group)
receipt.save!
receipt2 = Receipt.create(name: 'Day 2', description: "Hello2", user: user, group: group)
receipt2.save!

line1 = LineItem.create(receipt: receipt2, item: "Milk", price: 5)
line2 = LineItem.create(receipt: receipt2, item: "Cereal", price: 6)
line1.save!
line2.save!

#tag1 = LineItemUser.create(Lineitem: line1, user: user, status: 0)
#tag2 = LineItemUser.create(line_item_id: line2, user: user, status: 1)
#tag1.save!
#tag2.save!


#entry_match = Group_user.




