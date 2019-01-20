# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find(1)
user2 = User.find(2)

group = Group.create(admin: user, name: "Test Group")
group.save!
group.users << user
group.users << user2

group2 = Group.create(admin: user2, name: "Test Group 2")
group2.save!
group2.users << user
group2.users << user2

receipt = Receipt.create(name: 'Day 1', description: "Hello", user: user, group: group)
receipt.save!
receipt2 = Receipt.create(name: 'Day 2', description: "Hello2", user: user2, group: group2)
receipt2.save!
receipt = Receipt.create(name: 'Day 3', description: "Hello", user: user, group: group)
receipt.save!
receipt2 = Receipt.create(name: 'Day 4', description: "Hello2", user: user2, group: group2)
receipt2.save!


line1 = LineItem.create(receipt: receipt2, item: "Milk", price: 5)
line2 = LineItem.create(receipt: receipt2, item: "Cereal", price: 6)
line1.save!
line2.save!


line3 = LineItem.create(receipt: receipt, item: "Milk", price: 5)
line4 = LineItem.create(receipt: receipt, item: "Cereal", price: 6)
line3.save!
line4.save!

tag1 = Assigntable.create(line_item_id: line1.id, user: user, status: 0)
tag2 = Assigntable.create(line_item_id: line2.id, user: user2, status: 0)
tag3 = Assigntable.create(line_item_id: line3.id, user: user, status: 0)
tag4 = Assigntable.create(line_item_id: line4.id, user: user2, status: 0)
tag1.save!
tag2.save!
tag3.save!
tag4.save!
#tag1 = LineItemUser.crearakete(Lineitem: line1, user: user, status: 0)
#tag2 = LineItemUser.create(line_item_id: line2, user: user, status: 1)
#tag1.save!
#tag2.save!


#entry_match = Group_user.




