#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

/// Design tokens for the settings window.
///
/// The palette was matched pixel-for-pixel against Surge in both appearances
/// (see docs/ui-design-system.md). Every colour here is *dynamic* — it resolves
/// against the view's effective appearance — so light and dark are one code
/// path and no call site branches on the appearance itself.
///
/// Layer colours are the exception: a `CGColor` snapshots the appearance that
/// was current when it was read, so anything assigned to a layer must be
/// re-read in `-viewDidChangeEffectiveAppearance`.
@interface SPTheme : NSObject

#pragma mark - Backdrop

/// The three stops of the window's diagonal wash, top-left → bottom-right.
@property(class, readonly) NSColor *windowGradientTop;
@property(class, readonly) NSColor *windowGradientMid;
@property(class, readonly) NSColor *windowGradientBottom;

/// Translucent card fill. Never substitute an opaque colour — the translucency
/// over the gradient is what makes cards read as glass rather than panels.
@property(class, readonly) NSColor *cardBackground;
/// Clear: the sidebar shares the window gradient with the content area, so
/// there is no seam between chrome and content.
@property(class, readonly) NSColor *sidebarBackground;

#pragma mark - Text

@property(class, readonly) NSColor *primaryText;    // headings, card titles
@property(class, readonly) NSColor *label;          // body values
@property(class, readonly) NSColor *secondaryLabel; // descriptions, captions
@property(class, readonly) NSColor *sidebarTitle;   // sidebar rows
@property(class, readonly) NSColor *sidebarHeader;  // sidebar section captions

#pragma mark - Lines

@property(class, readonly) NSColor *separator;

#pragma mark - Interaction

/// A translucent grey darkening, like macOS System Settings — not a white
/// elevated pill and not the system blue. It has to read correctly straight
/// over the gradient.
@property(class, readonly) NSColor *selectionBackground;
@property(class, readonly) NSColor *sidebarHover;

#pragma mark - Metrics

@property(class, readonly) CGFloat sidebarWidth;      // 208
@property(class, readonly) CGFloat pageTitleTopInset; // 52
@property(class, readonly) CGFloat pageTitleGap;      // 14 — title → content
@property(class, readonly) CGFloat pageMargin;        // 28
@property(class, readonly) CGFloat cardCornerRadius;  // 18
@property(class, readonly) CGFloat cardPadding;       // 18
@property(class, readonly) CGFloat sectionGap;        // 26 — between sections
@property(class, readonly) CGFloat sectionHeadingGap; // 12 — caption → row
@property(class, readonly) NSSize windowContentSize;  // 940 × 726

#pragma mark - Type

+ (NSFont *)pageTitleFont;   // 28 bold
+ (NSFont *)cardTitleFont;   // 13.5 semibold
+ (NSFont *)bodyFont;        // 12.5 regular
+ (NSFont *)descriptionFont; // 11.5 regular
+ (NSFont *)captionFont;     // 11 semibold (use with an uppercased string)
+ (NSFont *)sidebarRowFont;  // 14 medium
/// Form field captions. Kept at the AppKit control size so a caption reads as
/// the same weight as the field it labels.
+ (NSFont *)formLabelFont;   // 13 medium

#pragma mark - Construction

/// Build a dynamic colour from light/dark sRGB hex plus alpha.
+ (NSColor *)dynamicLight:(uint32_t)lightHex
               lightAlpha:(CGFloat)lightAlpha
                     dark:(uint32_t)darkHex
                darkAlpha:(CGFloat)darkAlpha;

@end

NS_ASSUME_NONNULL_END
