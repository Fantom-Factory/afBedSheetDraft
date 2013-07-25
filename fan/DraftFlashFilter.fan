using afIoc::Inject
using afIoc::Registry
using afBedSheet::HttpPipeline
using afBedSheet::HttpPipelineFilter
using draft::Flash
using web::WebReq

const class DraftFlashFilter : HttpPipelineFilter {

	@Inject private const Registry registry

	internal new make(|This|in) { in(this) }

	override Bool service(HttpPipeline handler) {
		flash := (Flash?) webReq.stash["draft.flash"]
		if (flash == null) {
			map := webReq.session["draft.flash"] ?: Str:Str[:]
			webReq.stash["draft.flash"] = flash = Flash#.method("make").call(map)
		}

		handled := handler.service

		// I'm not gonna stick this in a finally, 'cos Draft doesn't and I'm emulating it's behaviour
		webReq.session["draft.flash"] = flash.res.ro
		return handled
	}

	private WebReq webReq() {
		registry.dependencyByType(WebReq#)
	}
}
