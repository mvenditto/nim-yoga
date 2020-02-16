/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <assert.h>
#include <math.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef __cplusplus
#include <stdbool.h>
#endif

#include "YGEnums.h"
#include "YGMacros.h"
#include "YGValue.h"

YG_EXTERN_C_BEGIN

typedef struct YGSize {
  float width;
  float height;
} YGSize;

typedef struct YGConfig* YGConfigRef;

typedef struct YGNode* YGNodeRef;
typedef const struct YGNode* YGNodeConstRef;

typedef YGSize (*YGMeasureFunc)(
    YGNodeRef node,
    float width,
    YGMeasureMode widthMode,
    float height,
    YGMeasureMode heightMode);
typedef float (*YGBaselineFunc)(YGNodeRef node, float width, float height);
typedef void (*YGDirtiedFunc)(YGNodeRef node);
typedef void (*YGPrintFunc)(YGNodeRef node);
typedef void (*YGNodeCleanupFunc)(YGNodeRef node);
typedef int (*YGLogger)(
    YGConfigRef config,
    YGNodeRef node,
    YGLogLevel level,
    const char* format,
    va_list args);
typedef YGNodeRef (
    *YGCloneNodeFunc)(YGNodeRef oldNode, YGNodeRef owner, int childIndex);

// YGNode
 YGNodeRef YGNodeNew(void);
 YGNodeRef YGNodeNewWithConfig(YGConfigRef config);
 YGNodeRef YGNodeClone(YGNodeRef node);
 void YGNodeFree(YGNodeRef node);
 void YGNodeFreeRecursiveWithCleanupFunc(
    YGNodeRef node,
    YGNodeCleanupFunc cleanup);
 void YGNodeFreeRecursive(YGNodeRef node);
 void YGNodeReset(YGNodeRef node);

 void YGNodeInsertChild(
    YGNodeRef node,
    YGNodeRef child,
    uint32_t index);

 void YGNodeRemoveChild(YGNodeRef node, YGNodeRef child);
 void YGNodeRemoveAllChildren(YGNodeRef node);
 YGNodeRef YGNodeGetChild(YGNodeRef node, uint32_t index);
 YGNodeRef YGNodeGetOwner(YGNodeRef node);
 YGNodeRef YGNodeGetParent(YGNodeRef node);
 uint32_t YGNodeGetChildCount(YGNodeRef node);
 void YGNodeSetChildren(
    YGNodeRef owner,
    const YGNodeRef children[],
    uint32_t count);

 void YGNodeSetIsReferenceBaseline(
    YGNodeRef node,
    bool isReferenceBaseline);

 bool YGNodeIsReferenceBaseline(YGNodeRef node);

 void YGNodeCalculateLayout(
    YGNodeRef node,
    float availableWidth,
    float availableHeight,
    YGDirection ownerDirection);

// Mark a node as dirty. Only valid for nodes with a custom measure function
// set.
//
// Yoga knows when to mark all other nodes as dirty but because nodes with
// measure functions depend on information not known to Yoga they must perform
// this dirty marking manually.
 void YGNodeMarkDirty(YGNodeRef node);

// Marks the current node and all its descendants as dirty.
//
// Intended to be used for Uoga benchmarks. Don't use in production, as calling
// `YGCalculateLayout` will cause the recalculation of each and every node.
 void YGNodeMarkDirtyAndPropogateToDescendants(YGNodeRef node);

 void YGNodePrint(YGNodeRef node, YGPrintOptions options);

 bool YGFloatIsUndefined(float value);

 bool YGNodeCanUseCachedMeasurement(
    YGMeasureMode widthMode,
    float width,
    YGMeasureMode heightMode,
    float height,
    YGMeasureMode lastWidthMode,
    float lastWidth,
    YGMeasureMode lastHeightMode,
    float lastHeight,
    float lastComputedWidth,
    float lastComputedHeight,
    float marginRow,
    float marginColumn,
    YGConfigRef config);

 void YGNodeCopyStyle(YGNodeRef dstNode, YGNodeRef srcNode);

 void* YGNodeGetContext(YGNodeRef node);
 void YGNodeSetContext(YGNodeRef node, void* context);
