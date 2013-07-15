using afIoc
using afBedSheet
using draft::Route as DraftRoute

internal const class AppModule {
	
	static Void bind(ServiceBinder binder) {
//		binder.bindImpl(Router#)
	}
	
	@Contribute { serviceType=RouteMatchers# }
	static Void contributeRouteMatchers(MappedConfig conf) {
		conf[DraftRoute#]			= conf.autobuild(DraftRouteMatcher#)
	}

	@Contribute { serviceType=Routes# }
	static Void contributeRoutes(OrderedConfig conf) {
		conf.add(DraftRoute("/", "GET", PageHandler#index))
		conf.add(DraftRoute("/echo/{name}/{age}", "GET", PageHandler#print))
	}
}
