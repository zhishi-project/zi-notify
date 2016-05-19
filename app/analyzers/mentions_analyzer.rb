class MentionsAnalyzer
  attr_reader :resolved_user_names, :resource, :fields

  def initialize(resource, fields: [:content])
    @resolved_user_names = []
    @fields = fields
    @resource = resource
  end

  def analyze
    fields.each do |field|
      @resolved_user_names += resource.send(field).scan(/@[\w-.]+/)
    end
    resolved_user_names.uniq
  end

  def users_without_symbol
    analyze.map{|x| x[1..-1] }
  end

  def find_users
    User.where(slack_name: users_without_symbol)
  end
end
