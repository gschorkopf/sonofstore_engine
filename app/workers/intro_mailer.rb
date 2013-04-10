class IntroMailer
  @queue = :mailer_queue

  def self.perform(user_id)
    user = User.find(user_id)
    Mailer.welcome_email(user).deliver
  end
end