module ZhishiWrapper
  class User < ZhishiWrapper::Base
    delegate :id, :name, :email, :points, :image, to: :payload
    # attr_reader :id, :name, :email, :points, :image
    def local_user
      @user ||= ::User.from_zhishi(self)
    end
  end
end
# ::User.get_by_email(email)
