# Bouncer

Bouncer is a super simple sinatra-based proxy for client apps that only need a server for making requests.

This readme concerns running your own instance of Bouncer. There's a free, working installation available for use at [b.ss.cx](http://b.youwouldntstealacar.com).

## install

	git clone https://github.com/amonks/bouncer.git
	cd bouncer

## configure

edit `@baseUrl = 'b.ss.cx'` in `app.rb` to your own baseUrl

## run locally

set `@baseurl` to `'localhost:4567'`

	bundle install 
	bundle exec ruby app.rb

## push to heroku

	heroku apps:create

set `@baseurl` to the url heroku gives you

	git commit -am 'set url'
	git push heroku master
	heroku open