using afIoc::Inject
using afIoc::Registry
using afBedSheet::Middleware
using afBedSheet::MiddlewarePipeline
using draft::Flash as DraftFlash
using web::WebReq

** A HTTP filter that ensures draft 'Flash' is saved to your session at the end of a request.
internal const class DraftFlashMiddleware : Middleware {

	@Inject private const Registry 		registry

	internal new make(|This|in) { in(this) }

	override Bool service(MiddlewarePipeline pipeline) {
		flash := draftFlash()

		handled := pipeline.service

		// I'm not gonna stick this in a finally, 'cos Draft doesn't and I'm emulating it's behaviour
		webReq.session["draft.flash"] = flash.res.ro
		return handled
	}

	private DraftFlash draftFlash() {
		registry.dependencyByType(DraftFlash#)
	}

	private WebReq webReq() {
		registry.dependencyByType(WebReq#)
	}
}
