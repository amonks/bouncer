require 'bundler'
Bundler.require

# bouncer
require_relative 'lib/bouncer'
include Bouncer

# routing

# js lib
get '/b.ss.cx.min.js' do
  Uglifier.compile((File.read("lib/b.ss.cx.js")))
end

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