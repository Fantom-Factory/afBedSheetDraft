## Overview 

`BedSheetDraft` is a library for integrating [draft](https://bitbucket.org/afrankvt/draft/) components with the [BedSheet](http://www.fantomfactory.org/pods/afBedSheet) web framework.

With `BedSheetDraft` you can:

- Use [draft Routes](http://repo.status302.com/doc/draft/Route.html)
- Use [draft Flash](http://repo.status302.com/doc/draft/Flash.html)

## Install 

Install `afBedSheetDraft` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afBedSheetDraft

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afBedSheetDraft 1.1+"]

## Documentation 

Full API & fandocs are available on the [Status302 repository](http://repo.status302.com/doc/afBedSheetDraft/).

## Draft Routing 

Draft [Routes](http://repo.status302.com/doc/draft/Route.html) match request URIs and calls request handlers with a single map of arguments. Contribute draft routes to the [DraftRoutes](http://repo.status302.com/doc/afBedSheetDraft/DraftRoutes.html) service:

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

Draft [Flash](http://repo.status302.com/doc/draft/Flash.html) is contributed as a threaded service and may be accessed as such:

```
@Inject
private Flash flash
```

Note that `Flash` is not a `const` class so it may not be injected into `const` services. Instead create a flash method that accesses the [afIoc](http://www.fantomfactory.org/pods/afIoc) registry:

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

