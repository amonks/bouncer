## Hi!

Ever tried to make an HTTP GET request from client-side JavaScript? Maybe to access an API or something?

You can't unless the page you're requesting specifically whitelisted you!

It's terrible!

That's why Bouncer exists. It's a super simple proxy for client-side HTTP requests. It accepts requests from anyone anywhere. 

Simply add `http://b.ss.cx/` to the beginning of the url you're requesting, eg `http://b.ss.cx/http://google.com/`