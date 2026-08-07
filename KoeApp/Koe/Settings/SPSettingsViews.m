#import "SPSettingsViews.h"
#import "SPTheme.h"

@implementation SPCardView

- (instancetype)initWithFrame:(NSRect)frame {
  if ((self = [super initWithFrame:frame])) {
    _cornerRadius = SPTheme.cardCornerRadius;
    self.wantsLayer = YES;
    [self applyStyle];
  }
  return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _cornerRadius = cornerRadius;
  [self applyStyle];
}

- (void)applyStyle {
  self.layer.cornerRadius = _cornerRadius;
  self.layer.borderWidth = 0.5;
  self.layer.shadowColor = NSColor.blackColor.CGColor;
  self.layer.shadowOpacity = 0.10;
  self.layer.shadowRadius = 14.0;
  self.layer.shadowOffset = CGSizeMake(0, -3);
  // Required — the shadow has to escape the card's bounds.
  self.layer.masksToBounds = NO;
  // Resolve the dynamic fill under THIS view's appearance: a plain `.CGColor`
  // resolves against the *app's* appearance, which is wrong whenever the window
  // renders in the other one.
  [self.effectiveAppearance performAsCurrentDrawingAppearance:^{
    self.layer.backgroundColor = SPTheme.cardBackground.CGColor;
    self.layer.borderColor = [NSColor colorWithWhite:1.0 alpha:0.5].CGColor;
  }];
}

// CGColor does not follow the appearance the way NSColor does, so every layer
// colour has to be re-read here. Skipping this is the single easiest thing to
// get wrong: the card looks correct until the user switches theme.
- (void)viewDidChangeEffectiveAppearance {
  [super viewDidChangeEffectiveAppearance];
  [self applyStyle];
}

@end

@implementation SPCaptionLabel

+ (instancetype)captionWithString:(NSString *)text {
  SPCaptionLabel *label = [self labelWithString:text.uppercaseString];
  label.font = SPTheme.captionFont;
  label.textColor = SPTheme.secondaryLabel;
  return label;
}

- (void)viewDidChangeEffectiveAppearance {
  [super viewDidChangeEffectiveAppearance];
  self.textColor = SPTheme.secondaryLabel;
}

@end

@implementation SPGradientBackdropView

- (BOOL)isOpaque { return YES; }

- (void)drawRect:(NSRect)dirtyRect {
  NSGradient *gradient = [[NSGradient alloc]
      initWithColors:@[
        SPTheme.windowGradientTop,    // top-left
        SPTheme.windowGradientMid,    // middle
        SPTheme.windowGradientBottom, // bottom-right
      ]
         atLocations:(CGFloat[]){0.0, 0.5, 1.0}
          colorSpace:NSColorSpace.sRGBColorSpace];
  // 315° = from the top-left corner toward the bottom-right.
  [gradient drawInRect:self.bounds angle:315];
}

- (void)viewDidChangeEffectiveAppearance {
  [super viewDidChangeEffectiveAppearance];
  self.needsDisplay = YES;
}

@end

