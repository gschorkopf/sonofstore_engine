User.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com", password: "password")
User.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com", password: "password", display_name: "j3")
User.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com", password: "password", display_name: "SkrilleX", admin: true)

Category.create(title: "Hairballs", store_id: 1)

n = 1
100.times do
  Product.create(title: "Product #{n}", description: "Great product", price: 500, status: 'active', store_id: 1, category_ids: [1])
  n += 1
end