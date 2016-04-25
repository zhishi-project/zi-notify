module BaseHelper
  ['question', 'answer', 'comment', 'upvote', 'downvote'].each do |taggable|
    define_method "#{taggable}_tag" do |id|
      "[#{taggable.capitalize} ##{id}]"
    end
  end
end
