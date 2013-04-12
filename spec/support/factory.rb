FactoryGirl.define do

  factory :store do
    name "MyString"
    path "my-string"
    description "My String Store Rocks!"
  end

  factory :category do
    title 'Dark Matter'
  end

  factory :order_item do
    product { FactoryGirl.build(:product) }
    order { FactoryGirl.build(:order) }
    unit_price 20.00
    selling_price 10.00
    quantity 3
  end

  factory :order do
    status 'pending'
  end

  factory :product do
    categories { [FactoryGirl.build(:category)] }
    title 'Itchy Sweater'
    description 'Hurts so good'
    price 12.99
    status 'active'
  end

  factory :user do
    full_name 'Daniel Boone'
    email 'dboone54@yahoo.com'
    display_name 'Booner'
    password 'password'
    platform_admin false
  end

  factory :store_admin, parent: :user do
    #need to assign a user role for this one, not exactly sure how
    full_name 'Teeny Tiny'
    email 'teeny@tiny.com'
    display_name 'Teeny'
    password 'password'
    platform_admin false
  end

  factory :platform_admin, parent: :user do
    full_name 'Davey Crockett'
    email 'crockett@hotmail.com'
    display_name 'coonskin'
    password 'password'
    platform_admin true
  end
end
