class SlackUsersManagerWorker
  include Sidekiq::Worker
  extend Sidekiq::Scheduler::Extension
  configure every: '5m', queue: :slack
  create_schedule!
  sidekiq_options retry: 5, backtrace: true
  Logger = Sidekiq.logger.level == Logger::DEBUG ? Sidekiq.logger : nil

  def perform
    logger.debug [:slack, 'Checking for newer Slack users']
    SlackUsersRetrieverService.retrieve
  end
end
