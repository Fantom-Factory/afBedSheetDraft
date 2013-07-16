using web::WebClient

internal class TestDraftRoute : AppTest {

	Void testIndex() {
		res := getAsStr(`/`)
		verifyEq(res, "Hi there!")
	}

	Void testEcho() {
		res := getAsStr(`/echo/Laura/29`)
		verifyEq(res, "Hi Laura, you are 29 years old!")
	}
}
