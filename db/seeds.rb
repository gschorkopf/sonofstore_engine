user1 = User.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com", password: "password")
user2 = User.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com", password: "password", display_name: "j3")
user3 = User.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com", password: "password", display_name: "SkrilleX")
user4 = User.create(full_name: "Katrina", email: "demoXX+katrina@jumpstartlab.com", password: "password", display_name: "Norway")

user3.platform_admin = true
user3.save

UserRole.create(user_id: user1.id, role: "store_admin")
UserRole.create(user_id: user2.id, role: "stocker")

#file = File.open('./public/images/creatures/stickers/bobby-02.png')
product1 = Product.create(title: "Bobby", description: "Marcy's triplet brother. He's kind of smelly.", price: 14.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/ruby-green.png')
product2 = Product.create(title: "Ruby (green)", description: "We <3 it.", price: 120.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/dust-bunny.png')
product3 = Product.create(title: "Dust Bunny", description: "We swear Frank didn't get his inspiration from Kirby.", price: 2.50, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/fairy.png')
product4 = Product.create(title: "The Great Fairy", description: "She'll heal you when you're low on hearts. Keep her in a bottle.", price: 23.90, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/great-slump.png')
product5 = Product.create(title: "The Great Slump", description: "The Great Slump has a single claw arm.", price: 272.30, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/madame-mushroom.png')
product6 = Product.create(title: "Madam Mushroom", description: "For best results, ingest 30 minutes before you want your vision quest to begin.", price: 104.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/marcy-02.png')
product7 = Product.create(title: "Macy", description: "Macy, Marcy's triplet sister, is a tom-boy at heart.", price: 104.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/marcy.png')
product8 = Product.create(title: "Marcy", description: "The one and only (except for her siblings).", price: 104.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/ruby-blue.png')
product9 = Product.create(title: "Ruby (blue)", description: "We <3 it.", price: 104.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/madame-mushroom-yellow.png')
product10 = Product.create(title: "Madam Mushroom (yellow)", description: "For best results, ingest 30 minutes before you want your vision quest to begin.", price: 104.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/senor-marshmellow.png')
product11 = Product.create(title: "Senior Marshmellow", description: "Unfortunately he never learned how to spell his name correctly.", price: 74.44, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/slump-sr.png')
product12 = Product.create(title: "Slump, Sr.", description: "The grandfather of all hairballs. He was in a war once, you know.", price: 34.07, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/slumpy.png')
product13 = Product.create(title: "Slumpy", description: "The daddy of the bunch.", price: 104.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/soaked-slumpy.png')
product14 = Product.create(title: "Over-Saturated Slumpy", description: "Slumpy really hates being put in the microwave.", price: 1001.87, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/madame-mushroom-purple.png')
product15 = Product.create(title: "Madam Mushroom (purple)", description: "For best results, ingest 30 minutes before you want your vision quest to begin.", price: 1235.99, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/ruby.png')
product16 = Product.create(title: "Ruby", description: "We <3 it.", price: 1.19, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/dust-bunny-purple.png')
product17 = Product.create(title: "Dust Bunny (purple)", description: "We swear Frank didn't get his inspiration from Kirby.", price: 17.95, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/squint.png')
product18 = Product.create(title: "Squint", description: "Expert piano player", price: 24.00, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/viking.png')
product19 = Product.create(title: "The Viking", description: "He's really a big softy at heart.", price: 4.70, status: 'active')
#file.close
#file = File.open('./public/images/creatures/stickers/wizard.png')
product20 = Product.create(title: "The Wizard", description: "Cranky, hates kids, and doesn't smell very good. I heard he's related to Dumbledore's second cousin.", price: 99.50, status: 'active')
#file.close

Category.create(title: "Hairballs", product_ids: [product1.id, product5.id, product7.id, product8.id, product12.id, product13.id, product14.id])
Category.create(title: "Mystics", product_ids: [product3.id, product4.id, product6.id, product10.id, product11.id, product15.id, product17.id, product18.id, product20.id])
Category.create(title: "Bunnies", product_ids: [product3.id, product17.id])
Category.create(title: "Brutes", product_ids: [product19.id, product20.id, product11.id])
Category.create(title: "Miscellaneous", product_ids: [product2.id, product9.id, product16.id, product4.id, product15.id, product18.id])

#Sale.create(status: 'active', group: 'product', foreign_key: 1, percent_off: 50)
#Sale.create(status: 'active', group: 'category', foreign_key: 3, percent_off: 25)

#Rating.create(user_id: 3, product_id: 3, title: 'Awesome!', body: "Gotta love this one. It's like Kirby but with better ears!", stars: 4)
#Rating.create(user_id: 2, product_id: 3, title: 'Meh...', body: 'Just a Kirby knock-off.', stars: 2)
#Rating.create(user_id: 2, product_id: 1, title: 'Cool', body: "I'm happy with my purchase", stars: 3)
#Rating.create(user_id: 3, product_id: 1, title: 'Bought two!', body: 'Fantastic', stars: 5)

order1 = Order.create(status: 'pending', user_id: user1.id)
order2 = Order.create(status: 'paid', user_id: user1.id)
order3 = Order.create(status: 'shipped', user_id: user1.id)
order4 = Order.create(status: 'cancelled', user_id: user2.id)
order5 = Order.create(status: 'returned', user_id: user2.id)
order6 = Order.create(status: 'pending', user_id: user3.id)
order7 = Order.create(status: 'paid', user_id: user3.id)
order8 = Order.create(status: 'shipped', user_id: user3.id)
order9 = Order.create(status: 'pending', user_id: user3.id)
order10 = Order.create(status: 'returned', user_id: user3.id)
