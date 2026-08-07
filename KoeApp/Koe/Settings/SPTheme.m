#import "SPTheme.h"

static NSColor *sRGB(uint32_t hex, CGFloat alpha) {
  return [NSColor colorWithSRGBRed:((hex >> 16) & 0xFF) / 255.0
                             green:((hex >> 8) & 0xFF) / 255.0
                              blue:(hex & 0xFF) / 255.0
                             alpha:alpha];
}

@implementation SPTheme

+ (NSColor *)dynamicLight:(uint32_t)lightHex
               lightAlpha:(CGFloat)lightAlpha
                     dark:(uint32_t)darkHex
                darkAlpha:(CGFloat)darkAlpha {
  return [NSColor
      colorWithName:nil
    dynamicProvider:^NSColor *(NSAppearance *appearance) {
      NSAppearanceName name = [appearance
          bestMatchFromAppearancesWithNames:@[
            NSAppearanceNameAqua, NSAppearanceNameDarkAqua
          ]];
      BOOL dark = [name isEqualToString:NSAppearanceNameDarkAqua];
      return dark ? sRGB(darkHex, darkAlpha) : sRGB(lightHex, lightAlpha);
    }];
}

// ─── Backdrop ───────────────────────────────────────────────────────

// A diagonal wash: soft blue in the top-left, through a light lavender, to
// near-white in the bottom-right.
+ (NSColor *)windowGradientTop {
  return [self dynamicLight:0xEAF0FA lightAlpha:1 dark:0x232936 darkAlpha:1];
}
+ (NSColor *)windowGradientMid {
  return [self dynamicLight:0xEFF0F6 lightAlpha:1 dark:0x24242C darkAlpha:1];
}
+ (NSColor *)windowGradientBottom {
  return [self dynamicLight:0xF6F4F7 lightAlpha:1 dark:0x201F26 darkAlpha:1];
}

+ (NSColor *)cardBackground {
  return [self dynamicLight:0xFFFFFF lightAlpha:0.80 dark:0x000000 darkAlpha:0.20];
}
+ (NSColor *)sidebarBackground { return NSColor.clearColor; }

// ─── Text ───────────────────────────────────────────────────────────

+ (NSColor *)primaryText {
  return [self dynamicLight:0x131417 lightAlpha:1 dark:0xEAEAEA darkAlpha:1];
}
+ (NSColor *)label {
  return [self dynamicLight:0x202327 lightAlpha:1 dark:0xDDDDDD darkAlpha:1];
}
+ (NSColor *)secondaryLabel {
  return [self dynamicLight:0xB3B3B3 lightAlpha:1 dark:0x7F838F darkAlpha:1];
}
+ (NSColor *)sidebarTitle {
  return [self dynamicLight:0x131417 lightAlpha:1 dark:0xFFFFFF darkAlpha:1];
}
+ (NSColor *)sidebarHeader {
  return [self dynamicLight:0x131417 lightAlpha:0.5 dark:0xFFFFFF darkAlpha:0.5];
}

// ─── Lines ──────────────────────────────────────────────────────────

+ (NSColor *)separator {
  return [self dynamicLight:0x000000 lightAlpha:0.12 dark:0xFFFFFF darkAlpha:0.12];
}

// ─── Interaction ────────────────────────────────────────────────────

+ (NSColor *)selectionBackground {
  return [self dynamicLight:0x000000 lightAlpha:0.085 dark:0xFFFFFF darkAlpha:0.11];
}
+ (NSColor *)sidebarHover {
  return [self dynamicLight:0x000000 lightAlpha:0.045 dark:0xFFFFFF darkAlpha:0.06];
}

// ─── Metrics ────────────────────────────────────────────────────────

+ (CGFloat)sidebarWidth { return 208.0; }
+ (CGFloat)pageTitleTopInset { return 52.0; }
+ (CGFloat)pageTitleGap { return 14.0; }
+ (CGFloat)pageMargin { return 28.0; }
+ (CGFloat)cardCornerRadius { return 18.0; }
+ (CGFloat)cardPadding { return 18.0; }
+ (CGFloat)sectionGap { return 26.0; }
+ (CGFloat)sectionHeadingGap { return 12.0; }
+ (NSSize)windowContentSize { return NSMakeSize(940.0, 726.0); }

// ─── Type ───────────────────────────────────────────────────────────

+ (NSFont *)pageTitleFont {
  return [NSFont systemFontOfSize:28 weight:NSFontWeightBold];
}
+ (NSFont *)cardTitleFont {
  return [NSFont systemFontOfSize:13.5 weight:NSFontWeightSemibold];
}
+ (NSFont *)bodyFont { return [NSFont systemFontOfSize:12.5]; }
+ (NSFont *)descriptionFont { return [NSFont systemFontOfSize:11.5]; }
+ (NSFont *)captionFont {
  return [NSFont systemFontOfSize:11 weight:NSFontWeightSemibold];
}
+ (NSFont *)sidebarRowFont {
  return [NSFont systemFontOfSize:14 weight:NSFontWeightMedium];
}
+ (NSFont *)formLabelFont {
  return [NSFont systemFontOfSize:13 weight:NSFontWeightMedium];
}

@end
