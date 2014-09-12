using build::BuildPod

class Build : BuildPod {

	new make() {
		podName = "afBedSheetDraft"
		summary = "A library for integrating 'draft' components with the BedSheet web framework"
		version = Version("1.1.6")

		meta = [
			"proj.name"		: "BedSheet Draft",
			"afIoc.module"	: "afBedSheetDraft::DraftModule",
			"tags"			: "web",
			"repo.private"	: "false"
		]

		index = [	
			"afIoc.module"	: "afBedSheetDraft::DraftModule"
		]

		depends = [
			"sys 1.0", 
			"wisp 1.0", 
			"web 1.0",

			// ---- Core ------------------------
			"afIoc 2.0.0+", 
			"afBedSheet 1.3.16+",
			"draft 1.0",
			
			// ---- Test ------------------------
			"afBounce 1.0.14+"
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
