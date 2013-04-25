bucket_name = 'ballmer_dose'
s3 = AWS::S3.new

@b = s3.buckets[bucket_name]
def add_photo_to_product product, file_name
  object = @b.objects[file_name+".jpg"]
  product.image = object.url_for(:read)
end

packaging = Question.create!(question: "Packaging")
durability = Question.create!(question: "Durability")
value = Question.create!(question: "Value")
accuracy = Question.create!(question: "Description Accuracy")

customer = Customer.create!(email: "user1@dose.com",
                       full_name:"User 1")
user = User.new
user.customer = customer
user.password = "1234"
user.save!

heroes_and_villains = Store.new(name: 'Heroes & Villains',
              path: 'heroes-and-villains',
              description: 'Be a hero! Fight a villain!',
              active: "true")
heroes_and_villains.approval_status = "approved"

heroes = heroes_and_villains.categories.build(title:'Heroes')
villains = heroes_and_villains.categories.build(title:'Villains')
males = heroes_and_villains.categories.build(title:'Males')
females = heroes_and_villains.categories.build(title:'Females')
heroes_and_villains.save!


hv1 = Product.new(title: "Iron Man",
                  description: "From Iron Man 3",
                  price: 100,
                  status: "active")
add_photo_to_product(hv1, "hv1")
heroes_and_villains.products << hv1
heroes.products << hv1
males.products << hv1



#hv2 = Product.new(title: "Iron Patriot",
#                  description: "From Iron Man 3",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv2, "hv2")
#heroes_and_villains.products << hv2
#heroes.products << hv2
#males.products << hv2
#
#hv3 = Product.new(title: "Domo Superman",
#                  description: "domoooo",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv3, "hv3")
#heroes_and_villains.products << hv3
#heroes.products << hv3
#males.products << hv3
#
#hv4 = Product.new(title: "Domo Batman",
#                  description: "domooo",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv4, "hv4")
#heroes_and_villains.products << hv4
#heroes.products << hv4
#males.products << hv4
#
#hv5 = Product.new(title: "Robin",
#                  description: "robin",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv5, "hv5")
#heroes_and_villains.products << hv5
#heroes.products << hv5
#males.products << hv5
#
#hv6 = Product.new(title: "Wonder Woman",
#                  description: "wondeerrr",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv6, "hv6")
#heroes_and_villains.products << hv6
#heroes.products << hv6
#females.products << hv6
#
#hv7 = Product.new(title: "Dr. Doom",
#                  description: "doooom",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv7, "hv7")
#heroes_and_villains.products << hv7
#villains.products << hv7
#males.products << hv7
#
#hv8 = Product.new(title: "Joker",
#                  description: "haha",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv8, "hv8")
#heroes_and_villains.products << hv8
#villains.products << hv8
#males.products << hv8
#
#hv9 = Product.new(title: "Captain Hook",
#                  description: "arrrrr",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv9, "hv9")
#heroes_and_villains.products << hv9
#villains.products << hv9
#males.products << hv9
#
#hv10 = Product.new(title: "Spiderman",
#                  description: "piderman?",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv10, "hv10")
#heroes_and_villains.products << hv10
#heroes.products << hv10
#males.products << hv10
#
#hv11 = Product.new(title: "Deadpool",
#                  description: "something er something",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv11, "hv11")
#heroes_and_villains.products << hv11
#villains.products << hv11
#males.products << hv11
#
#hv12 = Product.new(title: "Spiderman",
#                  description: "piderman?",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv12, "hv12")
#heroes_and_villains.products << hv12
#heroes.products << hv12
#males.products << hv12
#
#hv13 = Product.new(title: "Catwoman",
#                  description: "Meow",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv13, "hv13")
#heroes_and_villains.products << hv13
#villains.products << hv13
#females.products << hv13
#
#hv14 = Product.new(title: "Greenlantern",
#                  description: "zomg so OP",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv14, "hv14")
#heroes_and_villains.products << hv14
#heroes.products << hv14
#males.products << hv14
#
#hv15 = Product.new(title: "She-RA",
#                  description: "RA RA RA",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv15, "hv15")
#heroes_and_villains.products << hv15
#heroes.products << hv15
#females.products << hv15
#
#hv16 = Product.new(title: "Beast",
#                  description: "I'm da beeaaasstt",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv16, "hv16")
#heroes_and_villains.products << hv16
#heroes.products << hv16
#males.products << hv16
#
#hv17 = Product.new(title: "Pink Ranger",
#                  description: "so pink",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv17, "hv17")
#heroes_and_villains.products << hv17
#heroes.products << hv17
#females.products << hv17
#
#hv18 = Product.new(title: "He-Man",
#                  description: "HHAAAAAA",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv18, "hv18")
#heroes_and_villains.products << hv18
#heroes.products << hv18
#males.products << hv18
#
#hv19 = Product.new(title: "Penguin",
#                  description: "quack?",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv19, "hv19")
#heroes_and_villains.products << hv19
#villains.products << hv19
#males.products << hv19
#
#hv20 = Product.new(title: "The Riddler",
#                  description: "Riddles are better than jokes",
#                  price: 100,
#                  status: "active")
#add_photo_to_product(hv20, "hv20")
#heroes_and_villains.products << hv20
#villains.products << hv20
#males.products << hv20
#
#heroes_and_villains.save!

# customer2 = Customer.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com")
# customer3 = Customer.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com")
# customer4 = Customer.create(full_name: "Katrina", email: "demoXX+katrina@jumpstartlab.com")

# user1 = User.create(password: "password", customer_id: customer1.id)
# user2 = User.create(password: "password", display_name: "j3", customer_id: customer2.id)
# user3 = User.create(password: "password", display_name: "SkrilleX", customer_id: customer3.id)
# user4 = User.create(password: "password", display_name: "Norway", customer_id: customer4.id)

# ur2 = UserRole.new
# ur2.user_id = 2
# ur2.role = "stocker"
# ur2.save
# user3.platform_admin = true
# user3.save

