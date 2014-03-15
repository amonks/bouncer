# bouncer.rb

module Bouncer

  def errorPage(message)
    status 404
    @errorMessage  = message
    haml :index
  end

  def bounce(url)
    out = fetch(url,3)
    status out.code
    response.headers["Access-Control-Allow-Origin"] = "*"
    return out.body
  end

  def fetch(url,maxRequests)
    i = 0
    out = String.new
    out = httpGet(url)
    return out
  end

  def httpGetOld(url)
    url = 'http://' + url unless url.include? '://'
    checkImg(url)
    response = HTTParty.get(url)
    status response.code
    return response
  rescue
    halt errorPage('I couldn\'t connect to that server...')
  end

  def httpGet(url)
    url = 'http://' + url unless url.include? '://'
    checkImg(url)
    request = Typhoeus::Request.new(url)
    response = request.run
    return response
  end

  def checkImg(url)
    halt errorPage('I don\'t proxy images...') if url.downcase.match(/\.(png|jpg|gif|tif|raw|ico)/i)
    halt errorPage('I don\'t proxy music...') if url.downcase.match(/\.(mp|wav|aif|mov)/i)
  end

end