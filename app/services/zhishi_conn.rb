module ZhishiConn
  def zhishi_conn
    Faraday.new(url: 'http://localhost:3000/')
  end
end
