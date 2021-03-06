# Copyright (c) 2018, Shimoda <kuri65536 at hotmail dot com>
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
import jsffi
import dom

import firefox_stub

type
  jQuerySelector* = ref object of RootObj
    dmy: int

  JQuery* = ref jQueryObj
  jQueryObj {.importc.} = object of RootObj
    ready*: cstring



{.push importcpp.}

proc off*(jq: jQuerySelector, ev_name: cstring): jQuerySelector {.discardable.}
proc on*(jq: jQuerySelector, ev_name: cstring,
         cb: proc (ev: Event): bool): jQuerySelector {.discardable.}

proc html*(jq: jQuerySelector): cstring
proc text*(jq: jQuerySelector): cstring
proc text*(jq: jQuerySelector, val: cstring): jQuerySelector {.discardable.}
proc attr*(jq: jQuerySelector, name: cstring): cstring
proc val*(jq: jQuerySelector): cstring
proc val*(jq: jQuerySelector, newval: cstring): jQuerySelector {.discardable.}
proc attr*(jq: jQuerySelector, name: cstring, src: cstring): jQuerySelector
proc append*(jq: jQuerySelector, src: jQuerySelector): jQuerySelector
proc append*(jq: jQuerySelector, src: cstring): jQuerySelector {.discardable.}
proc remove*(jq: jQuerySelector): jQuerySelector {.discardable.}

proc css*(jq: jQuerySelector,
          name: cstring, value: cstring): jQuerySelector {.discardable.}

{.pop.}

proc len*(jq: jQuerySelector): int {.importcpp: "#.length" .}
proc `[]`*(jq: jQuerySelector, i: int): Element {.importcpp: "#[#]" .}

proc jq*(doc: Document): jQuerySelector {.importc: "jQuery", nodecl.}
proc jq*(selector: cstring): jQuerySelector {.importc: "jQuery", nodecl.}
proc jq*(selector: cstring,
         sel: Node): jQuerySelector {.importc: "jQuery", nodecl.}

proc jqwhen*(jq: JQuery, src: cstring): JsPromise
    {.importcpp: "when" .}

var jQuery* {.importc, nodecl.}: JQuery

{.push importcpp.}
proc ajax*(jq: JQuery, url: cstring): JsPromise

{.pop.}

# vi: ft=nim:et:sw=4:tw=80:nowrap
