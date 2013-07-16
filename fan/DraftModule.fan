using afIoc::Contribute
using afIoc::MappedConfig
using afBedSheet::RouteMatchers
using draft::Route as DraftRoute

const class DraftModule {
	
	@Contribute { serviceType=RouteMatchers# }
	static Void contributeRouteMatchers(MappedConfig conf) {
	// TODO: investigate why we get OpTrackerErr...?
//		conf[Route#] = conf.autobuild(DraftRouteMatcher#)
		conf[DraftRoute#] = conf.autobuild(DraftRouteMatcher#)
	}

}
