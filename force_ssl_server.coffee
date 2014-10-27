# Modified from:
# https://github.com/meteor/meteor/blob/release/METEOR%400.9.4/packages/force-ssl/force_ssl_server.js

url = Npm.require("url")

httpServer = WebApp.httpServer
oldHttpServerListeners = httpServer.listeners("request").slice(0)
httpServer.removeAllListeners "request"
httpServer.addListener "request", (req, res) ->
	remoteAddress = req.connection.remoteAddress or req.socket.remoteAddress

	isPrivate = (isPrivateAddress(remoteAddress) and (not req.headers["x-forwarded-for"] or _.all(req.headers["x-forwarded-for"].split(","), (x) ->
		isPrivateAddress x
	)))

	isSsl = req.connection.pair or (req.headers["x-forwarded-proto"] and req.headers["x-forwarded-proto"].indexOf("https") isnt -1)

	if not isPrivate and not isSsl
		host = url.parse(Meteor.absoluteUrl()).hostname
		host = host.replace(/:\d+$/, "")
		res.writeHead 302,
			Location: "https://" + host + req.url

		res.end()
		return

	args = arguments
	_.each oldHttpServerListeners, (oldListener) ->
		oldListener.apply httpServer, args
		return

	return

@isPrivateAddress = (address) ->
	return true if /^\s*(127\.0\.0\.1|::1)\s*$/.test address
	return true if /^\s*(10\.\d+\.\d+\.\d+)\s*$/.test address
	return true if /^\s*(192\.168\.\d+\.\d+)\s*$/.test address
	return true if /^\s*(172\.(1[6-9]|2[0-9]|3[01])\.\d+\.\d+)\s*$/.test address
	return false
