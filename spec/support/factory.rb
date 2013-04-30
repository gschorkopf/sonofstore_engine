FactoryGirl.define do

  factory :store do
    sequence(:name) {|n| "mystore#{n}"}
    sequence(:path) {|n| "my-store-path#{n}"}
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
    customer
  end

  factory :product do
    store
    sequence(:title) {|n| "Itche Sweater#{n}"}
    description 'Hurts so good'
    price 12.99
    status 'active'
    #product_reviews { (0..5).collect{ |i| create(:product_review_2) } }
  end

  factory :customer do
    full_name 'Daniel Boone'
    sequence(:email) {|n| "email#{n}@example.com"}
  end

  factory :user do
    customer
    display_name 'Booner'
    password 'password'
    platform_admin false
  end

  factory :user_without_display_name, parent: :user do
    display_name nil
    customer
  end

  factory :question do
    question 'Value'
    long_form 'How would you rate the value of this product?'
  end

  factory :durability_question, class: Question do
    question 'Durability'
    long_form 'How would you rate the durability of this product?'
  end

  factory :packaging_question, class: Question do
    question 'Packaging'
    long_form 'How would you rate the packaging of this product?'
  end

  factory :description_accuracy_question, class: Question do
    question 'Description Accuracy'
    long_form 'How would you rate the description accuracy of this product?'
  end

  factory :product_review do
    customer
    product
    comment "Great product! 10/10 would buy again."
    created_at Time.now
  end

  factory :product_review_2, class: ProductReview do
    customer
    comment "Great product! 10/10 would buy again."
  end

  factory :featured_product_review, class: ProductReview do
    customer
    product
    comment "this is nice!"
    featured true
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
