using afIoc
using afBedSheet
using draft::Flash
using web::WebReq

internal const class PageHandler {
	
	@Inject private const Registry registry
	
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
		flash := (Flash?) webReq.stash["draft.flash"]
		flash.res["msg"] = msg
		return Text.fromPlain("OK")
	}

	Text getFlash() {
		flash := (Flash?) webReq.stash["draft.flash"]
		return Text.fromPlain("( " + flash.req["msg"] + " )")
	}

	private WebReq webReq() {
		registry.dependencyByType(WebReq#)
	}	
}
