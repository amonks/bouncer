require 'bundler'
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
  status 404
  @errorMessage  = message
  haml :index
end

# functions

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