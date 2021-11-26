namespace :servnt do
  desc 'Pulls messages from GCP Pub Sub and executes the pending jobs'
  task :process_jobs do
    Servnt.processor.start
  end
end
