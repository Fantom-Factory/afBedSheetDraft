using build::BuildPod

class Build : BuildPod {

	new make() {
		podName = "afBedSheetDraft"
		summary = "A library for integrating 'draft' components with the afBedSheet web framework."
		version = Version("1.1.2")

		meta = [
			"org.name"		: "Alien-Factory",
			"org.uri"		: "http://www.alienfactory.co.uk/",
			"proj.name"		: "afBedSheetDraft",
			"proj.uri"		: "",
			"vcs.uri"		: "https://bitbucket.org/AlienFactory/afbedsheetdraft",
			"license.name"	: "BSD 2-Clause License",
			"repo.private"	: "false",

			"afIoc.module"	: "afBedSheetDraft::DraftModule"
		]

		index = [	
			"afIoc.module"	: "afBedSheetDraft::DraftModule"
		]

		depends = [
			"sys 1.0", 
			"wisp 1.0", 
			"web 1.0",
			"afIoc 1.5.2+", 
			"afBedSheet 1.3.0+",
			"draft 1.0",
			
			// for testing
			"afBounce 0+"
		]

		srcDirs = [`test/app-tests/`, `test/app/`, `fan/`]
		resDirs = [`doc/`]

		docApi = true
		docSrc = true
	}
}
