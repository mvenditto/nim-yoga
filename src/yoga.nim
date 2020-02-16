when defined(Linux):
  const dynlibYoga = "yoga.so"

import strutils
import yoga_enums, yoga_value
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "yoga\"".}
type
  YGSize* {.bycopy.} = object
    width*: cfloat
    height*: cfloat

  YGNode = object of RootObj
  YGConfig = object of RootObj
  YGConfigRef* = ptr YGConfig
  YGNodeRef* = ptr YGNode
  YGNodeConstRef* = ptr YGNode
  YGMeasureFunc* = proc (node: YGNodeRef; width: cfloat; widthMode: YGMeasureMode;
                      height: cfloat; heightMode: YGMeasureMode): YGSize {.cdecl.}
  YGBaselineFunc* = proc (node: YGNodeRef; width: cfloat; height: cfloat): cfloat 
  YGDirtiedFunc* = proc (node: YGNodeRef) 
  YGPrintFunc* = proc (node: YGNodeRef) 
  YGNodeCleanupFunc* = proc (node: YGNodeRef) 
  YGLogger* = proc (config: YGConfigRef; node: YGNodeRef; level: YGLogLevel;
                 format: cstring; args: varargs[untyped]): cint {.cdecl.}
  YGCloneNodeFunc* = proc (oldNode: YGNodeRef; owner: YGNodeRef; childIndex: cint): YGNodeRef {.
      cdecl.}

proc newYGNode*(): YGNodeRef {.cdecl, importc: "YGNodeNew", dynlib: dynlibYoga.}
proc newYGNodeWithConfig*(config: YGConfigRef): YGNodeRef {.cdecl,
    importc: "YGNodeNewWithConfig", dynlib: dynlibYoga.}
proc clone*(node: YGNodeRef): YGNodeRef {.cdecl, importc: "YGNodeClone",
    dynlib: dynlibYoga.}
proc free*(node: YGNodeRef) {.cdecl, importc: "YGNodeFree", dynlib: dynlibYoga.}
proc freeRecursiveWithCleanupFunc*(node: YGNodeRef;
                                        cleanup: YGNodeCleanupFunc) {.cdecl,
    importc: "YGNodeFreeRecursiveWithCleanupFunc", dynlib: dynlibYoga.}
proc freeRecursive*(node: YGNodeRef) {.cdecl, importc: "YGNodeFreeRecursive",
    dynlib: dynlibYoga.}
proc reset*(node: YGNodeRef) {.cdecl, importc: "YGNodeReset", dynlib: dynlibYoga.}
proc insertChild*(node: YGNodeRef; child: YGNodeRef; index: uint32) {.cdecl,
    importc: "YGNodeInsertChild", dynlib: dynlibYoga.}
proc removeChild*(node: YGNodeRef; child: YGNodeRef) {.cdecl,
    importc: "YGNodeRemoveChild", dynlib: dynlibYoga.}
proc removeAllChildren*(node: YGNodeRef) {.cdecl,
    importc: "YGNodeRemoveAllChildren", dynlib: dynlibYoga.}
proc getChild*(node: YGNodeRef; index: uint32): YGNodeRef {.cdecl,
    importc: "YGNodeGetChild", dynlib: dynlibYoga.}
proc getOwner*(node: YGNodeRef): YGNodeRef {.cdecl, importc: "YGNodeGetOwner",
    dynlib: dynlibYoga.}
proc getParent*(node: YGNodeRef): YGNodeRef {.cdecl,
    importc: "YGNodeGetParent", dynlib: dynlibYoga.}
proc getChildCount*(node: YGNodeRef): uint32 {.cdecl,
    importc: "YGNodeGetChildCount", dynlib: dynlibYoga.}
proc setChildren*(owner: YGNodeRef; children: ptr YGNodeRef; count: uint32) {.
    cdecl, importc: "YGNodeSetChildren", dynlib: dynlibYoga.}
proc setIsReferenceBaseline*(node: YGNodeRef; isReferenceBaseline: bool) {.
    cdecl, importc: "YGNodeSetIsReferenceBaseline", dynlib: dynlibYoga.}
proc isReferenceBaseline*(node: YGNodeRef): bool {.cdecl,
    importc: "YGNodeIsReferenceBaseline", dynlib: dynlibYoga.}
proc calculateLayout*(node: YGNodeRef; availableWidth: cfloat;
                           availableHeight: cfloat; ownerDirection: YGDirection) {.
    cdecl, importc: "YGNodeCalculateLayout", dynlib: dynlibYoga.}
