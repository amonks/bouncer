# Bouncer

Bouncer is a super simple sinatra-based proxy for client apps that only need a server for making requests.

This readme concerns running your own instance of Bouncer. There's a free, working installation available for use at [b.ss.cx](http://b.youwouldntstealacar.com).

## install

	git clone https://github.com/amonks/bouncer.git
	cd bouncer

## run locally

	bundle install 
	bundle exec ruby app.rb

## push to heroku

	heroku apps:create
	git push heroku master
	heroku open