bucket_name = 'ballmer_dose'
s3 = AWS::S3.new

@b = s3.buckets[bucket_name]
def add_photo_to_product product, file_name
  puts "finding #{file_name} and adding it to #{product.title}"
  object = @b.objects[file_name+".jpg"]
  product.image = object.url_for(:read)
end

puts "creating questions"
packaging = Question.create!(question: "Packaging")
durability = Question.create!(question: "Durability")
value = Question.create!(question: "Value")
accuracy = Question.create!(question: "Description Accuracy")

# Heros and Villain Store
puts "creating Heroes and Villain Store"
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
hv1.save!

hv2 = Product.new(title: "Iron Patriot",
                  description: "From Iron Man 3",
                  price: 100,
                  status: "active")
add_photo_to_product(hv2, "hv2")
heroes_and_villains.products << hv2
heroes.products << hv2
males.products << hv2
hv2.save!

hv3 = Product.new(title: "Domo Superman",
                  description: "domoooo",
                  price: 100,
                  status: "active")
add_photo_to_product(hv3, "hv3")
heroes_and_villains.products << hv3
heroes.products << hv3
males.products << hv3
hv2.save!

hv4 = Product.new(title: "Domo Batman",
                  description: "domooo",
                  price: 100,
                  status: "active")
add_photo_to_product(hv4, "hv4")
heroes_and_villains.products << hv4
heroes.products << hv4
males.products << hv4
hv2.save!

hv5 = Product.new(title: "Robin",
                  description: "robin",
                  price: 100,
                  status: "active")
add_photo_to_product(hv5, "hv5")
heroes_and_villains.products << hv5
heroes.products << hv5
males.products << hv5
hv2.save!

hv6 = Product.new(title: "Wonder Woman",
                  description: "wondeerrr",
                  price: 100,
                  status: "active")
add_photo_to_product(hv6, "hv6")
heroes_and_villains.products << hv6
heroes.products << hv6
females.products << hv6
hv2.save!

hv7 = Product.new(title: "Dr. Doom",
                  description: "doooom",
                  price: 100,
                  status: "active")
add_photo_to_product(hv7, "hv7")
heroes_and_villains.products << hv7
villains.products << hv7
males.products << hv7
hv2.save!

hv8 = Product.new(title: "Joker",
                  description: "haha",
                  price: 100,
                  status: "active")
add_photo_to_product(hv8, "hv8")
heroes_and_villains.products << hv8
villains.products << hv8
males.products << hv8
hv2.save!

hv9 = Product.new(title: "Captain Hook",
                  description: "arrrrr",
                  price: 100,
                  status: "active")
add_photo_to_product(hv9, "hv9")
heroes_and_villains.products << hv9
villains.products << hv9
males.products << hv9
hv2.save!

hv10 = Product.new(title: "Spiderman",
                  description: "piderman?",
                  price: 100,
                  status: "active")
add_photo_to_product(hv10, "hv10")
heroes_and_villains.products << hv10
heroes.products << hv10
males.products << hv10
hv2.save!

hv11 = Product.new(title: "Deadpool",
                  description: "something er something",
                  price: 100,
                  status: "active")
add_photo_to_product(hv11, "hv11")
heroes_and_villains.products << hv11
villains.products << hv11
males.products << hv11
hv2.save!

hv12 = Product.new(title: "Spiderman",
                  description: "piderman?",
                  price: 100,
                  status: "active")
add_photo_to_product(hv12, "hv12")
heroes_and_villains.products << hv12
heroes.products << hv12
males.products << hv12
hv2.save!

hv13 = Product.new(title: "Catwoman",
                  description: "Meow",
                  price: 100,
                  status: "active")
add_photo_to_product(hv13, "hv13")
heroes_and_villains.products << hv13
villains.products << hv13
females.products << hv13
hv2.save!

hv14 = Product.new(title: "Greenlantern",
                  description: "zomg so OP",
                  price: 100,
                  status: "active")
add_photo_to_product(hv14, "hv14")
heroes_and_villains.products << hv14
heroes.products << hv14
males.products << hv14
hv2.save!

hv15 = Product.new(title: "She-RA",
                  description: "RA RA RA",
                  price: 100,
                  status: "active")
add_photo_to_product(hv15, "hv15")
heroes_and_villains.products << hv15
heroes.products << hv15
females.products << hv15
hv2.save!

hv16 = Product.new(title: "Beast",
                  description: "I'm da beeaaasstt",
                  price: 100,
                  status: "active")
add_photo_to_product(hv16, "hv16")
heroes_and_villains.products << hv16
heroes.products << hv16
males.products << hv16
hv2.save!

hv17 = Product.new(title: "Pink Ranger",
                  description: "so pink",
                  price: 100,
                  status: "active")
add_photo_to_product(hv17, "hv17")
heroes_and_villains.products << hv17
heroes.products << hv17
females.products << hv17
hv2.save!

