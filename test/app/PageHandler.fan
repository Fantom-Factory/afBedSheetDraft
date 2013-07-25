using afIoc
using afBedSheet
using draft::Flash as DraftFlash
using web::WebReq

internal class PageHandler {
	
	@Inject private DraftFlash flash
	
	internal new make(|This|in) { in(this) }
	
	Text index() {
		Text.fromPlain("Hi there!")
	}

	Text print(Str:Str args) {
		name := args["name"]
		age  := args["age"].toInt
		return Text.fromPlain("Hi $name, you are $age years old!")
	}
	
	Text setFlash(Str msg) {
		flash.res["msg"] = msg
		return Text.fromPlain("OK")
	}

	Text getFlash() {
		return Text.fromPlain("( " + flash.req["msg"] + " )")
	}

}
