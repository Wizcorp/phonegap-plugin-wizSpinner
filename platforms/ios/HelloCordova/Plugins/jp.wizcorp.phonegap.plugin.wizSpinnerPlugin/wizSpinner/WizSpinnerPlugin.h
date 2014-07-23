/* SpinnerPlugin - IOS side of the bridge to WizSpinner JavaScript for PhoneGap
 *
 * @author Ally Ogilvie
 * @copyright Wizcorp Inc. [ Incorporated Wizards ] 2011
 * @file WizSpinnerPlugin.h for Cordova
 *
 */

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface WizSpinnerPlugin : CDVPlugin {

    NSTimer *timeout;
    bool shown;
}

- (void)create:(CDVInvokedUrlCommand*)command;
- (void)show:(CDVInvokedUrlCommand*)command;
- (void)hide:(CDVInvokedUrlCommand*)command;
- (void)rotate:(CDVInvokedUrlCommand*)command;

@end