hv18 = Product.new(title: "He-Man",
                  description: "HHAAAAAA",
                  price: 100,
                  status: "active")
add_photo_to_product(hv18, "hv18")
heroes_and_villains.products << hv18
heroes.products << hv18
males.products << hv18
hv2.save!

hv19 = Product.new(title: "Penguin",
                  description: "quack?",
                  price: 100,
                  status: "active")
add_photo_to_product(hv19, "hv19")
heroes_and_villains.products << hv19
villains.products << hv19
males.products << hv19
hv2.save!

hv20 = Product.new(title: "The Riddler",
                  description: "Riddles are better than jokes",
                  price: 100,
                  status: "active")
add_photo_to_product(hv20, "hv20")
heroes_and_villains.products << hv20
villains.products << hv20
males.products << hv20

puts "creating rockNroll store"
rock_n_roll = Store.new(name: 'RockNRoll',
              path: 'rock-n-roll',
              description: 'Rock it out!',
              active: "true")
rock_n_roll.approval_status = "approved"

guitars = rock_n_roll.categories.build(title:'Guitars')
percussion = rock_n_roll.categories.build(title:'Percussion')
plushies = rock_n_roll.categories.build(title:'Plushies')
other = rock_n_roll.categories.build(title:'Other')
rock_n_roll.save!


rock1 = Product.new(title: "Guitar1",
                  description: "a red guitar",
                  price: 100,
                  status: "active")
add_photo_to_product(rock1, "rock1")
rock_n_roll.products << rock1
guitars.products << rock1

rock2 = Product.new(title: "Guitar2",
                  description: "a purply guitar",
                  price: 100,
                  status: "active")
add_photo_to_product(rock2, "rock2")
rock_n_roll.products << rock2
guitars.products << rock1

rock3 = Product.new(title: "Perucssion",
                  description: "drums",
                  price: 100,
                  status: "active")
add_photo_to_product(rock3, "rock3")
rock_n_roll.products << rock3
percussion.products << rock3

rock4 = Product.new(title: "Guitar3",
                  description: "a blue guitar",
                  price: 100,
                  status: "active")
add_photo_to_product(rock4, "rock4")
rock_n_roll.products << rock4
guitars.products << rock4

rock5 = Product.new(title: "Microphone",
                  description: "mic",
                  price: 100,
                  status: "active")
add_photo_to_product(rock5, "rock5")
rock_n_roll.products << rock5
other.products << rock5

rock6 = Product.new(title: "Guitar4",
                  description: "lego guitar",
                  price: 100,
                  status: "active")
add_photo_to_product(rock6, "rock6")
rock_n_roll.products << rock6
guitars.products << rock6

rock7 = Product.new(title: "Drums",
                  description: "blue drum set",
                  price: 100,
                  status: "active")
add_photo_to_product(rock7, "rock7")
rock_n_roll.products << rock7
percussion.products << rock7

rock8 = Product.new(title: "Saxophone",
                  description: "yay jazz",
                  price: 100,
                  status: "active")
add_photo_to_product(rock8, "rock8")
rock_n_roll.products << rock8
other.products << rock8

rock9 = Product.new(title: "Elmo on Drums",
                  description: "pa ram pa ram",
                  price: 100,
                  status: "active")
add_photo_to_product(rock9, "rock9")
rock_n_roll.products << rock9
percussion.products << rock9
plushies.products << rock9

rock10 = Product.new(title: "Rocker Monkey",
                  description: "A rocking monkey",
                  price: 100,
                  status: "active")
add_photo_to_product(rock10, "rock10")
rock_n_roll.products << rock10
plushies.products << rock10

rock11 = Product.new(title: "Rocker Cow",
                  description: "A Rocking cow",
                  price: 100,
                  status: "active")
add_photo_to_product(rock11, "rock11")
rock_n_roll.products << rock11
plushies.products << rock11

rock12 = Product.new(title: "Hellow Kitty",
                  description: "meeooww",
                  price: 100,
                  status: "active")
add_photo_to_product(rock12, "rock12")
rock_n_roll.products << rock12
plushies.products << rock12

rock13 = Product.new(title: "Troll",
                  description: "wah wah wah",
                  price: 100,
                  status: "active")
add_photo_to_product(rock13, "rock13")
rock_n_roll.products << rock13
plushies.products << rock13

rock14 = Product.new(title: "Girl Rocker1",
                  description: "zomg",
                  price: 100,
                  status: "active")
add_photo_to_product(rock14, "rock14")
rock_n_roll.products << rock14
other.products << rock14

rock15 = Product.new(title: "Girl Rocker2",
                  description: "RA RA RA",
                  price: 100,
                  status: "active")
add_photo_to_product(rock15, "rock15")
rock_n_roll.products << rock15
other.products << rock15

