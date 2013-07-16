using afBedSheet::RouteMatcher
using afBedSheet::RouteMatch
using draft::Route as DraftRoute

const class DraftRouteMatcher : RouteMatcher {
	override RouteMatch? match(Obj objRoute, Uri uri, Str httpMethod) {
		route := (DraftRoute) objRoute
		map := route.match(uri, httpMethod)
		return (map == null) ? null : RouteMatch(route.handler, [map])
	}
}
