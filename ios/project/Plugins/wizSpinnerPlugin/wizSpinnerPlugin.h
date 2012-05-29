/* SpinnerPlugin - IOS side of the bridge to wizSpinner JavaScript for PhoneGap
 *
 * @author Ally Ogilvie
 * @copyright Wizcorp Inc. [ Incorporated Wizards ] 2011
 * @file wizSpinnerPlugin.h for Cordova
 *
 */

#import <Foundation/Foundation.h>
#ifdef CORDOVA_FRAMEWORK
#import <Cordova/CDVPlugin.h>
#else
#import "CDVPlugin.h"
#endif

@interface wizSpinnerPlugin : CDVPlugin {

    NSTimer *timeout;
    bool shown;
}

- (void)create:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)show:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)hide:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)rotate:(NSArray*)arguments withDict:(NSDictionary*)options;

@end
