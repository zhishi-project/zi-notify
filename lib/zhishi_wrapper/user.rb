module ZhishiWrapper
  class User < ZhishiWrapper::Base
    delegate :id, :name, :email, :points, :image, to: :payload
    include Concerns::ResourceSubscriber
    
    def local_user
      @user ||= ::User.from_zhishi(self)
    end
  end
end
