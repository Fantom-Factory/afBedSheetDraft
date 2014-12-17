using build::BuildPod

class Build : BuildPod {

	new make() {
		podName = "afBedSheetDraft"
		summary = "A library for integrating 'draft' components with the BedSheet web framework"
		version = Version("1.1.9")

		meta = [
			"proj.name"		: "BedSheet Draft",
			"afIoc.module"	: "afBedSheetDraft::DraftModule",
			"tags"			: "web",
			"repo.private"	: "true"
		]

		index = [	
			"afIoc.module"	: "afBedSheetDraft::DraftModule"
		]

		depends = [
			"sys 1.0", 
			"wisp 1.0", 
			"web 1.0",

			// ---- Core ------------------------
			"afIoc      2.0.2 - 2.0", 
			"afBedSheet 1.4.2 - 1.4",
			"draft      1.0",
			
			// ---- Test ------------------------
			"afBounce   1.0.18 - 1.0"
		]

		srcDirs = [`test/app-tests/`, `test/app/`, `fan/`]
		resDirs = [`doc/`]
	}
	
	override Void compile() {
		// remove test pods from final build
		testPods := "afBounce".split
		depends = depends.exclude { testPods.contains(it.split.first) }
		super.compile
	}
}
