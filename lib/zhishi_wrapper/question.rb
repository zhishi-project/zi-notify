module ZhishiWrapper
  class Question < ZhishiWrapper::Base
    delegate :id, :title, :content, :tags, :url, to: :payload
    include Concerns::ResourceOwner
    include Concerns::ResourceSubscriber
  end
end
