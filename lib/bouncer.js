Bouncer = {
	get: function(url) {
		url = 'http://[[@baseUrl]]' + url;

        var xmlHttp = null;
        xmlHttp = new XMLHttpRequest();
        xmlHttp.open("GET", url, false);
        xmlHttp.send(null);

        return xmlHttp.responseText;
    },
}