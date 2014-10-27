Tinytest.add 'Force-ssl - Test private addresses', (test) ->
	test.isTrue isPrivateAddress '192.168.129.120'
	test.isTrue isPrivateAddress '10.34.23.51'
	test.isTrue isPrivateAddress '172.16.53.23'
	test.isTrue isPrivateAddress '172.31.0.1'

	test.isFalse isPrivateAddress '8.8.8.8'
	test.isFalse isPrivateAddress '172.32.0.1'
