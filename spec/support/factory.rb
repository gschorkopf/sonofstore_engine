FactoryGirl.define do

  factory :store do
    name "MyString"
    path "my-string"
    description "My String Store Rocks!"
    approval_status "approved"
    active true
  end

  factory :category do
    #can i assign store id in here?
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
   #is there a way i can assign store_id in here? it would be nice
    #as well as categories?
    # categories { [FactoryGirl.build(:category)] }
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
     #is there a way i can assign customer_id in here? it would be nice
    display_name 'Booner'
    password 'password'
    platform_admin false
  end

  factory :store_admin, parent: :user do
    #need to assign a user role for this one, not exactly sure how
    # full_name 'Teeny Tiny'
    # email 'teeny@tiny.com'
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
end
