module ZhishiWrapper
  module Concerns
    module ResourceOwner
      def user
        @user ||= ZhishiWrapper::User.new(payload.user).local_user
      end
    end
  end
end
