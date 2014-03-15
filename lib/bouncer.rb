# bouncer.rb

module Bouncer

  def errorPage(message, code)
    status code
    @errorMessage = message
    haml :index
  end

  def bounce(url)
    out = fetch(url,3)
    status out.code
    response.headers["Access-Control-Allow-Origin"] = "*"
    haml :index
    return out.body
  end

  def fetch(url,maxRequests)
    i = 0
    test = String.new
    until (test.length > 0 or i > maxRequests)
      out = httpGet(url)
      test = out.body
      i += 1
    end
    halt errorPage(out.return_code.to_s, out.code) unless response.body.length > 0
    return out
  end

  def httpGet(url)
    url = 'http://' + url unless url.include? '://'
    checkImg(url)
    request = Typhoeus::Request.new(url)
    response = request.run
    return response
  end

  def checkImg(url)
    halt errorPage('I don\'t proxy images...', 403) if url.downcase.match(/\.(png|jpe?g|gif|tif|raw|ico)/i)
    halt errorPage('I don\'t proxy music...', 403) if url.downcase.match(/\.(mp|wav|aif|mov)/i)
  end

end