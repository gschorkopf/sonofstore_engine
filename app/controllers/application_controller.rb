class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_cart, :get_flag, :generate_span,
    :current_store, :generate_image_url, :generate_store_image_url
  before_filter :get_locale


  ##########
  #restricts the linking of payment specific info to checkout
  #redirects the user to their homepage whenever they add or edit
  #this information directly
  ##########
  before_filter :get_referrer, :except => [:create, :update, :destroy, :signup]

  def get_referrer
    session[:return_to] = request.referrer
  end
  #########

  def require_admin
    if current_user == false
      not_authenticated
    elsif current_user.platform_admin? || current_user.role_for_store?('store_admin', current_store)
      true
    else
      redirect_to login_path,
        :alert => "Only store administrators may access this page"
    end
  end

  def require_platform_admin
    if current_user == false
      not_authenticated
    elsif current_user.platform_admin?
      true
    else
      redirect_to root_path,
      :alert => "Only system administrators may access this page"
      return
    end
  end

  def require_stocker
    if current_user == false
      not_authenticated
    elsif current_user.role_for_store?('stocker', current_store) || current_user.platform_admin? || current_user.role_for_store?('store_admin', current_store)
      true
    else
      redirect_to login_path,
        :alert => "Only store administrators may access this page"
    end
  end

  def not_authenticated
    redirect_to login_path, :alert => "First login to access this page."
  end

  def find_or_create_store_cart
    session[current_store.path] ||= Hash.new(0)
  end

  def current_store
    @current_store ||= Store.find_by_path(params[:store_path])
  end

  def current_cart
    if current_store
      @cart ||= Cart.new(session[current_store.path]) || Cart.new(session[:cart])
    end
  end

  def get_locale
    I18n.locale = session[:i18n] || I18n.default_locale || :en
  end

  def generate_image_url(side_length, product_id)
    url = Product.find(product_id).image.url(:thumbnail)

    if url.include?("missing")
    img_category = IMAGE_CATEGORIES[current_store.id.to_s[-1].to_i]
    img_size_params = "#{side_length}/#{side_length}"
    img_id = product_id.to_s[-1].to_i
    img_id = 10 if img_id == 0
    url = "http://lorempixel.com/#{img_size_params}/#{img_category}/#{img_id}"
    end

    url

  end



  def generate_store_image_url(store_id)
    products = Store.find_by_id(store_id).products
    if products.empty?
      img_category = IMAGE_CATEGORIES[store_id.to_s[-1].to_i]
      "http://lorempixel.com/500/500/#{img_category}/"
    else
      url = products.first.image.url(:retail)
      if url.include?("missing")
        img_category = IMAGE_CATEGORIES[store_id.to_s[-1].to_i]
        img_size_params = "#{300}/#{300}"
        img_id = products.first.id.to_s[-1].to_i
        img_id = 10 if img_id == 0
        url = "http://lorempixel.com/#{img_size_params}/#{img_category}/#{img_id}"
      end
      url
    end
  end

  IMAGE_CATEGORIES = {
    1 => 'city',
    2 => 'abstract',
    3 => 'food',
    4 => 'sports',
    5 => 'cats',
    6 => 'technics',
    7 => 'fashion',
    8 => 'transport',
    9 => 'nightlife',
    0 => 'animals'
  }

  def generate_span(integer)
    integer = integer & 7 if integer > 7
    SPANS[integer]
  end

  SPANS = {
    1 => "span8",
    2 => "span4",
    3 => "span4",
    4 => "span4",
    5 => "span4",
    6 => "span4",
    7 => "span8"
  }

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_path
  end
end
