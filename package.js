// Modified from:
// https://github.com/meteor/meteor/blob/release/METEOR%400.9.4/packages/force-ssl/package.js

Package.describe({
	summary: "This package redirects insecure connections to secure connection.",
	version: "0.0.1",
	name: "jonime:force-ssl",
	git: "https://github.com/jonime/meteor-force-ssl.git"
});

Package.onUse(function (api) {
	api.versionsFrom('METEOR@0.9.4');
	api.use('webapp', 'server');
	api.use([
		'underscore',
		'coffeescript'
	]);
	api.use('ddp', 'server');

	api.add_files('force_ssl_common.coffee', ['client', 'server']);
	api.add_files('force_ssl_server.coffee', 'server');
});

Package.onTest(function (api) {
	api.use([
		'jonime:force-ssl',
		'tinytest',
		'test-helpers',
		'coffeescript'
	]);

	api.addFiles([
		'test/test_private_addresses.coffee'
	], 'server');
});