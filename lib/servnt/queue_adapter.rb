module ActiveJob
  module QueueAdapters
    class ServntAdapter
      def enqueue(job)
        Servnt.publisher.publish JobWrapper.new(job)
      end

      class JobWrapper
        def initialize(job)
          @job_data = job.serialize
        end

        def perform
          Base.execute @job_data
        end
      end
    end
  end
end
