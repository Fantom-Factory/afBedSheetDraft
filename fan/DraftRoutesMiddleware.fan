using afIoc
using afBedSheet

** A HTTP filter that that adds draft routing.
internal const class DraftRoutesMiddleware : Middleware {
	@Inject private const DraftRoutes	routes
	@Inject	private const HttpRequest	httpRequest

	new make(|This|in) { in(this) }

	override Bool service(MiddlewarePipeline pipeline) {
		handled := routes.processRequest(httpRequest.url, httpRequest.httpMethod)
		return handled ? true : pipeline.service
	}	
}
