# Implements `subscribe_to` method for subscribers.
# Uses PubSubListener singletone to subscribe class to specific type of events.
module Hanami
  module Subscriber
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def subscribe_to(method)
        Hanami::EventListener.instance.subscribe(method, self)
      end
    end
  end
end
