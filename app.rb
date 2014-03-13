require 'bundler'
require 'net/http'
Bundler.require

# routing

# index or query string
get '/' do
  halt haml :index if request.query_string.length < 2

  url = request.query_string
  bounce(url)
end

# url
get '/*' do
  url = params[:splat].join.gsub(':/', '://')
  bounce(url)
end

def errorPage(message)
  @message  = message
  haml :error
end

# functions

def httpGet(url)
  uri = validateAndParseUrl(url)

  req = Net::HTTP::Get.new(uri.path)

  res = Net::HTTP.start(uri.host, uri.port) {|http|
    http.request(req)
  }

  return res
end

def checkUri(uri)
  halt errorPage('Seems like this isn\'t a real url...') unless uri.path.length > 0
  halt errorPage('I can\'t find the host domain...') unless uri.host
  halt errorPage('I can\'t choose a port...') unless uri.port
end

def checkImg(url)
  halt haml :type if url.downcase.match(/\.(png|jpg|gif|tiff|raw)$/i)
end

def fixUrl(url)
  url = 'http://' + url unless url.include? '://'
  halt errorPage('I can\'t handle `https://` requests...') if url.match(/^https/)
  url =  url + '/' unless url.match(/\/\/.*\/\./)
  halt errorPage('Seems like this isn\'t a real url...') unless url =~ /^#{URI::regexp}$/
  return url
end

def bounce(url)
  response.headers["Access-Control-Allow-Origin"] = "*"
  out = fetch(url,3)
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

def validateAndParseUrl(url)
  checkImg(url)
  url = fixUrl(url)
  uri = URI::parse(url) if URI::parse(url)
  checkUri(uri)
  return uri
end