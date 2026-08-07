#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

/// The primary container: a translucent rounded card that floats on the window
/// gradient. A hard 1px border against a gradient reads as a harsh edge — the
/// hairline white border plus a soft shadow is what makes the card float
/// instead of sitting in a box.
@interface SPCardView : NSView
@property(nonatomic, assign) CGFloat cornerRadius; // default 18
@end

/// A section caption: 11pt semibold, uppercased at construction, secondary
/// grey. Every section heading in the window is one of these.
@interface SPCaptionLabel : NSTextField
+ (instancetype)captionWithString:(NSString *)text;
@end

/// Paints the window backdrop — one diagonal wash at 315° behind the *entire*
/// window, sidebar included, so there is no hard split between chrome and
/// content.
@interface SPGradientBackdropView : NSView
@end

NS_ASSUME_NONNULL_END
