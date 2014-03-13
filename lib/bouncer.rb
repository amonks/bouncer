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
    checkImg(url)
    url = fixUrl(url)
    response = HTTParty.get(url)
    return response
  end


  def checkImg(url)
    halt errorPage('I don\'t proxy images...') if url.downcase.match(/\.(png|jpg|gif|tiff|raw|ico)$/i)
  end

  def fixUrl(url)
    halt errorPage('Seems like this isn\'t a real url...') unless url.match /\./
    url = 'http://' + url unless url.include? '://'
    halt errorPage('Seems like this isn\'t a real url...') unless url =~ /^#{URI::regexp}$/
    return url
  end

end