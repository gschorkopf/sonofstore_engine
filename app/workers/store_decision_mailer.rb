class StoreDecisionMailer
  @queue = :mailer_queue

  def self.perform(store_id)
    store = Store.find_by_id(store_id)
    Mailer.store_decision_confirmation(store).deliver
  end
end
