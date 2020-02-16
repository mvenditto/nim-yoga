when defined(Linux):
  const dynlibYGValue = "yoga.so"

import strutils
import yoga_enums
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "yoga\"".}
type
  YGValue* {.bycopy.} = object
    value*: cfloat
    unit*: YGUnit


var YGValueAuto* {.importc: "YGValueAuto", dynlib: dynlibYGValue.}: YGValue

var YGValueUndefined* {.importc: "YGValueUndefined", dynlib: dynlibYGValue.}: YGValue

var YGValueZero* {.importc: "YGValueZero", dynlib: dynlibYGValue.}: YGValue
