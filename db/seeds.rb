User.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com", password: "password")
User.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com", password: "password", display_name: "j3")
User.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com", password: "password", display_name: "SkrilleX", admin: true)


Store.create(name: 'Best Sunglasses', path: 'best-sunglasses', description: 'Buy our Sunglasses')
Store.create(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'Buy our COOL Sunglasses')

Category.create(title: "Wayfarers", store_id: 1)
Category.create(title: "Raybans", store_id: 1)
Category.create(title: "Serengetis", store_id: 2)
Category.create(title: "Raybans", store_id: 2)

n = 1
50.times do
  Product.create(title: "Product #{n}", description: "Great product", price: 500, status: 'active', store_id: 1, category_ids: [1])
  Product.create(title: "Product #{n}", description: "Great product", price: 500, status: 'active', store_id: 2, category_ids: [3])
  n += 1
  Product.create(title: "Product #{n}", description: "Great product", price: 500, status: 'active', store_id: 1, category_ids: [2])
  Product.create(title: "Product #{n}", description: "Great product", price: 500, status: 'active', store_id: 2, category_ids: [4])
  n += 1
end