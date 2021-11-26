module Servnt
  module Processor
    class GcpProcessor
      def initialize(pubsub)
        subscription = pubsub.subscription 'servnt-jobs-subscription'

        @subscriber = subscription.listen threads: { callback: 4 } do |received_message|
          job = JSON.parse(received_message.message.data)
          job.perform
          received_message.acknowledge!
        end

        @subscriber.on_error do |exception|
          puts "Exception: #{exception.class} #{exception.message}"
        end

        at_exit do
          @subscriber.stop!(5)
        end
      end

      def start
        @subscriber.start

        sleep
      end
    end
  end
end
