Bouncer = {
	get: function(url) {
		url = "http://b.ss.cx/" + url;

        var xmlHttp = null;
        xmlHttp = new XMLHttpRequest();
        xmlHttp.open("GET", url, false);
        xmlHttp.send(null);
        
        return xmlHttp.responseText;
    },
}