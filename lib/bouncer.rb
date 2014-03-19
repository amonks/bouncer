# bouncer.rb

module Bouncer

  # function to show an error page
  # accepts a message to be displayed and an http status code
  def errorPage(message, code)
    status code
    @errorMessage = message
    haml :index
  end

  # main wrapper function to proxy a url
  def bounce(url)
    out = getUzi(url,3)
    # mimic status code
    status out.code
    # mimic content type
    content_type out.headers_hash['Content-Type']
    # allow cross origin requests
    response.headers["Access-Control-Allow-Origin"] = "*"

    haml :index
    return out.body
  end

  # keep requesting a url until it works
  # accepts the url and the maximum number of tries
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

  # http get function
  def httpGet(url)
    url = 'http://' + url unless url.include? '://'
    checkImg(url)
    request = Typhoeus::Request.new(url)
    # stream the header first to check declared size
    request.on_headers do |response|
      # throw error if the file's too big
      halt errorPage('I don\'t proxy files larger than 10 megabytes', 403) if response.headers_hash['Content-Length'].to_i > 10485760
    end
    # download the rest
    response = request.run
    return response
  end


  # check urls for unsupported file extensions
  # I really ought to just look at content-type...
  def checkImg(url)
    halt errorPage('I don\'t proxy images...', 403) if url.downcase.match(/\.(png|jpe?g|gif|tif|raw|ico)/i)
    # halt errorPage('I don\'t proxy music...', 403) if url.downcase.match(/\.(mp|wav|aif|mov)/i)
  end

end