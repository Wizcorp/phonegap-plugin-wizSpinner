/* WizActivitySpinnerView - Custom UIImageView for gifs
 *
 * @author Ally Ogilvie, Chris Wynn
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file WizActivitySpinnerView.h for PhoneGap
 *
 */

#import <UIKit/UIKit.h>

@interface WizActivitySpinnerView : UIImageView

- (id)initWithImageURL:(NSURL *)url;
- (void)setSize:(CGSize)size;

@end
