#BedSheet Draft v1.1.10
---
[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](http://fantom.org/)
[![pod: v1.1.10](http://img.shields.io/badge/pod-v1.1.10-yellow.svg)](http://www.fantomfactory.org/pods/afBedSheetDraft)
![Licence: MIT](http://img.shields.io/badge/licence-MIT-blue.svg)

## Overview

`BedSheetDraft` is a library for integrating [draft](https://bitbucket.org/afrankvt/draft/) components with the [BedSheet](http://pods.fantomfactory.org/pods/afBedSheet) web framework.

With `BedSheetDraft` you can:

- Use [draft Routes](http://pods.fantomfactory.org/pods/draft/api/Route)
- Use [draft Flash](http://pods.fantomfactory.org/pods/draft/api/Flash)

## Install

Install `BedSheet Draft` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://pods.fantomfactory.org/fanr/ afBedSheetDraft

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afBedSheetDraft 1.1"]

## Documentation

Full API & fandocs are available on the [Fantom Pod Repository](http://pods.fantomfactory.org/pods/afBedSheetDraft/).

## Draft Routing

Draft [Routes](http://pods.fantomfactory.org/pods/draft/api/Route) match request URIs and calls request handlers with a single map of arguments. Contribute draft routes to the [DraftRoutes](http://pods.fantomfactory.org/pods/afBedSheetDraft/api/DraftRoutes) service:

```
using afIoc
using afBedSheetDraft
using draft::Route as DraftRoute

class AppModule {

  ...

  @Contribute { serviceType=DraftRoutes# }
  static Void contributeRoutes(Configuration conf) {

    conf.add(DraftRoute("/", "GET", PageHandler#index))
    conf.add(DraftRoute("/echo/{name}/{age}", "GET", PageHandler#print))
  }
}
```

## Draft Flash

Draft [Flash](http://pods.fantomfactory.org/pods/draft/api/Flash) is contributed as a threaded service and may be accessed as such:

```
@Inject
private Flash flash
```

Note that `Flash` is not a `const` class so it may not be injected into `const` services. Instead create a flash method that accesses the [IoC](http://pods.fantomfactory.org/pods/afIoc) registry:

```
using afIoc
using draft::Flash as DraftFlash

class ThreadedHandler {
  @Inject
  private Registry registry

  new make(|This|in) { in(this) }

  DraftFlash flash() {
    registry.dependencyByType(DraftFlash#)
  }
}
```

Or you can inject a [Lazy Func](fandoc:/afIoc/doc/pod#lazyFunctions) which performs the same job:

```
using afIoc
using draft::Flash as DraftFlash

class ThreadedHandler {
  @Inject
  private |->DraftFlash| flash

  new make(|This|in) { in(this) }
}
```

