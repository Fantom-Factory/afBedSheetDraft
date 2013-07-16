using afIoc
using afBedSheet
using draft::Route as DraftRoute

internal const class T_AppModule {
	
	static Void bind(ServiceBinder binder) {
//		binder.bindImpl(Router#)
	}
	
	// TODO: investigate why we get OpTrackerErr...?
	@Contribute { serviceType=RouteMatchers# }
	static Void contributeRouteMatchers(MappedConfig conf) {
//		conf[Route#] = conf.autobuild(DraftRouteMatcher#)
		conf[DraftRoute#] = conf.autobuild(DraftRouteMatcher#)
	}

	@Contribute { serviceType=Routes# }
	static Void contributeRoutes(OrderedConfig conf) {
		conf.add(DraftRoute("/", "GET", PageHandler#index))
		conf.add(DraftRoute("/echo/{name}/{age}", "GET", PageHandler#print))
	}
}
