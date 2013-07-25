using afBedSheet::RouteMatcher
using afBedSheet::RouteHandler
using draft::Route as DraftRoute

** Maps draft 'Routes' to request handlers.
const class DraftRouteMatcher : RouteMatcher {

	override RouteHandler? match(Obj objRoute, Uri uri, Str httpMethod) {
		route := (DraftRoute) objRoute
		args := route.match(uri, httpMethod)
		return (args == null) ? null : RouteHandler(route.handler, [args])
	}

}
