using afIoc
using afBedSheet::MiddlewarePipeline
using draft::Flash as DraftFlash
using draft::Route as DraftRoute
using web::WebReq

** The [IoC]`pod:afIoc` module that configures [draft]`pod:draft` with [BedSheet]`pod:afBedSheet`.
const class DraftModule {
	
	static Void defineServices(ServiceDefinitions defs) {
		defs.add(DraftRoutes#)
	}

	@Build { serviceId="DraftFlash"; scope=ServiceScope.perThread }
	static DraftFlash buildDraftFlash(WebReq webReq) {
		flash := (DraftFlash?) webReq.stash["draft.flash"]
		if (flash == null) {
			map := webReq.session["draft.flash"] ?: Str:Str[:]
			webReq.stash["draft.flash"] = flash = DraftFlash#.method("make").call(map)
		}
		return flash
	}
	
	@Contribute { serviceType=MiddlewarePipeline# }
	static Void contributeMiddlewarePipeline(Configuration config) {
		config.set("DraftFlash",  config.autobuild(DraftFlashMiddleware#))
		config.set("DraftRoutes", config.autobuild(DraftRoutesMiddleware#)).after("DraftFlash")		
	}

}
