# Bouncer

Bouncer is a super simple sinatra-based proxy for client apps that only need a server for making requests.

Bouncer uses [puma](http://puma.io/) for multithreaded asynchronicity. You can change the maximum number of threads or workers in `config/puma.rb`.

This readme concerns running your own instance of Bouncer. There's a free, working installation available for use at [b.ss.cx](http://b.ss.cx).


## install

	git clone https://github.com/amonks/bouncer.git
	cd bouncer

## configure

edit `@baseUrl = 'b.ss.cx'` in `app.rb` to your own baseUrl

## run locally

set `@baseurl` to `'localhost:3000'`

	bundle install 
	bundle exec puma -C config/puma.rb

open `http://localhost:3000` in your browser

## push to heroku

	heroku apps:create

set `@baseurl` to the url heroku gives you

	git commit -am 'set url'
	git push heroku master
	heroku open

### protip: install newrelic addon to prevent your app from going to sleep

	heroku addons:add newrelic

go to the app's page on your heroku dashboard and click newrelic to get to your New Relic dashboard. Follow their instructions, generating a `newrelic.yml` file and putting it in `config/`.

	git commit -am 'configure newrelic'
	git push heroku master