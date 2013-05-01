stores = [
  store1 = Store.create(name: 'Best Sunglasses', path: 'best-sunglasses', description: 'Buy our Sunglasses'),
  store2 = Store.create(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'Buy our COOL Sunglasses'),
  Store.create(name: "Speedy Bikes", path: "speedy-bikes", description: "Put the fun between your legs!"),
  Store.create(name: "Cool Runnings", path: "cool-runnings", description: "You'll come back tomorrow and the next day and the next day and the next day."),
  Store.create(name: "Banana Stand", path: "banana-stand", description: "There's always money in the banana stand."),
  Store.create(name: "Florist-Gump", path: "florist-gump", description: "Life's not like a box of chocolates here.  What you see is what you get!"),
  Store.create(name: "World of Woolcraft", path: "world-of-woolcraft", description: "Knitting's no joke"),
  Store.create(name: "Frank's Monsterporium", path: "monsterporium", description: "Monster?  Maybe.  Cuddly?  Definitely."),
  Store.create(name: "Katrina's Refactorium", path: "refactorium", description: "Crazy code?  Yeah, we can work with it."),
  Store.create(name: "Jeff's Developer Warehouse", path: "developer-warehouse", description: "Tons of crazy kids... who work for free!")
]

store1.approval_status = 'approved'
store1.active = true
store1.save
store2.approval_status = 'approved'
store2.active = true
store2.save


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

s_id = 1
10.times do
  10.times do
    10.times do
      Product.create(title: Faker::Address.street_name.split[0],
        description: "#{Faker::Company.bs} " + "#{Faker::Company.bs}",
        price: "#{(1..500).to_a.sample}.0".to_f,
        status: 'active',
        store_id: s_id)
        #better way to do fake photos? there's gotta be.
    end
  end
  s_id += 1
end

#product_categories store1
p_id = 1
c_id = 1
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store2
p_id = 101
c_id = 11
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store3
p_id = 201
c_id = 21
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store4
p_id = 301
c_id = 31
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store5
p_id = 401
c_id = 41
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store6
p_id = 501
c_id = 51
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store7
p_id = 601
c_id = 61
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store8
p_id = 701
c_id = 71
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store9
p_id = 801
c_id = 81
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end

#product_categories store10
p_id = 901
c_id = 91
10.times do
  10.times do
    ProductCategory.create(product_id: p_id, category_id: c_id)
    p_id +=1
  end
  c_id +=1
end


customer1 = Customer.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com")
customer2 = Customer.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com")
customer3 = Customer.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com")
customer4 = Customer.create(full_name: "Katrina", email: "demoXX+katrina@jumpstartlab.com")

user1 = User.create(password: "password", customer_id: customer1.id)
user2 = User.create(password: "password", display_name: "j3", customer_id: customer2.id)
user3 = User.create(password: "password", display_name: "SkrilleX", customer_id: customer3.id)
user4 = User.create(password: "password", display_name: "Norway", customer_id: customer4.id)

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

#Create Questions for Ratings
question1 = Question.create(question: 'Durability', long_form: 'How would you rate the durability of this product?')
question2 = Question.create(question: 'Value', long_form: 'How would you rate the value of this product?')
question3 = Question.create(question: 'Packaging', long_form: 'How would you rate the packaging of this product?')
question4 = Question.create(question: 'Description Accuracy', long_form: 'How accurate would you rate our description of this product?')

#Create A Few Example Product Reviews

product_review1 = ProductReview.create( customer_id: customer3.id,
                                        product_id: 1,
                                        comment: 'This is sooo :metal:! :heart: :heart: :+1: ')
rating1 = Rating.create(question_id: question1.id, rating: 5, product_review_id: product_review1.id)
rating2 = Rating.create(question_id: question2.id, rating: 3, product_review_id: product_review1.id)
rating3 = Rating.create(question_id: question3.id, rating: 2, product_review_id: product_review1.id)
rating4 = Rating.create(question_id: question4.id, rating: 1, product_review_id: product_review1.id)

product_review2 = ProductReview.create( customer_id: customer1.id, product_id: 2, comment: 'THIS SUXXX', status: 'flagged' )
product_review3 = ProductReview.create( customer_id: customer2.id, product_id: 3, comment: 'I HATE IT, BOO', status: 'flagged' )
