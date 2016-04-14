class MentionsAnalyzer
  attr_reader :resolved_user_names, :content

  def initialize(content)
    @resolved_user_names = []
    @content = content
  end

  def analyze
    content.scan(/@[\w-]+/)
  end

  def users_without_symbol
    analyze.map{|x| x[1..-1] }
  end

  def find_users
    User.where(slack_name: users_without_symbol)
  end
end
# 
# "@user @jubril @kay"
# kay user jubril
