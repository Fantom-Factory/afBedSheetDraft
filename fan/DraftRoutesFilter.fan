using afIoc
using afBedSheet

** A HTTP filter that that adds draft routing.
internal const class DraftRoutesFilter : HttpPipelineFilter {
	@Inject private const DraftRoutes	routes
	@Inject	private const HttpRequest	httpRequest

	new make(|This|in) { in(this) }

	override Bool service(HttpPipeline handler) {
		handled := routes.processRequest(httpRequest.modRel, httpRequest.httpMethod)
		return handled ? true : handler.service
	}	
}
