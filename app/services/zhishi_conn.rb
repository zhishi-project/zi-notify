module ZhishiConn
  def zhishi_conn
    Faraday.new(url: ENV['ZHISHI_BACKEND'])
  end
end
