module ZhishiConn
  def zhishi_conn
    Faraday.new(url: ENV['ZHISHI_URL'])
  end
end
