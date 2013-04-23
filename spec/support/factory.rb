FactoryGirl.define do

  factory :store do
    name "MyString"
    path "my-string"
    description "My String Store Rocks!"
    approval_status "approved"
    active true
  end

  factory :category do
    title 'Dark Matter'
  end

  factory :order_item do
    product
    order
    unit_price 20.00
    selling_price 10.00
    quantity 3
  end

  factory :order do
    status 'pending'
  end

  factory :product do
    store
    title 'Itchy Sweater'
    description 'Hurts so good'
    price 12.99
    status 'active'
  end

  factory :customer do
    full_name 'Daniel Boone'
    email 'dboone54@yahoo.com'
  end

  factory :user do
    customer {FactoryGirl.create(:customer, full_name:'Tommy Thomas', email: 'tommy@tommy.com')}
    display_name 'Booner'
    password 'password'
    platform_admin false
  end

  factory :user_without_display_name, parent: :user do
    display_name nil
    customer
  end

  factory :question do
    question 'How would you rate the awesomeness?'
  end

  factory :product_review do
    customer
    product
    comment "Great product! 10/10 would buy again."
  end

  factory :rating do
    question
    rating 5
    product_review
  end

  factory :store_admin, parent: :user do
    #how do I associate a user role with this automatically?
    display_name 'Teeny'
    password 'password'
    platform_admin false
  end

  factory :platform_admin, parent: :user do
    # full_name 'Davey Crockett'
    # email 'crockett@hotmail.com'
    display_name 'coonskin'
    password 'password'
    platform_admin true
  end

  factory :billing_address do
    street_address '123 Main St'
    city 'Denver'
    zip '12345'
    state 'CO'
  end

  factory :shipping_address do
    street_address '123 Main St'
    city 'Denver'
    zip '12345'
    state 'CO'
  end

  factory :credit_card do
    number '4242424242424242'
    expiration_month '12'
    expiration_year '2015'
    security_code '111'
  end
end
