class Mailer < ActionMailer::Base
  default from: "the_gang@sonofstore_engine.com"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Frank's Monsterporium!")
  end

  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(to: user.email, subject: "Thanks for your purchase!")
  end

  def store_creation_confirmation(user, store)
    @user = user
    @store = store
    mail(to: user.email, subject: "Your store #{store} has been created and pending approval")
  end

  def store_decision_confirmation(store)
    @store = store
    @user = @store.users.first
    mail(to: @user.email, subject: "Your store #{@store} has been #{@store.approval_status}")
  end
end
