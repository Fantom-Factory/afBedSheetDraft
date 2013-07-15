using afBedSheet

internal const class PageHandler {
	
	TextResponse index() {
		TextResponse.fromPlain("Hi there!")
	}

	TextResponse print(Str:Str args) {
		name := args["name"]
		age  := args["age"].toInt
		return TextResponse.fromPlain("Hi $name, you are $age years old!")
	}
}
