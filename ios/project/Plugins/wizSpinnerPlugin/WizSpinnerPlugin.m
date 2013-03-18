/* WizSpinnerPlugin - IOS side of the bridge to wizSpinner JavaScript for PhoneGap
 *
 * @author Ally Ogilvie
 * @copyright Wizcorp Inc. [ Incorporated Wizards ] 2011
 * @file wizSpinnerPlugin.m for PhoneGap
 *
 */ 

#import "WizSpinnerPlugin.h"
#import "WizAssetsPluginExtendCDVViewController.h"
#import "WizDebugLog.h"

@interface WizSpinnerPlugin () <UIWebViewDelegate>
+ (void)load;
+ (void)didFinishLaunching:(NSNotification *)notification;
+ (void)willTerminate:(NSNotification *)notification;
@end

static NSDictionary *defaults = nil;

@implementation WizSpinnerPlugin

#pragma - Class Methods

+ (void)load
{
    // Register for didFinishLaunching notifications in class load method so that
    // this class can observe launch events.  Do this here because this needs to be
    // registered before the AppDelegate's application:didFinishLaunchingWithOptions:
    // method finishes executing.  A class's load method gets invoked before
    // application:didFinishLaunchingWithOptions is invoked (even if the plugin is
    // not loaded/invoked in the JavaScript).
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    // Register for willTerminate notifications here so that we can observer terminate
    // events and unregister observing launch notifications.  This isn't strictly
    // required (and may not be called according to the docs).
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
}

+ (void)didFinishLaunching:(NSNotification *)notification
{
    // This code will be called immediately after application:didFinishLaunchingWithOptions:.
    
    // Cordova apps have the view controller on the app delegate
    CDVViewController *viewController = nil;
    id <UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    SEL viewControllerSelector = @selector(viewController);

    // Force Cordova to pre-create the plugin command singleton and create the spinner (initially hidden)
    if ( [appDelegate respondsToSelector:viewControllerSelector] ) {
        viewController = [appDelegate performSelector:viewControllerSelector];
        SEL getCommandInstanceSelector = @selector(getCommandInstance:);
        if ( [viewController respondsToSelector:getCommandInstanceSelector] ) {
            
            // Get options from the wizSpinner.plist (in the application bundle)
            NSString *path = [[NSBundle mainBundle] pathForResource:@"wizSpinner" ofType:@"plist"];
            NSMutableDictionary *options = [NSMutableDictionary dictionaryWithContentsOfFile:path];
            
            if ( options == nil ) {
                [NSException raise:NSInternalInconsistencyException
                            format:@"Missing wizSpinner.plist -- required when using the wizSpinner plugin.  Please add it to your application bundle."];
            }
            
            // Read specified defaults.
            defaults = [options objectForKey:@"defaults"];
            if ( defaults == nil ) {
                defaults = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"middle",              @"position",
                            @"0.7",                 @"opacity",
                            @"white",               @"spinnerColor",
                            @"white",               @"textColor",
                            @"Initializing App...", @"label",
                            nil];
            }
            [defaults retain];

            // Create/get the singleton.
            WizSpinnerPlugin *plugin = [viewController getCommandInstance:@"WizSpinnerPlugin"];
            
            // Create the spinner with defaults
            CDVInvokedUrlCommand *cmd = [[CDVInvokedUrlCommand alloc] initWithArguments:[NSArray arrayWithObjects:defaults, nil] callbackId:@"" className:@"wizSpinnerPlugin" methodName:@"create"];
            [plugin create:cmd];
            [cmd release];
            
            // Auto-show the spinner (if requested)
            BOOL autoShowSpinnerOnStart = [[options objectForKey:@"autoShowSpinnerOnStart"] boolValue];
            if ( autoShowSpinnerOnStart ) {
                CDVInvokedUrlCommand *cmd = [[CDVInvokedUrlCommand alloc] initWithArguments:[NSArray arrayWithObjects:defaults, nil] callbackId:@"" className:@"wizSpinnerPlugin" methodName:@"show"];
                [plugin show:cmd];
                [cmd release];
            }
        }
    }    
}

+ (void)willTerminate:(NSNotification *)notification
{
    // Stop the class from observing all notification center notifications.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Release the defaults.
    [defaults release];
}

#pragma - Instance Methods

