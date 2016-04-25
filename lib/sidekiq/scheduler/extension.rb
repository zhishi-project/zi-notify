require 'sidekiq/scheduler'

module Sidekiq::Scheduler::Extension
  def create_schedule!
    Sidekiq.set_schedule(
      schedule_identifier, schedule_from_configuration
    )
  end

  def default_options
    { 'class' => class_identifier }
  end

  def config_options
    @confuration ||= []
  end

  def schedule_from_configuration
    config_options.reduce(default_options)do |defaults, options|
      options.each do |key, value|
        defaults[key.to_s] = value.to_s
      end
      defaults
    end
  end

  # configure every => '1m'
  # configure class => to_s
  # configure queue => queue_name
  # configure args => args
  # configure description => what the class does
  def configure(options)
    config_options.push(options)
  end

  def class_identifier
    to_s
  end

  def schedule_identifier
    to_s.underscore.gsub('worker', 'schedule')
  end
end
