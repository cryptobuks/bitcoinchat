#import "CQTableViewSectionHeader.h"

@implementation CQTableViewSectionHeader
- (id) initWithFrame:(CGRect) frame {
	if (!(self = [super initWithFrame:frame]))
		return nil;

	if ([UIDevice currentDevice].isSystemSeven) {
		self.backgroundColor = [UIColor colorWithWhite:(247. / 255.) alpha:1.];
	} else {
		_backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];

		UIImage *image = [UIImage imageNamed:@"sectionHeader.png"];
		image = [image stretchableImageWithLeftCapWidth:0. topCapHeight:0.];

		_backgroundImage = image;

		_backgroundImageView.alpha = 0.9;
		_backgroundImageView.image = image;

		image = [UIImage imageNamed:@"sectionHeaderHighlighted.png"];
		image = [image stretchableImageWithLeftCapWidth:0. topCapHeight:0.];

		_backgroundHighlightedImage = image;

		[self addSubview:_backgroundImageView];
	}

	_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_textLabel.backgroundColor = [UIColor clearColor];

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
	if ([UIDevice currentDevice].isSystemSeven) {
		_textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
		_textLabel.textColor = [UIColor colorWithWhite:(63. / 255.) alpha:1.];
	} else {
#endif
		_textLabel.font = [UIFont boldSystemFontOfSize:18.];
		_textLabel.shadowOffset = CGSizeMake(0., 1.);
		_textLabel.shadowColor = [UIColor colorWithWhite:0. alpha:0.5];
		_textLabel.textColor = [UIColor whiteColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
	}
#endif

	UIImage *image = [UIImage imageNamed:@"disclosureArrow.png"];
	_disclosureImageView = [[UIImageView alloc] initWithImage:image];

	self.showsDisclosureState = YES;

	[self addSubview:_textLabel];
	[self addSubview:_disclosureImageView];

	self.accessibilityTraits |= UIAccessibilityTraitHeader;

	return self;
}


#pragma mark -

- (void) setFrame:(CGRect) frame {
	_frame = frame;
	frame.origin.y -= 1.;
	frame.size.height += 1.;
	[super setFrame:frame];
}

- (CGRect) frame {
	return _frame;
}

#pragma mark -

- (void) setHighlighted:(BOOL) highlighted {
	[super setHighlighted:highlighted];

	if (!_showsDisclosureState)
		return;

	if ([UIDevice currentDevice].isSystemSeven) {
		[UIView animateWithDuration:(1. / 3.) animations:^{
			if (highlighted || self.selected)
				self.backgroundColor = [UIColor colorWithWhite:(228. / 255.) alpha:1.];
			else self.backgroundColor = [UIColor colorWithWhite:(247. / 255.) alpha:1.];
		}];
	} else {
		_backgroundImageView.alpha = (highlighted || self.selected ? 1. : 0.9);
		_backgroundImageView.image = (highlighted || self.selected ? _backgroundHighlightedImage : _backgroundImage);
	}
}

- (void) setSelected:(BOOL) selected {
	[super setSelected:selected];

	if (!_showsDisclosureState)
		return;

	if ([UIDevice currentDevice].isSystemSeven) {
		[UIView animateWithDuration:(1. / 6.) animations:^{
			if (selected || self.highlighted)
				self.backgroundColor = [UIColor colorWithWhite:(228. / 255.) alpha:1.];
			else self.backgroundColor = [UIColor colorWithWhite:(247. / 255.) alpha:1.];
		}];
	} else {
		_backgroundImageView.alpha = (selected || self.highlighted ? 1. : 0.9);
		_backgroundImageView.image = (selected || self.highlighted ? _backgroundHighlightedImage : _backgroundImage);
	}
}

- (void) setShowsDisclosureState:(BOOL) showsDisclosureState {
	_showsDisclosureState = showsDisclosureState;

	if (_showsDisclosureState)
		_disclosureImageView.alpha = 1.;
	else _disclosureImageView.alpha = 0.;
}

#pragma mark -

- (void) layoutSubviews {
	_backgroundImageView.frame = self.bounds;

#define LEFT_TEXT_MARGIN 12.
#define RIGHT_TEXT_MARGIN 40.
#define TOP_IMAGE_MARGIN 5.
#define RIGHT_IMAGE_MARGIN 16.

	CGRect frame = self.bounds;
	frame.origin.x += LEFT_TEXT_MARGIN;
	frame.size.width -= (LEFT_TEXT_MARGIN + RIGHT_TEXT_MARGIN);

	_textLabel.frame = frame;

	frame = _disclosureImageView.bounds;
	frame.origin.x = CGRectGetMaxX(self.bounds) - frame.size.width - RIGHT_IMAGE_MARGIN;
	frame.origin.y = TOP_IMAGE_MARGIN;

	_disclosureImageView.frame = frame;

	[super layoutSubviews];
}
@end
