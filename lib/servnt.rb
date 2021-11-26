require 'json'
require 'google/cloud/pubsub'

require 'servnt/job_publisher'
require 'servnt/job_processor'

require 'servnt/queue_adapter'

require 'tasks/process_jobs.rake'

module Servnt
  def self.storage
    @storage
  end

  def self.storage=(storage)
    @storage = storage
  end

  def self.publisher
    @publisher
  end

  def self.publisher=(publisher)
    @publisher = publisher
  end

  def self.processor
    @processor
  end

  def self.processor=(processor)
    @processor = processor
  end
end

Servnt.storage = Google::Cloud::PubSub.new
pubsub = Servnt.storage
Servnt.publisher = Servnt::Publisher::GcpPublisher.new(pubsub)
Servnt.processor = Servnt::Processor::GcpProcessor.new(pubsub)
