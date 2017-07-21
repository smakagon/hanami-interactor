require_relative 'hanami'

class SignUp
  include Hanami::Publisher

  def call
    broadcast(:user_signed_up, first_name: 'John', last_name: 'Doe')
  end
end

class WelcomeMailer
  include Hanami::Subscriber

  subscribe_to :user_signed_up

  def user_signed_up(params)
    puts "Processing event with params: #{params}"
  end
end

SignUp.new.call
