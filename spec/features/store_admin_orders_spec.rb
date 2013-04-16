# require 'spec_helper'

# describe "admin dashboard" do
#   before(:each) do
#     customer = FactoryGirl.create(:customer)
#       FactoryGirl.create(:store_admin, customer_id: customer.id)
#       visit login_path
#       fill_in 'sessions_email', with: 'teeny@tiny.com'
#       fill_in 'sessions_password', with: 'password'
#       click_button 'Login'
#       @customer2 = FactoryGirl.create(:customer, email: 'myemail@email.com')
#       FactoryGirl.create(:order, customer_id: @customer2.id, status: 'paid')
#       FactoryGirl.create(:order, customer_id: @customer2.id, status: 'paid')
#       FactoryGirl.create(:order, customer_id: @customer2.id, status: 'returned')
#   end

#   context "when an admin visits their dashboard" do
#     it "should have a list of all orders and link to each" do
#       pending 'we don't have this functionality right now'
#       # order1 = FactoryGirl.create(:order, customer_id: @customer2.id)
#       # order2 = FactoryGirl.create(:order, customer_id: @customer2.id)

#       # visit '/admin/dashboard'
#       # expect(page).to have_xpath("//a[@href='#{admin_order_path(order1)}']")
#       # expect(page).to have_xpath("//a[@href='#{admin_order_path(order2)}']")
#     end

#     it "should show a total number of orders by status" do
#       pending 'this isnt working right now'
#       # visit '/admin/dashboard'
#       # expect(page).to have_content('0 Pending')
#       # expect(page).to have_content('2 Paid')
#       # expect(page).to have_content('1 Returned')
#       # expect(page).to have_content('0 Shipped')
#       # expect(page).to have_content('0 Cancelled')
#     end

#     context "within an individual order" do
#       before(:each) do
#         @store = FactoryGirl.create(:store)
#         @order = FactoryGirl.create(:order, customer: @customer2)
#         @product = FactoryGirl.create(:product, store_id: @store.id)
#         @order_item = FactoryGirl.create(:order_item, order: @order, product: @product)
#         visit admin_order_path(@order)
#       end

#       it "displays order creation date and time" do
#         expect(page).to have_content(@order.created_at.to_s(:short))
#         expect(page).to have_content(@order.updated_at.to_s(:short))
#       end

#       it "displays purchaser's full name and email address" do
#         expect(page).to have_content(@user.email)
#       end

#       it "displays each product of the order with associated data" do
#         expect(page).to have_content(@product.title)
#         expect(page).to have_link(@product.title)
#         expect(page).to have_xpath("//a[@href='#{product_path(@product)}']")
#         expect(page).to have_content(@order_item.quantity)
#         expect(page).to have_content(@order_item.unit_price)
#         expect(page).to have_content(@order_item.subtotal)
#       end

#       it "displays order total" do
#         expect(page).to have_content(@order.total)
#       end

#       it "displays order status" do
#         expect(page).to have_content(@order.status)
#       end

#       context "can update the order by" do
#         it "progressing status based on rules" do
#           expect(page).to have_button('cancel')

#           order = FactoryGirl.create(:order, customer_id: @customer2.id, status: 'paid')
#           visit admin_order_path(order)
#           expect(page).to have_button('mark as shipped')

#           order = FactoryGirl.create(:order, customer_id: @customer2.id, status: 'shipped')
#           visit admin_order_path(order)
#           expect(page).to have_button('mark as returned')

#           order = FactoryGirl.create(:order, customer_id: @customer2.id, status: 'cancelled')
#           visit admin_order_path(order)
#           expect(page).to_not have_button('mark as returned')
#           expect(page).to_not have_button('mark as shipped')
#           expect(page).to_not have_button('cancel')
#         end

#         it "changing quantity ONLY when status pending or paid" do
#           fill_in('admin_order_item_quantity', with: '10')
#           click_button('Update')
#           expect(page).to have_content(@order_item.unit_price * 5)

#           expect(page).to have_xpath("//input[@id='admin_order_item_quantity']")
#           click_button('cancel')
#           expect(page).to_not have_xpath("//input[@id='admin_order_item_quantity']")
#         end

#         it "removing product ONLY when status pending or paid" do
#           expect(page).to have_content(@product.title)
#           click_button('Delete')
#           expect(page).to_not have_content(@product.title)
#         end
#       end
#     end
#   end
# end
