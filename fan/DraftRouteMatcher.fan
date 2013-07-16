using afBedSheet::RouteMatcher
using afBedSheet::RouteMatch
using draft::Route as DraftRoute

const class DraftRouteMatcher : RouteMatcher {

	override RouteMatch? match(Obj objRoute, Uri uri, Str httpMethod) {
		route := (DraftRoute) objRoute
		args := route.match(uri, httpMethod)
		return (args == null) ? null : RouteMatch(route.handler, [args])
	}

}
