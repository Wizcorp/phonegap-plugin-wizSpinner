/* MainViewController
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file MainViewController.m
 *
 */

#import "MainViewController.h"

#import "WizViewManagerPlugin.h"
#import "WizDebugLog.h"

@implementation MainViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        onReboot = FALSE;
    }
    return self;
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}



- (void) webViewDidStartLoad:(UIWebView*)theWebView 
{
    
    
    
    // Create the native splash / game loader (ALL options optional / no options pass NULL)
    // Create MUST be called so that it can be used from Javascript
    
    WizLog(@"[MainViewController] ---------- onReboot %i", onReboot);
    if (!onReboot) {
        
        [self createCustomLoader:NULL];
        WizLog(@"[MainViewController] ---------- Created Spinner");
        
        /*
        BOOL enableCustomLoaderAtSplash  = [[[AppDelegate getGameConfig] objectForKey:@"enableCustomLoaderAtSplash"]boolValue];
        if (enableCustomLoaderAtSplash==1) {
            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"middle",                     @"position",
                                     @"0.7",                        @"opacity",
                                     @"white",                      @"spinnerColour",
                                     @"white",                      @"textColour",
                                     @"Initializing Game Engine..", @"labelText",
                                     nil];
            [self showCustomLoader:options];
            
        }
        */
    }
    
    
	return [super webViewDidStartLoad:theWebView];
}



- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    // If get this request reboot...
    NSString *requestString = [[request URL] absoluteString];
    NSArray* prefixer = [requestString componentsSeparatedByString:@":"];
    
    
    // do insensitive compare to support SDK >5
    if ([(NSString*)[prefixer objectAtIndex:0] caseInsensitiveCompare:@"wizMessageView"] == 0) {
        
        NSArray* components = [requestString componentsSeparatedByString:@"://"];
        NSString* messageData = (NSString*)[components objectAtIndex:1];
        
        NSRange range = [messageData rangeOfString:@"?"];
        
        NSString* targetView = [messageData substringToIndex:range.location];
        
        NSLog(@"[AppDelegate wizMessageView()] ******* targetView is:  %@", targetView );
        
        int targetLength = targetView.length;
        
        NSString* postData = [messageData substringFromIndex:targetLength+1];
        
        // WizLog(@"[AppDelegate wizMessageView()] ******* postData is:  %@", postData );
        
        NSMutableDictionary * viewList = [[NSMutableDictionary alloc] initWithDictionary:[WizViewManagerPlugin getViews]];

        if ([viewList objectForKey:targetView]) {
            UIWebView* targetWebView = [viewList objectForKey:targetView]; 
            NSString *postDataEscaped = [postData stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
            [targetWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"wizMessageReceiver('%@');", postDataEscaped]];
            
            // WizLog(@"[AppDelegate wizMessageView()] ******* current views... %@", viewList);
        }
        
        [viewList release];
        
        
        return NO;
        
 	} 
 	return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}



@end
