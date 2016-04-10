using afIoc
using afBedSheet::MiddlewarePipeline
using draft::Flash as DraftFlash
using draft::Route as DraftRoute
using web::WebReq

** The IoC module that configures draft with BedSheet.
const class DraftModule {
	
	Void defineServices(RegistryBuilder defs) {
		defs.addService(DraftRoutes#)
	}

	@Build { serviceId="DraftFlash" }
	DraftFlash buildDraftFlash(WebReq webReq) {
		flash := (DraftFlash?) webReq.stash["draft.flash"]
		if (flash == null) {
			map := webReq.session["draft.flash"] ?: Str:Str[:]
			webReq.stash["draft.flash"] = flash = DraftFlash#.method("make").call(map)
		}
		return flash
	}
	
	@Contribute { serviceType=MiddlewarePipeline# }
	Void contributeMiddlewarePipeline(Configuration config) {
		config.set("DraftFlash",  config.build(DraftFlashMiddleware#)).before("afBedSheet.routes")
//		config.set("DraftRoutes", config.build(DraftRoutesMiddleware#)).after("DraftFlash")		
	}
}
