using afIoc
using afBedSheet::MiddlewarePipeline
using draft::Flash as DraftFlash
using draft::Route as DraftRoute
using web::WebReq

** The [afIoc]`http://repo.status302.com/doc/afIoc/#overview` module that configures 
** [draft]`https://bitbucket.org/afrankvt/draft/` with 
** [BedSheet]`http://repo.status302.com/doc/afBedSheet/#overview`.
const class DraftModule {
	
	static Void bind(ServiceBinder binder) {
		binder.bind(DraftRoutes#)
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
