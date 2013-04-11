module Search
  def self.filter_products(params = {})
    if params[:category_id].present?
      Category.find(params[:category_id]).products.where(status: 'active')
    else
      Product.find_all_by_status('active')
    end
  end

  def self.filter_user_orders(user_id, params = {})
  end
end
