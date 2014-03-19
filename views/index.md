## Howdy! <span class="small">I'm [Andrew](http://monks.co/).</span>

#### Are you into client-side development?

I am. 

I gotta say—I'm a follower. I've wholeheartedly jumped on the all-client-side-everything bandwagon. But there are some things you traditionally can't do on the client side.

#### Have you ever tried to load externally-hosted data from javascript?

The 90% of the times when I have to resort to server-side code, it's to get data from a website—make an API request, load a page, who knows. 

If you try to make an HTTP request from client-side javascript, you'll usually get an error because of the [same-origin policy](http://en.wikipedia.org/wiki/Same-origin_policy). Essentially servers keep a whitelist of hosts that can request each page from javascript.

### [[@baseUrl]]!

In comes `[[@baseUrl]]`. It's a super simple proxy for getting around the same-origin policy. It accepts requests from anyone anywhere. 

#### How?

Simply add `http://[[@baseUrl]]/` to the beginning of the url you're requesting, eg `http://[[@baseUrl]]/google.com`.

Or, include the [tiny js library](/[[@baseUrl]].js) ([152b minified](/[[@baseUrl]].min.js)) and try `Bouncer.get('google.com');`.

It's configurerd not to proxy anything you could pull in through an `img` tag (determined by file extension), or any files over 10 megabytes (determined by HTTP header).

If you're super serious, or you need to proxy larger files, you can [run the server](http://github.com/amonks/bouncer) yourself.