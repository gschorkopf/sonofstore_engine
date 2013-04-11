class StoreDecisionMailer
  @queue = :mailer_queue

  def self.perform(store_id)
    store = Store.find_by_id(store_id)
    user = store.users.first
    Mailer.store_decision_confirmation(user, store).deliver
  end
end