require 'bundler'
Bundler.require

# bouncer
require_relative 'lib/bouncer'
include Bouncer

# routing

# index or query string
get '/' do
  halt haml :index if request.query_string.length < 2

  url = request.query_string

  response.headers["Access-Control-Allow-Origin"] = "*"
  bounce(url)
end

# url
get '/*' do
  url = params[:splat].join.gsub(':/', '://')

  response.headers["Access-Control-Allow-Origin"] = "*"
  bounce(url)
end