void YGConfigSetPrintTreeFlag(YGConfigRef config, bool enabled);
bool YGNodeHasMeasureFunc(YGNodeRef node);
 void YGNodeSetMeasureFunc(YGNodeRef node, YGMeasureFunc measureFunc);
bool YGNodeHasBaselineFunc(YGNodeRef node);
void YGNodeSetBaselineFunc(YGNodeRef node, YGBaselineFunc baselineFunc);
YGDirtiedFunc YGNodeGetDirtiedFunc(YGNodeRef node);
void YGNodeSetDirtiedFunc(YGNodeRef node, YGDirtiedFunc dirtiedFunc);
void YGNodeSetPrintFunc(YGNodeRef node, YGPrintFunc printFunc);
 bool YGNodeGetHasNewLayout(YGNodeRef node);
 void YGNodeSetHasNewLayout(YGNodeRef node, bool hasNewLayout);
YGNodeType YGNodeGetNodeType(YGNodeRef node);
void YGNodeSetNodeType(YGNodeRef node, YGNodeType nodeType);
 bool YGNodeIsDirty(YGNodeRef node);
bool YGNodeLayoutGetDidUseLegacyFlag(YGNodeRef node);

 void YGNodeStyleSetDirection(YGNodeRef node, YGDirection direction);
 YGDirection YGNodeStyleGetDirection(YGNodeConstRef node);

 void YGNodeStyleSetFlexDirection(
    YGNodeRef node,
    YGFlexDirection flexDirection);
 YGFlexDirection YGNodeStyleGetFlexDirection(YGNodeConstRef node);

 void YGNodeStyleSetJustifyContent(
    YGNodeRef node,
    YGJustify justifyContent);
 YGJustify YGNodeStyleGetJustifyContent(YGNodeConstRef node);

 void YGNodeStyleSetAlignContent(
    YGNodeRef node,
    YGAlign alignContent);
 YGAlign YGNodeStyleGetAlignContent(YGNodeConstRef node);

 void YGNodeStyleSetAlignItems(YGNodeRef node, YGAlign alignItems);
 YGAlign YGNodeStyleGetAlignItems(YGNodeConstRef node);

 void YGNodeStyleSetAlignSelf(YGNodeRef node, YGAlign alignSelf);
 YGAlign YGNodeStyleGetAlignSelf(YGNodeConstRef node);

 void YGNodeStyleSetPositionType(
    YGNodeRef node,
    YGPositionType positionType);
 YGPositionType YGNodeStyleGetPositionType(YGNodeConstRef node);

 void YGNodeStyleSetFlexWrap(YGNodeRef node, YGWrap flexWrap);
 YGWrap YGNodeStyleGetFlexWrap(YGNodeConstRef node);

 void YGNodeStyleSetOverflow(YGNodeRef node, YGOverflow overflow);
 YGOverflow YGNodeStyleGetOverflow(YGNodeConstRef node);

 void YGNodeStyleSetDisplay(YGNodeRef node, YGDisplay display);
 YGDisplay YGNodeStyleGetDisplay(YGNodeConstRef node);

 void YGNodeStyleSetFlex(YGNodeRef node, float flex);
 float YGNodeStyleGetFlex(YGNodeConstRef node);

 void YGNodeStyleSetFlexGrow(YGNodeRef node, float flexGrow);
 float YGNodeStyleGetFlexGrow(YGNodeConstRef node);

 void YGNodeStyleSetFlexShrink(YGNodeRef node, float flexShrink);
 float YGNodeStyleGetFlexShrink(YGNodeConstRef node);

 void YGNodeStyleSetFlexBasis(YGNodeRef node, float flexBasis);
 void YGNodeStyleSetFlexBasisPercent(YGNodeRef node, float flexBasis);
 void YGNodeStyleSetFlexBasisAuto(YGNodeRef node);
 YGValue YGNodeStyleGetFlexBasis(YGNodeConstRef node);

 void YGNodeStyleSetPosition(
    YGNodeRef node,
    YGEdge edge,
    float position);
 void YGNodeStyleSetPositionPercent(
    YGNodeRef node,
    YGEdge edge,
    float position);
 YGValue YGNodeStyleGetPosition(YGNodeConstRef node, YGEdge edge);

 void YGNodeStyleSetMargin(YGNodeRef node, YGEdge edge, float margin);
 void YGNodeStyleSetMarginPercent(
    YGNodeRef node,
    YGEdge edge,
    float margin);
 void YGNodeStyleSetMarginAuto(YGNodeRef node, YGEdge edge);
 YGValue YGNodeStyleGetMargin(YGNodeConstRef node, YGEdge edge);

 void YGNodeStyleSetPadding(
    YGNodeRef node,
    YGEdge edge,
    float padding);
 void YGNodeStyleSetPaddingPercent(
    YGNodeRef node,
    YGEdge edge,
    float padding);
 YGValue YGNodeStyleGetPadding(YGNodeConstRef node, YGEdge edge);

 void YGNodeStyleSetBorder(YGNodeRef node, YGEdge edge, float border);
 float YGNodeStyleGetBorder(YGNodeConstRef node, YGEdge edge);

 void YGNodeStyleSetWidth(YGNodeRef node, float width);
 void YGNodeStyleSetWidthPercent(YGNodeRef node, float width);
 void YGNodeStyleSetWidthAuto(YGNodeRef node);
 YGValue YGNodeStyleGetWidth(YGNodeConstRef node);

 void YGNodeStyleSetHeight(YGNodeRef node, float height);
 void YGNodeStyleSetHeightPercent(YGNodeRef node, float height);
 void YGNodeStyleSetHeightAuto(YGNodeRef node);
 YGValue YGNodeStyleGetHeight(YGNodeConstRef node);

 void YGNodeStyleSetMinWidth(YGNodeRef node, float minWidth);
 void YGNodeStyleSetMinWidthPercent(YGNodeRef node, float minWidth);
 YGValue YGNodeStyleGetMinWidth(YGNodeConstRef node);

 void YGNodeStyleSetMinHeight(YGNodeRef node, float minHeight);
 void YGNodeStyleSetMinHeightPercent(YGNodeRef node, float minHeight);
 YGValue YGNodeStyleGetMinHeight(YGNodeConstRef node);

 void YGNodeStyleSetMaxWidth(YGNodeRef node, float maxWidth);
 void YGNodeStyleSetMaxWidthPercent(YGNodeRef node, float maxWidth);
 YGValue YGNodeStyleGetMaxWidth(YGNodeConstRef node);

 void YGNodeStyleSetMaxHeight(YGNodeRef node, float maxHeight);
 void YGNodeStyleSetMaxHeightPercent(YGNodeRef node, float maxHeight);
 YGValue YGNodeStyleGetMaxHeight(YGNodeConstRef node);