// house keeping
- (void)dealloc
{
    // Stop the instance from observing all notification center notifications.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

-(CDVPlugin*) initWithWebView:(UIWebView*)theWebView
{
    
    self = (WizSpinnerPlugin*)[super initWithWebView:theWebView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:@"UIDeviceOrientationDidChangeNotification" 
                                               object:nil];

    return self;
}


- (void) orientationChanged:(NSNotification *)notification {  
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if ( (orientation == 0) || (orientation == 5) ) {
        // unsupported orientations
        return;
    }
    
    
    // check orientation supported
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSArray *orientations;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // check ipad orientations
        orientations = [infoDict objectForKey:@"UISupportedInterfaceOrientations~ipad"];
    } else {
        // check iphone orientations
        orientations = [infoDict objectForKey:@"UISupportedInterfaceOrientations"];
    }
    
    if (orientations == NULL) {
        // NSLog(@"no orientations for this device");
        return;
    }
    
    
    // NSLog(@"IS ORIENTATION %d", orientation);
    //NSLog(@"THE orientations %@", orientations);
    
    NSString *orient;
    
    for (int i = 0; i < [orientations count]; i++) {
        
        orient = [orientations objectAtIndex:i];
        
        if ( ([orient isEqualToString:@"UIInterfaceOrientationPortrait"] ) && (orientation == 1) ) {
            [(CDVViewController *)self.viewController rotateCustomLoader:orientation];
        }
        if ( ([orient isEqualToString:@"UIInterfaceOrientationPortraitUpsideDown"] ) && (orientation == 2) ) {
            [(CDVViewController *)self.viewController rotateCustomLoader:orientation];
        }
        if ( ([orient isEqualToString:@"UIInterfaceOrientationLandscapeLeft"] ) && (orientation == 3) ) {
            [(CDVViewController *)self.viewController rotateCustomLoader:orientation];
        }
        if ( ([orient isEqualToString:@"UIInterfaceOrientationLandscapeRight"] ) && (orientation == 4) ) {
            [(CDVViewController *)self.viewController rotateCustomLoader:orientation];
        }
    }

    
}



- (void)create:(CDVInvokedUrlCommand*)command
{
    // CREATE IS ALWAYS CALLED FROM AUTOMATICALLY AT APP START
    // This allows the spinner to be ready for action immediately.
    // use show() and hide() - with options or a default
    
    NSDictionary *options = [command.arguments objectAtIndex:0];
    
    // NSLog(@"WARNING  - - - - - nativeSpinner.create() is depreciated. Create is called automatically by default.");
    
    [(CDVViewController *)self.viewController createCustomLoader:options];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [pluginResult setKeepCallbackAsBool:YES];
    [self writeJavascript: [pluginResult toSuccessCallbackString:command.callbackId]];
    
}

- (void)show:(CDVInvokedUrlCommand*)command
{
    WizLog(@"******************************************show shown var = %i", shown);
    if (shown) {
        return;
    }
    int timeoutInt = 20;
    
    NSDictionary *options = [command.arguments objectAtIndex:0];
    if (options)
	{
        // use custom options
        
        
        int timeoutOpt            = [[options objectForKey:@"timeout"] intValue];
        if (timeoutOpt) {
            // default show it
            timeoutInt = timeoutOpt;
        }
    } else {
        options = defaults;
    }
    
    WizLog(@"****************************************** timeout is %i seconds", timeoutInt);

    // default loader
    [(CDVViewController *)self.viewController showCustomLoader:options];
    shown = TRUE;
    
    // start timer
    timeout = [NSTimer scheduledTimerWithTimeInterval:timeoutInt
                                               target:self
                                             selector:@selector(timedHide:)
                                             userInfo:nil
                                              repeats:NO];

}

- (void)timedHide:(id)sender {
    CDVInvokedUrlCommand *cmd = [[CDVInvokedUrlCommand alloc] initWithArguments:[NSArray arrayWithObjects: nil] callbackId:@"" className:@"wizSpinnerPlugin" methodName:@"hide"];
    [self hide:cmd];
    [cmd release];
}

- (void)hide:(CDVInvokedUrlCommand*)command
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
    
    [(CDVViewController *)self.viewController hideCustomLoader:NULL];
    shown = FALSE;

}


- (void)rotate:(CDVInvokedUrlCommand*)command
{
    NSNumber *orientation = [command.arguments objectAtIndex:0];
    if (orientation) {
        [(CDVViewController *)self.viewController rotateCustomLoader:[orientation intValue]];
    }
}

@end
