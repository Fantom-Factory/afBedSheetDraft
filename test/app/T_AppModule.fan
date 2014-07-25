using afIoc
using afBedSheet
using draft::Route as DraftRoute

internal const class T_AppModule {

	@Contribute { serviceType=DraftRoutes# }
	static Void contributeDraftRoutes(Configuration conf) {
		conf.add(DraftRoute("/", "GET", PageHandler#index))
		conf.add(DraftRoute("/echo/{name}/{age}", "GET", PageHandler#print))
	}

	@Contribute { serviceType=Routes# }
	static Void contributeRoutes(Configuration conf) {
		conf.add(Route(`/getFlash`, PageHandler#getFlash))
		conf.add(Route(`/setFlash/*`, PageHandler#setFlash))
	}

}
