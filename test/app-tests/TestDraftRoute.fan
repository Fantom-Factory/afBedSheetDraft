using afBounce

internal class TestDraftRoute : Test {

	BedClient? client
	
	override Void setup() {
		client = BedServer(T_AppModule#).addModule(DraftModule#).startup.makeClient
	}
	
	override Void teardown() {
		client.shutdown
	}

	Void testIndex() {
		res := client.get(`/`)
		verifyEq(res.body.str, "Hi there!")
	}

	Void testEcho() {
		res := client.get(`/echo/Laura/29`)
		verifyEq(res.body.str, "Hi Laura, you are 29 years old!")
	}
}
