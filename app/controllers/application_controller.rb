class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_cart, :get_flag, :current_store
  before_filter :get_locale


  ##########
  #restricts the linking of payment specific info to checkout
  #redirects the user to their homepage whenever they add or edit
  #this information directly
  ##########
  before_filter :get_referrer, :except => [:create, :update, :destroy, :signup]


#should be set_return_to or save_referrer.....


  def get_referrer
    session[:return_to] = request.referrer
  end
  #########



  def current_store
    @current_store ||= Store.find_by_path(params[:store_path]) if params[:store_path]
  end

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

  def find_or_create_cart
    session[:cart] ||= Hash.new(0)
  end

  def current_cart
    @cart ||= Cart.new(session[:cart])
  end

  def get_locale
    I18n.locale = session[:i18n] || I18n.default_locale || :en
  end

  def get_flag
    case session[:i18n]
    when 'fr' then 'fr'
    when 'cs' then 'cs'
    when 'ca' then 'ca'
    else 'us'
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_path
  end
end
