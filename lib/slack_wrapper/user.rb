module SlackWrapper
  class User
    attr_reader :uuid, :slack_name, :name, :is_bot, :team_id, :profile, :provider
    delegate :email, to: :profile

    def initialize(options={})
      @provider = 'slack'
      @slack_name = options[:name]
      @uuid = options[:id]
      @name = options[:real_name]
      @is_bot = options[:is_bot]
      @team_id = options[:team_id]
      @profile = Profile.new(options.profile)
    end

    def profile_picture
      profile.image_md
    end

    def local_user
      ::User.from_slack(self)
    end
  end
end
