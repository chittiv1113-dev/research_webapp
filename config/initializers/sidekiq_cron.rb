if defined?(Sidekiq::Cron)
  Sidekiq::Cron::Job.create(
    name: 'Delete expired projects - every day',
    cron: '0 0 * * *', # Runs at midnight every day
    class: 'DeleteExpiredProjectsJob'
  )
end
