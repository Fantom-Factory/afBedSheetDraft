using afIoc::Contribute
using afIoc::OrderedConfig
using afIoc::MappedConfig
using afBedSheet::HttpPipeline
using afBedSheet::RouteMatchers
using draft::Route as DraftRoute

const class DraftModule {
	
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
