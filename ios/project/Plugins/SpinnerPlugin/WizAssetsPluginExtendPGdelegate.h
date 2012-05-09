/* WizAssetsPluginExtendsPGdelegate - Extend PhoneGapDelegate so we can reach top views
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2011
 * @file WizAssetsPluginExtendsPGdelegate.h for PhoneGap
 *
 */ 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PhoneGap/PhoneGapDelegate.h>



@interface PhoneGapDelegate (extendViews)


-(PhoneGapDelegate *) addWizConsole:(UITextView*)consoleView;
-(PhoneGapDelegate *) updateWizConsole:(NSString*)myText;
-(PhoneGapDelegate *) showWizConsole:(NSString*)myText;
-(PhoneGapDelegate *) hideWizConsole:(NSString*)myText;




-(PhoneGapDelegate *) createCustomLoader:(NSDictionary*)splashLoaderView;
-(PhoneGapDelegate *) hideCustomLoader:(UIView*)splashLoaderView;
-(PhoneGapDelegate *) showCustomLoader:(NSDictionary*)splashLoaderView;
-(PhoneGapDelegate *) removeCustomLoader:(UIView*)splashLoaderView;
-(PhoneGapDelegate *) updateLoaderLabel:(NSString*)loaderText;
-(PhoneGapDelegate *) rotateCustomLoader:(int)orientation;


-(PhoneGapDelegate *) showPGSplash;
-(PhoneGapDelegate *) hidePGSplash;

@end