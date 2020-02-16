when defined(Linux):
  const dynlibYGEnums = "yoga.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "yoga\"".}
type
  YGAlign* {.size: sizeof(cint).} = enum
    YGAlignAuto, YGAlignFlexStart, YGAlignCenter, YGAlignFlexEnd, YGAlignStretch,
    YGAlignBaseline, YGAlignSpaceBetween, YGAlignSpaceAround


proc YGAlignToString*(a1: YGAlign): cstring {.cdecl, importc: "YGAlignToString",
    dynlib: dynlibYGEnums.}
type
  YGDimension* {.size: sizeof(cint).} = enum
    YGDimensionWidth, YGDimensionHeight


proc YGDimensionToString*(a1: YGDimension): cstring {.cdecl,
    importc: "YGDimensionToString", dynlib: dynlibYGEnums.}
type
  YGDirection* {.size: sizeof(cint).} = enum
    YGDirectionInherit, YGDirectionLTR, YGDirectionRTL


proc YGDirectionToString*(a1: YGDirection): cstring {.cdecl,
    importc: "YGDirectionToString", dynlib: dynlibYGEnums.}
type
  YGDisplay* {.size: sizeof(cint).} = enum
    YGDisplayFlex, YGDisplayNone


proc YGDisplayToString*(a1: YGDisplay): cstring {.cdecl,
    importc: "YGDisplayToString", dynlib: dynlibYGEnums.}
type
  YGEdge* {.size: sizeof(cint).} = enum
    YGEdgeLeft, YGEdgeTop, YGEdgeRight, YGEdgeBottom, YGEdgeStart, YGEdgeEnd,
    YGEdgeHorizontal, YGEdgeVertical, YGEdgeAll


proc YGEdgeToString*(a1: YGEdge): cstring {.cdecl, importc: "YGEdgeToString",
                                        dynlib: dynlibYGEnums.}
type
  YGExperimentalFeature* {.size: sizeof(cint).} = enum
    YGExperimentalFeatureWebFlexBasis


proc YGExperimentalFeatureToString*(a1: YGExperimentalFeature): cstring {.cdecl,
    importc: "YGExperimentalFeatureToString", dynlib: dynlibYGEnums.}
type
  YGFlexDirection* {.size: sizeof(cint).} = enum
    YGFlexDirectionRow,YGFlexDirectionRowReverse,YGFlexDirectionColumn,YGFlexDirectionColumnReverse


proc YGFlexDirectionToString*(a1: YGFlexDirection): cstring {.cdecl,
    importc: "YGFlexDirectionToString", dynlib: dynlibYGEnums.}
type
  YGJustify* {.size: sizeof(cint).} = enum
    YGJustifyFlexStart, YGJustifyCenter, YGJustifyFlexEnd, YGJustifySpaceBetween,
    YGJustifySpaceAround, YGJustifySpaceEvenly


proc YGJustifyToString*(a1: YGJustify): cstring {.cdecl,
    importc: "YGJustifyToString", dynlib: dynlibYGEnums.}
type
  YGLogLevel* {.size: sizeof(cint).} = enum
    YGLogLevelError, YGLogLevelWarn, YGLogLevelInfo, YGLogLevelDebug,
    YGLogLevelVerbose, YGLogLevelFatal


proc YGLogLevelToString*(a1: YGLogLevel): cstring {.cdecl,
    importc: "YGLogLevelToString", dynlib: dynlibYGEnums.}
type
  YGMeasureMode* {.size: sizeof(cint).} = enum
    YGMeasureModeUndefined, YGMeasureModeExactly, YGMeasureModeAtMost


proc YGMeasureModeToString*(a1: YGMeasureMode): cstring {.cdecl,
    importc: "YGMeasureModeToString", dynlib: dynlibYGEnums.}
type
  YGNodeType* {.size: sizeof(cint).} = enum
    YGNodeTypeDefault, YGNodeTypeText


proc YGNodeTypeToString*(a1: YGNodeType): cstring {.cdecl,
    importc: "YGNodeTypeToString", dynlib: dynlibYGEnums.}
type
  YGOverflow* {.size: sizeof(cint).} = enum
    YGOverflowVisible, YGOverflowHidden, YGOverflowScroll


proc YGOverflowToString*(a1: YGOverflow): cstring {.cdecl,
    importc: "YGOverflowToString", dynlib: dynlibYGEnums.}
type
  YGPositionType* {.size: sizeof(cint).} = enum
    YGPositionTypeRelative, YGPositionTypeAbsolute


proc YGPositionTypeToString*(a1: YGPositionType): cstring {.cdecl,
    importc: "YGPositionTypeToString", dynlib: dynlibYGEnums.}
type
  YGPrintOptions* {.size: sizeof(cint).} = enum
    YGPrintOptionsLayout = 1, YGPrintOptionsStyle = 2, YGPrintOptionsChildren = 4


proc YGPrintOptionsToString*(a1: YGPrintOptions): cstring {.cdecl,
    importc: "YGPrintOptionsToString", dynlib: dynlibYGEnums.}
type
  YGUnit* {.size: sizeof(cint).} = enum
    YGUnitUndefined, YGUnitPoint, YGUnitPercent, YGUnitAuto


proc YGUnitToString*(a1: YGUnit): cstring {.cdecl, importc: "YGUnitToString",
                                        dynlib: dynlibYGEnums.}
type
  YGWrap* {.size: sizeof(cint).} = enum
    YGWrapNoWrap, YGWrapWrap, YGWrapWrapReverse


proc YGWrapToString*(a1: YGWrap): cstring {.cdecl, importc: "YGWrapToString",
                                        dynlib: dynlibYGEnums.}