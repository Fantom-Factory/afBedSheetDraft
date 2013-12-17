using afIoc
using afBedSheet::HttpPipeline
using draft::Flash as DraftFlash
using draft::Route as DraftRoute
using web::WebReq

** The [afIoc]`http://repo.status302.com/doc/afIoc/#overview` module that configures 
** [draft]`https://bitbucket.org/afrankvt/draft/` with 
** [BedSheet]`http://repo.status302.com/doc/afBedSheet/#overview`.
const class DraftModule {
	
	static Void bind(ServiceBinder binder) {
		binder.bindImpl(DraftRoutes#)		
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
	
	@Contribute { serviceType=HttpPipeline# }
	static Void contributeHttpPipeline(OrderedConfig conf) {
		conf.addOrdered("DraftFlashFilter",  conf.autobuild(DraftFlashFilter#),  ["after: BedSheetFilters"])		
		conf.addOrdered("DraftRoutesFilter", conf.autobuild(DraftRoutesFilter#), ["after: BedSheetFilters", "after: DraftFlashFilter"])		
	}

}
