using afIoc::Inject
using afIoc::Scope
using afBedSheet::Middleware
using afBedSheet::MiddlewarePipeline
using draft::Flash as DraftFlash
using web::WebReq

** A HTTP filter that ensures draft 'Flash' is saved to your session at the end of a request.
internal const class DraftFlashMiddleware : Middleware {

	@Inject private const |->Scope| scope

	internal new make(|This|in) { in(this) }

	override Void service(MiddlewarePipeline pipeline) {
		flash := draftFlash()

		pipeline.service

		// I'm not gonna stick this in a finally, 'cos Draft doesn't and I'm emulating it's behaviour
		webReq.session["draft.flash"] = flash.res.ro
	}

	private DraftFlash draftFlash() {
		scope().serviceByType(DraftFlash#)
	}

	private WebReq webReq() {
		scope().serviceByType(WebReq#)
	}
}