proc markDirty*(node: YGNodeRef) {.cdecl, importc: "YGNodeMarkDirty",
                                      dynlib: dynlibYoga.}
proc markDirtyAndPropogateToDescendants*(node: YGNodeRef) {.cdecl,
    importc: "YGNodeMarkDirtyAndPropogateToDescendants", dynlib: dynlibYoga.}
proc print*(node: YGNodeRef; options: YGPrintOptions) {.cdecl,
    importc: "YGNodePrint", dynlib: dynlibYoga.}
proc floatIsUndefined*(value: cfloat): bool {.cdecl,
    importc: "YGFloatIsUndefined", dynlib: dynlibYoga.}
proc canUseCachedMeasurement*(widthMode: YGMeasureMode; width: cfloat;
                                   heightMode: YGMeasureMode; height: cfloat;
                                   lastWidthMode: YGMeasureMode;
                                   lastWidth: cfloat;
                                   lastHeightMode: YGMeasureMode;
                                   lastHeight: cfloat; lastComputedWidth: cfloat;
                                   lastComputedHeight: cfloat; marginRow: cfloat;
                                   marginColumn: cfloat; config: YGConfigRef): bool {.
    cdecl, importc: "YGNodeCanUseCachedMeasurement", dynlib: dynlibYoga.}
proc copyStyle*(dstNode: YGNodeRef; srcNode: YGNodeRef) {.cdecl,
    importc: "YGNodeCopyStyle", dynlib: dynlibYoga.}
proc getContext*(node: YGNodeRef): pointer {.cdecl,
    importc: "YGNodeGetContext", dynlib: dynlibYoga.}
proc setContext*(node: YGNodeRef; context: pointer) {.cdecl,
    importc: "YGNodeSetContext", dynlib: dynlibYoga.}
proc configSetPrintTreeFlag*(config: YGConfigRef; enabled: bool) {.cdecl,
    importc: "YGConfigSetPrintTreeFlag", dynlib: dynlibYoga.}
proc hasMeasureFunc*(node: YGNodeRef): bool {.cdecl,
    importc: "YGNodeHasMeasureFunc", dynlib: dynlibYoga.}
proc setMeasureFunc*(node: YGNodeRef; measureFunc: YGMeasureFunc) {.cdecl,
    importc: "YGNodeSetMeasureFunc", dynlib: dynlibYoga.}
proc hasBaselineFunc*(node: YGNodeRef): bool {.cdecl,
    importc: "YGNodeHasBaselineFunc", dynlib: dynlibYoga.}
proc setBaselineFunc*(node: YGNodeRef; baselineFunc: YGBaselineFunc) {.cdecl,
    importc: "YGNodeSetBaselineFunc", dynlib: dynlibYoga.}
proc getDirtiedFunc*(node: YGNodeRef): YGDirtiedFunc {.cdecl,
    importc: "YGNodeGetDirtiedFunc", dynlib: dynlibYoga.}
proc setDirtiedFunc*(node: YGNodeRef; dirtiedFunc: YGDirtiedFunc) {.cdecl,
    importc: "YGNodeSetDirtiedFunc", dynlib: dynlibYoga.}
proc setPrintFunc*(node: YGNodeRef; printFunc: YGPrintFunc) {.cdecl,
    importc: "YGNodeSetPrintFunc", dynlib: dynlibYoga.}
proc getHasNewLayout*(node: YGNodeRef): bool {.cdecl,
    importc: "YGNodeGetHasNewLayout", dynlib: dynlibYoga.}
proc setHasNewLayout*(node: YGNodeRef; hasNewLayout: bool) {.cdecl,
    importc: "YGNodeSetHasNewLayout", dynlib: dynlibYoga.}
proc getNodeType*(node: YGNodeRef): YGNodeType {.cdecl,
    importc: "YGNodeGetNodeType", dynlib: dynlibYoga.}
proc setNodeType*(node: YGNodeRef; nodeType: YGNodeType) {.cdecl,
    importc: "YGNodeSetNodeType", dynlib: dynlibYoga.}
proc isDirty*(node: YGNodeRef): bool {.cdecl, importc: "YGNodeIsDirty",
    dynlib: dynlibYoga.}
proc layoutGetDidUseLegacyFlag*(node: YGNodeRef): bool {.cdecl,
    importc: "YGNodeLayoutGetDidUseLegacyFlag", dynlib: dynlibYoga.}
