class User < ActiveRecord::Base
  has_paper_trail
  EMAIL_FORMAT= /(?<email>[.\w-]+@andela).co[m]?\z/
  after_update :notify_of_changes, if: :slack_name_changed?

  def self.from_slack(slack_user)
    uuid = slack_user.uuid
    email = slack_user.email
    slack_username = slack_user.slack_name
    user = where("slack_id = :slack_id OR email LIKE :email", slack_id: uuid, email: match_email(email)).first_or_create do |user|
      user.email = email
      user.name = slack_user.name
      user.slack_id = uuid
      user.slack_name = slack_username
    end
    user.update(slack_id: uuid, slack_name: slack_username) unless user.new_record?
    user
  end

  def self.from_zhishi(zhishi_user)
    zhi_id = zhishi_user.id
    email = zhishi_user.email
    zhi_name = zhishi_user.name
    user = where("zhishi_id = :zhishi_id OR email LIKE :email", zhishi_id: zhi_id, email: match_email(email)).first_or_create do |user|
      user.email = email
      user.zhishi_id = zhi_id
      user.zhishi_name = zhi_name
    end
    user.update(zhishi_id: zhi_id, zhishi_name: zhi_name) unless user.new_record?
    user
  end

  def self.from_zhishi_collection(collection=[])
    where(zhishi_id: collection)
  end

  def self.match_email(email)
    grabbed = EMAIL_FORMAT.match(email).try(:[], :email)
    grabbed ? "#{grabbed}%" : email
  end

  def self.get_by_email(email)
    where("email LIKE :email", email: match_email(email)).first
  end

  def notify_of_changes
    # we ought to notify zhishi backend of the changes
    old_name, new_name = changes['slack_name']
    {old: old_name, new: new_name}
  end

  def send_message(resource, service:)
    service.inform(self, resource_obj: resource)
  end

  def email_params
    "#{zhishi_name} <#{email}>"
  end

  def valid_zhishi_user?
    zhi_id.present?
  end
end
