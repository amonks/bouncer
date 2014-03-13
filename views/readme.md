## Howdy!

### I'm [Andrew](http://monks.co/).

#### Are you into client-side development?

I am. I gotta say—I'm a follower. I've wholeheartedly jumped on the all-client-side-everything bandwagon. But there are some things you traditionally can't do on the client side.

#### Have you ever tried to load externally-hosted data from javascript?

The 90% of the times when I have to resort to server-side code, it's to get data from a website—make an API request, load a page, who knows. 

If you try to make an HTTP request from client-side javascript, you'll usually get an error because of the [same-origin policy](http://en.wikipedia.org/wiki/Same-origin_policy). Essentially servers keep a whitelist of hosts that can request each page from javascript.

### b.ss.cx!

In comes `b.ss.cx`. It's a super simple proxy for getting around the same-origin policy. It accepts requests from anyone anywhere. 

Simply add `http://b.ss.cx/` to the beginning of the url you're requesting, eg `http://b.ss.cx/google.com`.

Or, include the [tiny js library](/b.ss.cx.min.js) and try `Bouncer.get('google.com');`

#### Is it reliable?

Yes. I'm working on optimizing the server to make sure everything's all speedy and asynchronous.

#### Sustainable?

If hosting bills get out of hand, I might eventually implement a very high rate limit, or charge for additional features like encrypted storage of API keys or proxying media files.