proc styleSetDirection*(node: YGNodeRef; direction: YGDirection) {.cdecl,
    importc: "YGNodeStyleSetDirection", dynlib: dynlibYoga.}
proc styleGetDirection*(node: YGNodeConstRef): YGDirection {.cdecl,
    importc: "YGNodeStyleGetDirection", dynlib: dynlibYoga.}
proc styleSetFlexDirection*(node: YGNodeRef; flexDirection: YGFlexDirection) {.
    cdecl, importc: "YGNodeStyleSetFlexDirection", dynlib: dynlibYoga.}
proc styleGetFlexDirection*(node: YGNodeConstRef): YGFlexDirection {.cdecl,
    importc: "YGNodeStyleGetFlexDirection", dynlib: dynlibYoga.}
proc styleSetJustifyContent*(node: YGNodeRef; justifyContent: YGJustify) {.
    cdecl, importc: "YGNodeStyleSetJustifyContent", dynlib: dynlibYoga.}
proc styleGetJustifyContent*(node: YGNodeConstRef): YGJustify {.cdecl,
    importc: "YGNodeStyleGetJustifyContent", dynlib: dynlibYoga.}
proc styleSetAlignContent*(node: YGNodeRef; alignContent: YGAlign) {.cdecl,
    importc: "YGNodeStyleSetAlignContent", dynlib: dynlibYoga.}
proc styleGetAlignContent*(node: YGNodeConstRef): YGAlign {.cdecl,
    importc: "YGNodeStyleGetAlignContent", dynlib: dynlibYoga.}
proc styleSetAlignItems*(node: YGNodeRef; alignItems: YGAlign) {.cdecl,
    importc: "YGNodeStyleSetAlignItems", dynlib: dynlibYoga.}
proc styleGetAlignItems*(node: YGNodeConstRef): YGAlign {.cdecl,
    importc: "YGNodeStyleGetAlignItems", dynlib: dynlibYoga.}
proc styleSetAlignSelf*(node: YGNodeRef; alignSelf: YGAlign) {.cdecl,
    importc: "YGNodeStyleSetAlignSelf", dynlib: dynlibYoga.}
proc styleGetAlignSelf*(node: YGNodeConstRef): YGAlign {.cdecl,
    importc: "YGNodeStyleGetAlignSelf", dynlib: dynlibYoga.}
proc styleSetPositionType*(node: YGNodeRef; positionType: YGPositionType) {.
    cdecl, importc: "YGNodeStyleSetPositionType", dynlib: dynlibYoga.}
proc styleGetPositionType*(node: YGNodeConstRef): YGPositionType {.cdecl,
    importc: "YGNodeStyleGetPositionType", dynlib: dynlibYoga.}
proc styleSetFlexWrap*(node: YGNodeRef; flexWrap: YGWrap) {.cdecl,
    importc: "YGNodeStyleSetFlexWrap", dynlib: dynlibYoga.}
proc styleGetFlexWrap*(node: YGNodeConstRef): YGWrap {.cdecl,
    importc: "YGNodeStyleGetFlexWrap", dynlib: dynlibYoga.}
proc styleSetOverflow*(node: YGNodeRef; overflow: YGOverflow) {.cdecl,
    importc: "YGNodeStyleSetOverflow", dynlib: dynlibYoga.}
proc styleGetOverflow*(node: YGNodeConstRef): YGOverflow {.cdecl,
    importc: "YGNodeStyleGetOverflow", dynlib: dynlibYoga.}
proc styleSetDisplay*(node: YGNodeRef; display: YGDisplay) {.cdecl,
    importc: "YGNodeStyleSetDisplay", dynlib: dynlibYoga.}
proc styleGetDisplay*(node: YGNodeConstRef): YGDisplay {.cdecl,
    importc: "YGNodeStyleGetDisplay", dynlib: dynlibYoga.}
proc styleSetFlex*(node: YGNodeRef; flex: cfloat) {.cdecl,
    importc: "YGNodeStyleSetFlex", dynlib: dynlibYoga.}
proc styleGetFlex*(node: YGNodeConstRef): cfloat {.cdecl,
    importc: "YGNodeStyleGetFlex", dynlib: dynlibYoga.}
proc styleSetFlexGrow*(node: YGNodeRef; flexGrow: cfloat) {.cdecl,
    importc: "YGNodeStyleSetFlexGrow", dynlib: dynlibYoga.}
proc styleGetFlexGrow*(node: YGNodeConstRef): cfloat {.cdecl,
    importc: "YGNodeStyleGetFlexGrow", dynlib: dynlibYoga.}
