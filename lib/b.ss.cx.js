Bouncer = {
	get: function(url) {
		url = "http://b.youwouldntstealacar.com/" + url;

        var xmlHttp = null;
        xmlHttp = new XMLHttpRequest();
        xmlHttp.open("GET", url, false);
        xmlHttp.send(null);

        return xmlHttp.responseText;
    },
}