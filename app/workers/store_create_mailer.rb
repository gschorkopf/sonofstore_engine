class StoreCreateMailer
  @queue = :mailer_queue

  def self.perform(user_id, store_id)
    store = Store.find_by_id(store_id)
    user = User.find(user_id)
    Mailer.store_creation_confirmation(user, store).deliver
  end
end