proc styleSetFlexShrink*(node: YGNodeRef; flexShrink: cfloat) {.cdecl,
    importc: "YGNodeStyleSetFlexShrink", dynlib: dynlibYoga.}
proc styleGetFlexShrink*(node: YGNodeConstRef): cfloat {.cdecl,
    importc: "YGNodeStyleGetFlexShrink", dynlib: dynlibYoga.}
proc styleSetFlexBasis*(node: YGNodeRef; flexBasis: cfloat) {.cdecl,
    importc: "YGNodeStyleSetFlexBasis", dynlib: dynlibYoga.}
proc styleSetFlexBasisPercent*(node: YGNodeRef; flexBasis: cfloat) {.cdecl,
    importc: "YGNodeStyleSetFlexBasisPercent", dynlib: dynlibYoga.}
proc styleSetFlexBasisAuto*(node: YGNodeRef) {.cdecl,
    importc: "YGNodeStyleSetFlexBasisAuto", dynlib: dynlibYoga.}
proc styleGetFlexBasis*(node: YGNodeConstRef): YGValue {.cdecl,
    importc: "YGNodeStyleGetFlexBasis", dynlib: dynlibYoga.}
proc styleSetPosition*(node: YGNodeRef; edge: YGEdge; position: cfloat) {.cdecl,
    importc: "YGNodeStyleSetPosition", dynlib: dynlibYoga.}
proc styleSetPositionPercent*(node: YGNodeRef; edge: YGEdge; position: cfloat) {.
    cdecl, importc: "YGNodeStyleSetPositionPercent", dynlib: dynlibYoga.}
proc styleGetPosition*(node: YGNodeConstRef; edge: YGEdge): YGValue {.cdecl,
    importc: "YGNodeStyleGetPosition", dynlib: dynlibYoga.}
