module Servnt
  module Publisher
    class GcpPublisher
      def initialize(pubsub)
        @topic = pubsub.topic('servnt-jobs') || pubsub.create_topic('servnt-jobs')
        @topic.subscribe('servnt-jobs-subscription') unless @topic.subscription('servnt-jobs-subscription')
      end

      def publish(job)
        @topic.publish JSON.dump(job)
      end
    end
  end
end
