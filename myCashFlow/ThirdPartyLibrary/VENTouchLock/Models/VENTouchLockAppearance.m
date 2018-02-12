#import "VENTouchLockAppearance.h"

@implementation VENTouchLockAppearance

- (instancetype)init
{
    self = [super init];
    if (self) { // Set default values
        _passcodeViewControllerTitleColor = BG_COLOR;
        _passcodeViewControllerCharacterColor = BG_COLOR;
        _passcodeViewControllerBackgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
        _passcodeViewControllerShouldEmbedInNavigationController = NO;
        _cancelBarButtonItemTitle = NSLocalizedString([TSLanguageManager localizedString:@"Cancel"], nil);
        _createPasscodeInitialLabelText = NSLocalizedString([TSLanguageManager localizedString:@"Enter a new passcode"], nil);
        _createPasscodeConfirmLabelText = NSLocalizedString([TSLanguageManager localizedString:@"Please re-enter your passcode"], nil);
        _createPasscodeMismatchedLabelText = NSLocalizedString([TSLanguageManager localizedString:@"Passcodes did not match. Try again"], nil);
        _createPasscodeViewControllerTitle = NSLocalizedString([TSLanguageManager localizedString:@"Set Passcode"], nil);
        _enterPasscodeInitialLabelText = NSLocalizedString([TSLanguageManager localizedString:@"Enter your passcode"], nil);
        _enterPasscodeIncorrectLabelText = NSLocalizedString([TSLanguageManager localizedString:@"Incorrect passcode. Try again."], nil);
        _enterPasscodeViewControllerTitle = NSLocalizedString([TSLanguageManager localizedString:@"Enter Passcode"], nil);
        _splashShouldEmbedInNavigationController = NO;
        _touchIDCancelPresentsPasscodeViewController = NO;
        _navigationBarClass = [UINavigationBar class];
    }
    return self;
}

@end
