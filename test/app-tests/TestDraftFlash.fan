using afBounce

internal class TestDraftFlash2 : Test {

	BedClient? client
	
	override Void setup() {
		client = BedServer(T_AppModule#).addModule(DraftModule#).startup.makeClient
	}
	
	override Void teardown() {
		client.shutdown
	}	

	Void testFlash() {
		res := client.get(`/getFlash`)
		verifyEq(res.body.str, "( null )")

		res = client.get(`/setFlash/Dull`)
		verifyEq(res.body.str, "OK")
		
		res = client.get(`/getFlash`)
		verifyEq(res.body.str, "( Dull )")

		res = client.get(`/getFlash`)
		verifyEq(res.body.str, "( null )")
	}
}
