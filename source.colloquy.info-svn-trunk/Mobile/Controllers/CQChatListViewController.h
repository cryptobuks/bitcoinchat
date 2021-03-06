#import "CQChatTableCell.h"
#import "CQTableViewController.h"

@protocol CQChatViewController;

@interface CQChatListViewController : CQTableViewController <UIActionSheetDelegate, UIDocumentInteractionControllerDelegate> {
	@protected
	UILongPressGestureRecognizer *_longPressGestureRecognizer;
	UIActionSheet *_currentChatViewActionSheet;
	id <UIActionSheetDelegate> _currentChatViewActionSheetDelegate;
	id <CQChatViewController> _previousSelectedChatViewController;
	UIEdgeInsets _previousContentInset;
	BOOL _active;
	BOOL _needsUpdate;
}
@property (nonatomic) BOOL active;

- (void) chatViewControllerAdded:(id) controller;

- (void) selectChatViewController:(id) controller animatedSelection:(BOOL) animatedSelection animatedScroll:(BOOL) animatedScroll;
@end
