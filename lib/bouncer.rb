# bouncer.rb

module Bouncer

  def errorPage(message)
    status 404
    @errorMessage  = message
    haml :index
  end

  def bounce(url)
    out = fetch(url,3)
    response.headers["Access-Control-Allow-Origin"] = "*"
    return out
  end

  def fetch(url,maxRequests)
    i = 0
    out = String.new
    until (i > maxRequests or out.length > 0)
      out = httpGet(url).body
    end
    return out
  end

  def httpGet(url)
    url = 'http://' + url unless url.include? '://'
    checkImg(url)
    response = HTTParty.get(url)
    halt errorPage('I got a 404 from the server...') if response.code == 404
    return response
  rescue
    halt errorPage('I couldn\'t connect to that server...')
  end

  def checkImg(url)
    halt errorPage('I don\'t proxy images...') if url.downcase.match(/\.(png|jpg|gif|tiff|raw|ico)$/i)
  end

end