proc styleSetMargin*(node: YGNodeRef; edge: YGEdge; margin: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMargin", dynlib: dynlibYoga.}
proc styleSetMarginPercent*(node: YGNodeRef; edge: YGEdge; margin: cfloat) {.
    cdecl, importc: "YGNodeStyleSetMarginPercent", dynlib: dynlibYoga.}
proc styleSetMarginAuto*(node: YGNodeRef; edge: YGEdge) {.cdecl,
    importc: "YGNodeStyleSetMarginAuto", dynlib: dynlibYoga.}
proc styleGetMargin*(node: YGNodeConstRef; edge: YGEdge): YGValue {.cdecl,
    importc: "YGNodeStyleGetMargin", dynlib: dynlibYoga.}
proc styleSetPadding*(node: YGNodeRef; edge: YGEdge; padding: cfloat) {.cdecl,
    importc: "YGNodeStyleSetPadding", dynlib: dynlibYoga.}
proc styleSetPaddingPercent*(node: YGNodeRef; edge: YGEdge; padding: cfloat) {.
    cdecl, importc: "YGNodeStyleSetPaddingPercent", dynlib: dynlibYoga.}
proc styleGetPadding*(node: YGNodeConstRef; edge: YGEdge): YGValue {.cdecl,
    importc: "YGNodeStyleGetPadding", dynlib: dynlibYoga.}
proc styleSetBorder*(node: YGNodeRef; edge: YGEdge; border: cfloat) {.cdecl,
    importc: "YGNodeStyleSetBorder", dynlib: dynlibYoga.}
proc styleGetBorder*(node: YGNodeConstRef; edge: YGEdge): cfloat {.cdecl,
    importc: "YGNodeStyleGetBorder", dynlib: dynlibYoga.}
proc styleSetWidth*(node: YGNodeRef; width: cfloat) {.cdecl,
    importc: "YGNodeStyleSetWidth", dynlib: dynlibYoga.}
proc styleSetWidthPercent*(node: YGNodeRef; width: cfloat) {.cdecl,
    importc: "YGNodeStyleSetWidthPercent", dynlib: dynlibYoga.}
proc styleSetWidthAuto*(node: YGNodeRef) {.cdecl,
    importc: "YGNodeStyleSetWidthAuto", dynlib: dynlibYoga.}
proc styleGetWidth*(node: YGNodeConstRef): YGValue {.cdecl,
    importc: "YGNodeStyleGetWidth", dynlib: dynlibYoga.}
proc styleSetHeight*(node: YGNodeRef; height: cfloat) {.cdecl,
    importc: "YGNodeStyleSetHeight", dynlib: dynlibYoga.}
proc styleSetHeightPercent*(node: YGNodeRef; height: cfloat) {.cdecl,
    importc: "YGNodeStyleSetHeightPercent", dynlib: dynlibYoga.}
proc styleSetHeightAuto*(node: YGNodeRef) {.cdecl,
    importc: "YGNodeStyleSetHeightAuto", dynlib: dynlibYoga.}
proc styleGetHeight*(node: YGNodeConstRef): YGValue {.cdecl,
    importc: "YGNodeStyleGetHeight", dynlib: dynlibYoga.}
proc styleSetMinWidth*(node: YGNodeRef; minWidth: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMinWidth", dynlib: dynlibYoga.}
proc styleSetMinWidthPercent*(node: YGNodeRef; minWidth: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMinWidthPercent", dynlib: dynlibYoga.}
proc styleGetMinWidth*(node: YGNodeConstRef): YGValue {.cdecl,
    importc: "YGNodeStyleGetMinWidth", dynlib: dynlibYoga.}
proc styleSetMinHeight*(node: YGNodeRef; minHeight: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMinHeight", dynlib: dynlibYoga.}
proc styleSetMinHeightPercent*(node: YGNodeRef; minHeight: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMinHeightPercent", dynlib: dynlibYoga.}
proc styleGetMinHeight*(node: YGNodeConstRef): YGValue {.cdecl,
    importc: "YGNodeStyleGetMinHeight", dynlib: dynlibYoga.}
proc styleSetMaxWidth*(node: YGNodeRef; maxWidth: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMaxWidth", dynlib: dynlibYoga.}
proc styleSetMaxWidthPercent*(node: YGNodeRef; maxWidth: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMaxWidthPercent", dynlib: dynlibYoga.}
proc styleGetMaxWidth*(node: YGNodeConstRef): YGValue {.cdecl,
    importc: "YGNodeStyleGetMaxWidth", dynlib: dynlibYoga.}
proc styleSetMaxHeight*(node: YGNodeRef; maxHeight: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMaxHeight", dynlib: dynlibYoga.}
proc styleSetMaxHeightPercent*(node: YGNodeRef; maxHeight: cfloat) {.cdecl,
    importc: "YGNodeStyleSetMaxHeightPercent", dynlib: dynlibYoga.}
proc styleGetMaxHeight*(node: YGNodeConstRef): YGValue {.cdecl,
    importc: "YGNodeStyleGetMaxHeight", dynlib: dynlibYoga.}
proc styleSetAspectRatio*(node: YGNodeRef; aspectRatio: cfloat) {.cdecl,
    importc: "YGNodeStyleSetAspectRatio", dynlib: dynlibYoga.}
proc styleGetAspectRatio*(node: YGNodeConstRef): cfloat {.cdecl,
    importc: "YGNodeStyleGetAspectRatio", dynlib: dynlibYoga.}
proc layoutGetLeft*(node: YGNodeRef): cfloat {.cdecl,
    importc: "YGNodeLayoutGetLeft", dynlib: dynlibYoga.}
proc layoutGetTop*(node: YGNodeRef): cfloat {.cdecl,
    importc: "YGNodeLayoutGetTop", dynlib: dynlibYoga.}
proc layoutGetRight*(node: YGNodeRef): cfloat {.cdecl,
    importc: "YGNodeLayoutGetRight", dynlib: dynlibYoga.}
proc layoutGetBottom*(node: YGNodeRef): cfloat {.cdecl,
    importc: "YGNodeLayoutGetBottom", dynlib: dynlibYoga.}
proc layoutGetWidth*(node: YGNodeRef): cfloat {.cdecl,
    importc: "YGNodeLayoutGetWidth", dynlib: dynlibYoga.}
proc layoutGetHeight*(node: YGNodeRef): cfloat {.cdecl,
    importc: "YGNodeLayoutGetHeight", dynlib: dynlibYoga.}
proc layoutGetDirection*(node: YGNodeRef): YGDirection {.cdecl,
    importc: "YGNodeLayoutGetDirection", dynlib: dynlibYoga.}
proc layoutGetHadOverflow*(node: YGNodeRef): bool {.cdecl,
    importc: "YGNodeLayoutGetHadOverflow", dynlib: dynlibYoga.}
proc layoutGetDidLegacyStretchFlagAffectLayout*(node: YGNodeRef): bool {.
    cdecl, importc: "YGNodeLayoutGetDidLegacyStretchFlagAffectLayout",
    dynlib: dynlibYoga.}
proc layoutGetMargin*(node: YGNodeRef; edge: YGEdge): cfloat {.cdecl,
    importc: "YGNodeLayoutGetMargin", dynlib: dynlibYoga.}
proc layoutGetBorder*(node: YGNodeRef; edge: YGEdge): cfloat {.cdecl,
    importc: "YGNodeLayoutGetBorder", dynlib: dynlibYoga.}
proc layoutGetPadding*(node: YGNodeRef; edge: YGEdge): cfloat {.cdecl,
    importc: "YGNodeLayoutGetPadding", dynlib: dynlibYoga.}
proc configSetLogger*(config: YGConfigRef; logger: YGLogger) {.cdecl,
    importc: "YGConfigSetLogger", dynlib: dynlibYoga.}
proc assert*(condition: bool; message: cstring) {.cdecl, importc: "YGAssert",
    dynlib: dynlibYoga.}
proc assertWithNode*(node: YGNodeRef; condition: bool; message: cstring) {.cdecl,
    importc: "YGAssertWithNode", dynlib: dynlibYoga.}
proc assertWithConfig*(config: YGConfigRef; condition: bool; message: cstring) {.
    cdecl, importc: "YGAssertWithConfig", dynlib: dynlibYoga.}
proc configSetPointScaleFactor*(config: YGConfigRef; pixelsInPoint: cfloat) {.
    cdecl, importc: "YGConfigSetPointScaleFactor", dynlib: dynlibYoga.}
proc configSetShouldDiffLayoutWithoutLegacyStretchBehaviour*(
    config: YGConfigRef; shouldDiffLayout: bool) {.cdecl,
    importc: "YGConfigSetShouldDiffLayoutWithoutLegacyStretchBehaviour",
    dynlib: dynlibYoga.}
proc configSetUseLegacyStretchBehaviour*(config: YGConfigRef;
    useLegacyStretchBehaviour: bool) {.cdecl, importc: "YGConfigSetUseLegacyStretchBehaviour",
                                      dynlib: dynlibYoga.}
proc configNew*(): YGConfigRef {.cdecl, importc: "YGConfigNew", dynlib: dynlibYoga.}
proc configFree*(config: YGConfigRef) {.cdecl, importc: "YGConfigFree",
                                       dynlib: dynlibYoga.}
proc configCopy*(dest: YGConfigRef; src: YGConfigRef) {.cdecl,
    importc: "YGConfigCopy", dynlib: dynlibYoga.}
proc configGetInstanceCount*(): int32 {.cdecl,
    importc: "YGConfigGetInstanceCount", dynlib: dynlibYoga.}
proc configSetExperimentalFeatureEnabled*(config: YGConfigRef;
    feature: YGExperimentalFeature; enabled: bool) {.cdecl,
    importc: "YGConfigSetExperimentalFeatureEnabled", dynlib: dynlibYoga.}
proc configIsExperimentalFeatureEnabled*(config: YGConfigRef;
    feature: YGExperimentalFeature): bool {.cdecl,
    importc: "YGConfigIsExperimentalFeatureEnabled", dynlib: dynlibYoga.}
proc configSetUseWebDefaults*(config: YGConfigRef; enabled: bool) {.cdecl,
    importc: "YGConfigSetUseWebDefaults", dynlib: dynlibYoga.}
proc configGetUseWebDefaults*(config: YGConfigRef): bool {.cdecl,
    importc: "YGConfigGetUseWebDefaults", dynlib: dynlibYoga.}
proc configSetCloneNodeFunc*(config: YGConfigRef; callback: YGCloneNodeFunc) {.
    cdecl, importc: "YGConfigSetCloneNodeFunc", dynlib: dynlibYoga.}
proc configGetDefault*(): YGConfigRef {.cdecl, importc: "YGConfigGetDefault",
                                       dynlib: dynlibYoga.}
proc configSetContext*(config: YGConfigRef; context: pointer) {.cdecl,
    importc: "YGConfigSetContext", dynlib: dynlibYoga.}
proc configGetContext*(config: YGConfigRef): pointer {.cdecl,
    importc: "YGConfigGetContext", dynlib: dynlibYoga.}
proc roundValueToPixelGrid*(value: cfloat; pointScaleFactor: cfloat;
                             forceCeil: bool; forceFloor: bool): cfloat {.cdecl,
    importc: "YGRoundValueToPixelGrid", dynlib: dynlibYoga.}