rock16 = Product.new(title: "Craz-e Guitar",
                  description: "so cray!",
                  price: 100,
                  status: "active")
add_photo_to_product(rock16, "rock16")
rock_n_roll.products << rock16
guitars.products << rock16

rock17 = Product.new(title: "KISS",
                  description: "i think it's kiss??",
                  price: 100,
                  status: "active")
add_photo_to_product(rock17, "rock17")
rock_n_roll.products << rock17
plushies.products << rock17

rock18 = Product.new(title: "Mickey",
                  description: "Hey mickey you're so fine",
                  price: 100,
                  status: "active")
add_photo_to_product(rock18, "rock18")
rock_n_roll.products << rock18
plushies.products << rock18

rock19 = Product.new(title: "Cookie Monster",
                  description: "I love cookies",
                  price: 100,
                  status: "active")
add_photo_to_product(rock19, "rock19")
rock_n_roll.products << rock19
plushies.products << rock19

#Tea Party Store
puts "creating TeaParty store"
tea_party = Store.new(name: 'Tea Pary',
              path: 'tea-party',
              description: 'Welcome to the Tea Party!',
              active: "true")
tea_party.approval_status = "approved"

pink = tea_party.categories.build(title:'Pink')
tea_party.save!


teaparty1 = Product.new(title: "Iron Man",
                  description: "From Iron Man 3",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty1, "teaparty1")
tea_party.products << teaparty1
pink.products << teaparty1

teaparty2 = Product.new(title: "Iron Patriot",
                  description: "From Iron Man 3",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty2, "teaparty2")
tea_party.products << teaparty2
pink.products << teaparty2

teaparty3 = Product.new(title: "Domo Superman",
                  description: "domoooo",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty3, "teaparty3")
tea_party.products << teaparty3
pink.products << teaparty3

teaparty4 = Product.new(title: "Domo Batman",
                  description: "domooo",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty4, "teaparty4")
tea_party.products << teaparty4
pink.products << teaparty4

teaparty5 = Product.new(title: "Robin",
                  description: "robin",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty5, "teaparty5")
tea_party.products << teaparty5
pink.products << teaparty5

teaparty6 = Product.new(title: "Wonder Woman",
                  description: "wondeerrr",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty6, "teaparty6")
tea_party.products << teaparty6
pink.products << teaparty6

teaparty7 = Product.new(title: "Dr. Doom",
                  description: "doooom",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty7, "teaparty7")
tea_party.products << teaparty7
pink.products << teaparty7

teaparty8 = Product.new(title: "Joker",
                  description: "haha",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty8, "teaparty8")
tea_party.products << teaparty8
pink.products << teaparty8

teaparty9 = Product.new(title: "Captain Hook",
                  description: "arrrrr",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty9, "teaparty9")
tea_party.products << teaparty9
pink.products << teaparty9

teaparty10 = Product.new(title: "Spiderman",
                  description: "piderman?",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty10, "teaparty10")
tea_party.products << teaparty10
pink.products << teaparty10

teaparty11 = Product.new(title: "Deadpool",
                  description: "something er something",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty11, "teaparty11")
tea_party.products << teaparty11
pink.products << teaparty11

teaparty12 = Product.new(title: "Spiderman",
                  description: "piderman?",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty12, "teaparty12")
tea_party.products << teaparty12
pink.products << teaparty12

teaparty13 = Product.new(title: "Catwoman",
                  description: "Meow",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty13, "teaparty13")
tea_party.products << teaparty13
pink.products << teaparty13

teaparty14 = Product.new(title: "Greenlantern",
                  description: "zomg so OP",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty14, "teaparty14")
tea_party.products << teaparty14
pink.products << teaparty14

teaparty15 = Product.new(title: "She-RA",
                  description: "RA RA RA",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty15, "teaparty15")
tea_party.products << teaparty15
pink.products << teaparty15

teaparty16 = Product.new(title: "Beast",
                  description: "I'm da beeaaasstt",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty16, "teaparty16")
tea_party.products << teaparty16
pink.products << teaparty16

teaparty17 = Product.new(title: "Pink Ranger",
                  description: "so pink",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty17, "teaparty17")
tea_party.products << teaparty17
pink.products << teaparty17

teaparty18 = Product.new(title: "He-Man",
                  description: "HHAAAAAA",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty18, "teaparty18")
tea_party.products << teaparty18
pink.products << teaparty18

teaparty19 = Product.new(title: "Penguin",
                  description: "quack?",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty19, "teaparty19")
tea_party.products << teaparty19
pink.products << teaparty19

teaparty20 = Product.new(title: "The Riddler",
                  description: "Riddles are better than jokes",
                  price: 100,
                  status: "active")
add_photo_to_product(teaparty20, "teaparty20")
tea_party.products << teaparty20
pink.products << teaparty20
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

