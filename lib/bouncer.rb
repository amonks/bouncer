# bouncer.rb

module Bouncer

  def errorPage(message, code)
    status code
    @errorMessage = message
    haml :index
  end

  def bounce(url)
    out = getUzi(url,3)
    status out.code
    content_type out.headers_hash['Content-Type']
    response.headers["Access-Control-Allow-Origin"] = "*"
    haml :index
    return out.body
  end

  def getUzi(url,maxRequests)
    i = 0
    test = String.new
    until (test.length > 0 or i > maxRequests)
      out = httpGet(url)
      test = out.body
      i += 1
    end
    halt errorPage(out.return_code.to_s, 404) unless test.length > 0
    return out
  end

  def httpGet(url)
    url = 'http://' + url unless url.include? '://'
    checkImg(url)
    request = Typhoeus::Request.new(url)
    request.on_headers do |response|
      halt errorPage('I don\'t proxy files larger than 10 megabytes', 403) if response.headers_hash['Content-Length'].to_i > 10485760
    end
    response = request.run
    # binding.pry
    return response
  end

  def checkImg(url)
    halt errorPage('I don\'t proxy images...', 403) if url.downcase.match(/\.(png|jpe?g|gif|tif|raw|ico)/i)
    # halt errorPage('I don\'t proxy music...', 403) if url.downcase.match(/\.(mp|wav|aif|mov)/i)
  end

end