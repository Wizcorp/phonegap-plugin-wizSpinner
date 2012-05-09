/* SpinnerPlugin - IOS side of the bridge to nativeSpinner JavaScript for PhoneGap
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2011
 * @file SpinnerPlugin.h for PhoneGap
 *
 */

#import <Foundation/Foundation.h>
#ifdef PHONEGAP_FRAMEWORK
#import <PhoneGap/PGPlugin.h>
#else
#import "PGPlugin.h"
#endif

@interface SpinnerPlugin : PGPlugin {

    NSTimer *timeout;
    bool shown;
}

- (void)create:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)show:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)hide:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)rotate:(NSArray*)arguments withDict:(NSDictionary*)options;

@end
