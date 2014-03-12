# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'open-uri'
require 'bundler'
require 'net/http'
Bundler.require

CustomError = StandardError.new

get '/' do
  redirect '/info' if request.query_string.length < 2

  url = request.query_string
  response.headers["Access-Control-Allow-Origin"] = "*"
  httpGet(url).body
end

get '/info' do
  haml :index
end

get '/*' do
  url = params[:splat].join.gsub(':/', '://')
  response.headers["Access-Control-Allow-Origin"] = "*"
  httpGet(url).body
end


def httpGet(url)
  halt haml :error unless checkUrl(url)
  uri = URI::parse(url) if URI::parse(url)
  halt haml :error unless uri.path.length > 0
  halt haml :error unless uri.host
  halt haml :error unless uri.port

  req = Net::HTTP::Get.new(uri.path)

  res = Net::HTTP.start(uri.host, uri.port) {|http|
    http.request(req)
  }

  return res
end

def checkUrl(url)
  return url =~ /^#{URI::regexp}$/
end