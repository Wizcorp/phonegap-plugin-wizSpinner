/* SpinnerPlugin - IOS side of the bridge to nativeSpinner JavaScript for PhoneGap
 *
 * @author WizCorp Inc. [ Incorporated Wizards ] 
 * @copyright 2011
 * @file SpinnerPlugin.m for PhoneGap
 *
 */ 

#import "SpinnerPlugin.h"
#import "WizAssetsPluginExtendPGdelegate.h"
#import "WizDebugLog.h"


@implementation SpinnerPlugin

-(PGPlugin*) initWithWebView:(UIWebView*)theWebView
{
    
    self = (SpinnerPlugin*)[super initWithWebView:theWebView];
    
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"gameConfig" ofType:@"plist"];
    
    // Build dictionary from the plist  
    NSMutableDictionary *gameConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    BOOL enableCustomLoaderAtSplash  = [[gameConfig objectForKey:@"enableCustomLoaderAtSplash"]boolValue];
    
    
    
    if (enableCustomLoaderAtSplash==1) {
        shown = TRUE;
    } else {
        shown = FALSE;
    }
    
    [gameConfig release];
    
    return self;
}

- (void)create:(NSArray*)arguments withDict:(NSDictionary*)options
{
    // CREATE IS ALWAYS CALLED FROM NATIVE AT APP START
    // This allows the spinner to be ready for action immediately.
    // use show() and hide() - with options or a default
    
    
    WizLog(@"WARNING  - - - - - nativeSpinner.create() is depreciated. Create is called from native by default.");
    
    
    
    
    /*
    // remove the splash spinner if existing
    [self.appDelegate removeSplashLoader:NULL];
    
    if (options) 
	{
        
        // get loader options
        [self.appDelegate showSplashLoader:options];
        [self.appDelegate updateLoaderLabel:@"this is a middle"];

    } else {
        
        // default loader
        [self.appDelegate showSplashLoader:NULL];
        [self.appDelegate updateLoaderLabel:@"Loading..."];
    }
    */
    
    /*
    container = [[UIView alloc] initWithFrame:originalWebViewBounds];
    */
    
    
    /*
    activityLabel = [[UILabel alloc] init];
    activityLabel.text = NSLocalizedString(@"Loading", @"string1");
    activityLabel.textColor = [UIColor whiteColor];
    activityLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:17];
    [container addSubview:activityLabel];
    activityLabel.frame = CGRectMake(0, 3, 70, 25);
    */
    
    
    /*
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [container addSubview:activityIndicator];
    activityIndicator.frame = CGRectMake(originalWebViewBounds.size.width/2 - 15, originalWebViewBounds.size.height/2 - 15, 30, 30);
 
    [self.webView.superview addSubview:container];
    //container.center = CGPointMake(originalWebViewBounds.size.width/2, originalWebViewBounds.size.height/2);
    //self.view.backgroundColor = [UIColor whiteColor];
    container.backgroundColor = [UIColor blackColor];
    container.alpha = .5;
    
    container.hidden = YES;
    NSLog(@"Spinner created");
    */
    
}

- (void)show:(NSArray*)arguments withDict:(NSDictionary*)options
{
    WizLog(@"******************************************show shown var = %i", shown);
    if (shown) {
        return;
    }
    int timeoutInt = 20;
    if (options) 
	{
        // use custom options
        
        
        int timeoutOpt            = [[options objectForKey:@"timeout"] intValue];
        if (timeoutOpt) {
            // default show it
            timeoutInt = timeoutOpt;
        }
    }
    
    WizLog(@"****************************************** timeout is %i seconds", timeoutInt);

    // default loader
    [self.appDelegate showCustomLoader:options];
    shown = TRUE;
    
    // start timer
    timeout = [NSTimer scheduledTimerWithTimeInterval:timeoutInt
                                               target:self
                                             selector:@selector(timedHide:)
                                             userInfo:nil
                                              repeats:NO];

}

- (void)timedHide:(id)sender {
    [self hide:NULL withDict:NULL];
}

- (void)hide:(NSArray*)arguments withDict:(NSDictionary*)options
{
    WizLog(@"******************************************hide shown var = %i", shown);

    // kill timer
    if (timeout) {
        [timeout invalidate];
        timeout = nil;
    }
    
    if (shown == FALSE) {
        return;
    }
    
    WizLog(@"****************************************** called ");

    [self.appDelegate hideCustomLoader:NULL];
    shown = FALSE;

}

@end
