module SlackWrapper
  class Profile
    attr_accessor :first_name, :last_name, :real_name, :email, :image_sm, :image_md, :image_lg

    def initialize(options={})
      @first_name = options[:first_name]
      @last_name = options[:last_name]
      @real_name = options[:real_name]
      @email = options[:email]
      @image_sm = options[:image_32]
      @image_md = options[:image_192]
      @image_lg = options[:image_512]
    end
  end
end