// Yoga specific properties, not compatible with flexbox specification Aspect
// ratio control the size of the undefined dimension of a node. Aspect ratio is
// encoded as a floating point value width/height. e.g. A value of 2 leads to a
// node with a width twice the size of its height while a value of 0.5 gives the
// opposite effect.
//
// - On a node with a set width/height aspect ratio control the size of the
//   unset dimension
// - On a node with a set flex basis aspect ratio controls the size of the node
//   in the cross axis if unset
// - On a node with a measure function aspect ratio works as though the measure
//   function measures the flex basis
// - On a node with flex grow/shrink aspect ratio controls the size of the node
//   in the cross axis if unset
// - Aspect ratio takes min/max dimensions into account
 void YGNodeStyleSetAspectRatio(YGNodeRef node, float aspectRatio);
 float YGNodeStyleGetAspectRatio(YGNodeConstRef node);

 float YGNodeLayoutGetLeft(YGNodeRef node);
 float YGNodeLayoutGetTop(YGNodeRef node);
 float YGNodeLayoutGetRight(YGNodeRef node);
 float YGNodeLayoutGetBottom(YGNodeRef node);
 float YGNodeLayoutGetWidth(YGNodeRef node);
 float YGNodeLayoutGetHeight(YGNodeRef node);
 YGDirection YGNodeLayoutGetDirection(YGNodeRef node);
 bool YGNodeLayoutGetHadOverflow(YGNodeRef node);
