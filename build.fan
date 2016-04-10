using build::BuildPod

class Build : BuildPod {

	new make() {
		podName = "afBedSheetDraft"
		summary = "A library for integrating 'draft' components with the BedSheet web framework"
		version = Version("1.1.10")

		meta = [
			"proj.name"		: "BedSheet Draft",
			"afIoc.module"	: "afBedSheetDraft::DraftModule",
			"repo.tags"		: "web",
			"repo.public"	: "true"
		]

		index = [	
			"afIoc.module"	: "afBedSheetDraft::DraftModule"
		]

		depends = [
			"sys  1.0.68 - 1.0", 
			"wisp 1.0.68 - 1.0", 
			"web  1.0.68 - 1.0",

			// ---- Core ------------------------
			"afIoc      3.0.0 - 3.0", 
			"afBedSheet 1.5.0 - 1.5",
			"draft      1.0",
			
			// ---- Test ------------------------
			"afBounce   1.1.0 - 1.1"
		]

		srcDirs = [`fan/`, `test/app/`, `test/app-tests/`]
		resDirs = [`doc/`]

		meta["afBuild.testPods"]	= "afBounce"
	}	
}
