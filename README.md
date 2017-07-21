### Pub/Sub functionality for Hanami Framework

Allows to publish events from code

```ruby
class SignUp
  include Hanami::Publisher

  def call
    broadcast(:user_signed_up, first_name: 'John', last_name: 'Doe')
  end
end
```

Allows to subscribe for events:
```ruby
class WelcomeMailer
  include Hanami::Subscriber

  subscribe_to :user_signed_up

  def user_signed_up(params)
    puts "Processing event with params: #{params}"
  end
end
```

Uses wisper gem to implement pub/sub.

_Created as a Proof of concept, feedback is welcomed!_