bool YGNodeLayoutGetDidLegacyStretchFlagAffectLayout(YGNodeRef node);

// Get the computed values for these nodes after performing layout. If they were
// set using point values then the returned value will be the same as
// YGNodeStyleGetXXX. However if they were set using a percentage value then the
// returned value is the computed value used during layout.
 float YGNodeLayoutGetMargin(YGNodeRef node, YGEdge edge);
 float YGNodeLayoutGetBorder(YGNodeRef node, YGEdge edge);
 float YGNodeLayoutGetPadding(YGNodeRef node, YGEdge edge);

 void YGConfigSetLogger(YGConfigRef config, YGLogger logger);
 void YGAssert(bool condition, const char* message);
 void YGAssertWithNode(
    YGNodeRef node,
    bool condition,
    const char* message);
 void YGAssertWithConfig(
    YGConfigRef config,
    bool condition,
    const char* message);
// Set this to number of pixels in 1 point to round calculation results If you
// want to avoid rounding - set PointScaleFactor to 0
 void YGConfigSetPointScaleFactor(
    YGConfigRef config,
    float pixelsInPoint);
void YGConfigSetShouldDiffLayoutWithoutLegacyStretchBehaviour(
    YGConfigRef config,
    bool shouldDiffLayout);

// Yoga previously had an error where containers would take the maximum space
// possible instead of the minimum like they are supposed to. In practice this
// resulted in implicit behaviour similar to align-self: stretch; Because this
// was such a long-standing bug we must allow legacy users to switch back to
// this behaviour.
 void YGConfigSetUseLegacyStretchBehaviour(
    YGConfigRef config,
    bool useLegacyStretchBehaviour);

// YGConfig
 YGConfigRef YGConfigNew(void);
 void YGConfigFree(YGConfigRef config);
 void YGConfigCopy(YGConfigRef dest, YGConfigRef src);
 int32_t YGConfigGetInstanceCount(void);

 void YGConfigSetExperimentalFeatureEnabled(
    YGConfigRef config,
    YGExperimentalFeature feature,
    bool enabled);
 bool YGConfigIsExperimentalFeatureEnabled(
    YGConfigRef config,
    YGExperimentalFeature feature);

// Using the web defaults is the preferred configuration for new projects. Usage
// of non web defaults should be considered as legacy.
 void YGConfigSetUseWebDefaults(YGConfigRef config, bool enabled);
 bool YGConfigGetUseWebDefaults(YGConfigRef config);

 void YGConfigSetCloneNodeFunc(
    YGConfigRef config,
    YGCloneNodeFunc callback);

// Export only for C#
 YGConfigRef YGConfigGetDefault(void);

 void YGConfigSetContext(YGConfigRef config, void* context);
 void* YGConfigGetContext(YGConfigRef config);

 float YGRoundValueToPixelGrid(
    float value,
    float pointScaleFactor,
    bool forceCeil,
    bool forceFloor);

YG_EXTERN_C_END

#ifdef __cplusplus

#include <functional>
#include <vector>

// Calls f on each node in the tree including the given node argument.
void YGTraversePreOrder(
    YGNodeRef node,
    std::function<void(YGNodeRef node)>&& f);

void YGNodeSetChildren(YGNodeRef owner, const std::vector<YGNodeRef>& children);

#endif
