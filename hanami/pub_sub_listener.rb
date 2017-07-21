# Main listener that is responsible for calling subscribers when event occurred
module Hanami
  class PubSubListener
    attr_reader :subscribers

    def initialize
      # Holds the list of subscribers where key is
      # event name and value is an array of subscribers
      @subscribers = Hash.new { |h, k| h[k] = [] }
    end

    # not a big fan  of method_missing idea, but to support any possible event
    # I had to use it. Wisper expects that global listener should be able to process any evnet.
    # It accepts method, then goes through all subscribers for that event and calls corresponding
    # method with params.
    def method_missing(name, *params)
      subscribers[name.to_sym].each do |subscriber|
        subscriber.public_send(name, *params)
      end
    end

    # Wisper wouldn't call method if class is not responding to the message
    def respond_to?(_name, *params)
      true
    end

    # Hanami::Subscriber uses this method to subscribe class to events
    # One downside of this approach that new instance of subscribe is being created at this point
    # With current implementation subscribers shouldn't have any required params for initialization
    def subscribe(name, klass)
      subscribers[name].push(klass.new)
    end

    # Listener should be a singleton
    @@instance = self.new

    def self.instance
      @@instance
    end

    private_class_method :new
  end
end
