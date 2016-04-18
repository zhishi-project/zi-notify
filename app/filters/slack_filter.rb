class SlackFilter < BaseFilter
  include SlackHelper

  def sanitize_content(content)
    content.gsub(/<(?:.|\n)*?>/, '')
  end
end
