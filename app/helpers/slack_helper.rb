module SlackHelper
  def link_to(path, text)
    "<#{path}|#{text}>"
  end

  def user_url(user)
    "<@#{user.slack_id}>"
  end

  ['question', 'answer', 'comment', 'upvote', 'downvote'].each do |taggable|
    define_method "#{taggable}_tag" do |id|
      "[#{taggable.capitalize} ##{id}]"
    end
  end

end
