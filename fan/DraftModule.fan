using afIoc::Build
using afIoc::Contribute
using afIoc::OrderedConfig
using afIoc::MappedConfig
using afIoc::ServiceScope
using afBedSheet::HttpPipeline
using afBedSheet::RouteMatchers
using draft::Flash as DraftFlash
using draft::Route as DraftRoute
using web::WebReq

internal const class DraftModule {

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
		conf.addOrdered("DraftFlashFilter", conf.autobuild(DraftFlashFilter#), ["after: BedSheetFilters"])		
	}
	
	@Contribute { serviceType=RouteMatchers# }
	static Void contributeRouteMatchers(MappedConfig conf) {
	// TODO: investigate why we get OpTrackerErr...?
//		conf[Route#] = conf.autobuild(DraftRouteMatcher#)
		conf[DraftRoute#] = conf.autobuild(DraftRouteMatcher#)
	}

}
