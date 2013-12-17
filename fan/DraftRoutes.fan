using afIoc::Inject
using afIoc::Registry
using afBedSheet::ResponseProcessors
using afBedSheet::MethodCall
using draft::Route as DraftRoute

** (Service) - Contribute 'DraftRoute' objects to this.
** 
** Responsible for routing URIs to request handlers.
const mixin DraftRoutes {

	** The ordered list of routes
	abstract DraftRoute[] routes()

	** Returns true if the HTTP request was handled.
	@NoDoc	// not for public use 
	abstract Bool processRequest(Uri modRel, Str httpMethod)
}

internal const class DraftRoutesImpl : DraftRoutes {

	override const DraftRoute[] routes

	@Inject	private const ResponseProcessors	responseProcessors  

	internal new make(DraftRoute[] routes, |This|? in := null) {
		in?.call(this)
		this.routes = routes
	}

	override Bool processRequest(Uri modRel, Str httpMethod) {
		normalisedUri := normalise(modRel)

		// loop through all routes looking for a non-null response
		handled := routes.eachWhile |route| {
			args := route.match(normalisedUri, httpMethod)

			if (args == null)
				return null

			// convert draft classes into BedSheet ones
			response := MethodCall(route.handler, args.isEmpty ? Obj#.emptyList : [args])
			
			// process any non-null results
			processed := responseProcessors.processResponse(response)
			
			return processed ? true : null
		}

		return handled != null
	}

	private Uri normalise(Uri uri) {
		if (!uri.isPathAbs)
			uri = `/` + uri
		return uri
	}	
}

