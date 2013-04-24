require 'spec_helper'

feature "Public User Views Products" do

  context "the store home page" do
    before(:each) do
      @store = FactoryGirl.create(:store)
      @product = FactoryGirl.create(:product, store_id: @store.id)
      visit store_home_path(@store)
    end

    it "displays products" do
      page.should have_content(@product.title)
    end
  end

  context "the product page" do
    before(:each) do
      @store = FactoryGirl.create(:store, name: 'Tinas Llamas', path: 'tinas-llamas')
      @product = FactoryGirl.create(:product, store: @store)
      visit store_product_path(@store, @product)
    end

    it "displays the product name" do
      page.should have_content @product.title
    end

    it "has an add-to-cart action" do
      click_button "Add to Cart"
      expect(current_path).to eq store_product_path(@store, @product)
    end

    context 'ratings and reviews' do
      context 'when reviews exist for the product' do
        before(:each) do
          @user = FactoryGirl.create(:user)
          @noname_user = FactoryGirl.create(:user_without_display_name)

          rating1 = FactoryGirl.create(:rating)
          rating2 = FactoryGirl.create(:rating, rating: 3)
        end

        it 'displays the individual ratings sorted by most recent' do
          pending
          page.should have_content('product_reviews')
          #how do we test the sorted ratings?
        end

        it 'includes the reviewers display name if they had one, or customer' do
          pending
          #verify it has the specific display name created in before block, and one w/o a display name

        end

        it 'displays a summary of the average ratings for each category' do
          pending
         # page.should have_content('product_reviews_summary')
        end

        it 'has an option to flag inappropriate content' do
          pending 'for next iteration'
        end
      end

      context 'when there are no reviews for the product' do
        it 'displays a message that there are no reviews' do
          pending
          page.should have_content('No Reviews For This Product!')
        end

        it 'has a button to leave a review for the product' do
          pending
          page.should have_content('Be the first to leave your review!')
        end

        it 'does not display any reviews or summaries' do
          pending
          page.should_not have_content('product_reviews')
        end
      end
    end
  end
end
