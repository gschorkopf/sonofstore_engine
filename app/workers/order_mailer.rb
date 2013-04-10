class OrderMailer
  @queue = :mailer_queue

  def self.perform(order_id, user_id)
    order = Order.find(order_id)
    current_user = User.find(user_id)
    Mailer.order_confirmation(current_user, order).deliver
  end
end