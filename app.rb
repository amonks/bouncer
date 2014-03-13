require 'bundler'
Bundler.require

# config

set :environment, :production

@baseUrl = 'b.youwouldntstealacar.com'

configure do
  set :baseUrl, @baseUrl
end

# bouncer
require_relative 'lib/bouncer'
include Bouncer

# routing

# js lib
get '/' + settings.baseUrl + '.js' do
  content_type 'application/javascript'
  File.read('lib/bouncer.js').gsub('[[@baseUrl]]', settings.baseUrl)
end
get '/' + settings.baseUrl + '.min.js' do
  content_type 'application/javascript'
  Uglifier.compile(File.read('lib/bouncer.js')).gsub('[[@baseUrl]]', settings.baseUrl)
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