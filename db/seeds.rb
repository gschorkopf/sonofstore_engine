stores = [
  Store.create(name: 'Best Sunglasses', path: 'best-sunglasses', description: 'Buy our Sunglasses'),
  Store.create(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'Buy our COOL Sunglasses'),
  Store.create(name: "Speedy Bikes", path: "speedy-bikes", description: "Put the fun between your legs!"),
  Store.create(name: "Cool Runnings", path: "cool-runnings", description: "You'll come back tomorrow and the next day and the next day and the next day."),
  Store.create(name: "Banana Hut", path: "banana-hut", description: "There's money in the hut!"),
  Store.create(name: "Florist-Gump", path: "florist-gump", description: "Life's not like a box of chocolates here.  What you see is what you get!"),
  Store.create(name: "World of Woolcraft", path: "world-of-woolcraft", description: "Knitting's no joke"),
  Store.create(name: "Frank's Monsterporium", path: "monsterporium", description: "Monster?  Maybe.  Cuddly?  Definitely."),
  Store.create(name: "Katrina's Refactorium", path: "refactorium", description: "Crazy code?  Yeah, we can work with it."),
  Store.create(name: "Jeff's Developer Warehouse", path: "developer-warehouse", description: "Tons of crazy kids... who work for free!")
]

10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 1)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 2)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 3)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 4)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 5)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 6)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 7)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 8)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 9)
end
10.times do
  Category.create(title: Faker::Lorem.words[0], store_id: 10)
end


1000.times do
  cat_id = rand(1...90)
  Product.create(title: Faker::Address.street_name.split[0], description: "#{Faker::Company.bs} " + "#{Faker::Company.bs}", price: rand(1...5000), status: 'active', store_id: rand(1...10), category_ids: [cat_id])
end

#Product.create(title: "Schwinn 10 Speed", description: "This bike will really knock your socks off!  Not one, not two, but TEN SPEEDS!", price: 125.99, status: 'active', store_id: 3, category_ids: [5, 6])
#Product.create(title: "Hello Kitty Lunchbox", description: "I belong in Hello Kitty Hell", price: 10.78, status: "active", store_id: 1, category_ids: [1])


customer1 = Customer.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com")
customer2 = Customer.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com")
customer3 = Customer.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com")
customer4 = Customer.create(full_name: "Katrina", email: "demoXX+katrina@jumpstartlab.com")

user1 = User.create(password: "password", customer_id: customer1.id)
user2 = User.create(password: "password", display_name: "j3", customer_id: customer2.id)
user3 = User.create(password: "password", display_name: "SkrilleX", customer_id: customer3.id)
user4 = User.create(password: "password", display_name: "Norway", customer_id: customer4.id)

ur2 = UserRole.new
ur2.user_id = 2
ur2.role = "stocker"
ur2.save
user3.platform_admin = true
user3.save

n = 1
10.times do
ur4 = UserRole.new
ur4.user_id = 4
ur4.role = "store_admin"
ur4.store_id = n
ur4.save
n += 1
end
