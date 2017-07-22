require 'wisper'
require_relative 'hanami/event_listener'
require_relative 'hanami/subscriber'
require_relative 'hanami/publisher'

module Hanami
end

# Registering global listener for all events
# I don't like "global" here, but seems like we need to have one event bus
# to run methods on subscribers
Wisper.subscribe(Hanami::EventListener.instance)
