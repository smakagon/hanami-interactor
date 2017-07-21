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

If we run this code:
```ruby
SignUp.new.call
```
It will publish `:user_signed_up` event and `WelcomeMailer#user_signed_up` will be called with params: `{ first_name: 'John', last_name: 'Doe' }`

So response will be:

> Processing event with params: {:first_name=>"John", :last_name=>"Doe"}

Uses wisper gem to implement pub/sub.

_Created as a Proof of concept, feedback is welcomed!_

Idea of having Pub/Sub for Hanami was described here: https://discourse.hanamirb.org/t/hanami-2-0-ideas/306/9
