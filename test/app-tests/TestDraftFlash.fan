using web::WebClient

internal class TestDraftFlash : AppTest {

	Void testFlash() {
		verifyEq(getAsStr(`/getFlash`), "( null )")
		cookie := client.resHeaders["Set-Cookie"].replace(";Path=/", "")
		
		client = WebClient()
		client.reqHeaders["Cookie"] = cookie
		verifyEq(getAsStr(`/setFlash/Dull`), "OK")

		client = WebClient()
		client.reqHeaders["Cookie"] = cookie
		verifyEq(getAsStr(`/getFlash`), "( Dull )")
		
		client = WebClient()
		client.reqHeaders["Cookie"] = cookie
		verifyEq(getAsStr(`/getFlash`), "( null )")
	}
}
