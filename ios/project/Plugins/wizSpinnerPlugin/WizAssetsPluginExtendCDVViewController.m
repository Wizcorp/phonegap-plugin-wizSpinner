/* WizAssetsPluginExtendsCDVViewController - Extend CDVViewController so we can reach top view
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2011
 * @file WizAssetsPluginExtendsCDVViewController.m for PhoneGap
 *
 */ 

#import "WizAssetsPluginExtendCDVViewController.h"
#import "WizActivitySpinnerView.h"
#import "WizDebugLog.h"

#define degreesToRadians(x) (M_PI * x / 180.0)

@implementation CDVViewController (extendViews) 


-(CDVViewController*)addNewView:(UIView*)progressView

{
    
    [[UIApplication sharedApplication].keyWindow addSubview:progressView];
    //[self.imageView addSubview:progressView];
    
    return NULL;
}

-(CDVViewController*)removeView:(UIView*)progressView

{
    
    [progressView removeFromSuperview];
    return NULL;
}





/*
 * hideCustomLoader - Hide loader components
 */
-(CDVViewController*)hideCustomLoader:(UIView *)progressView
{
    

    WizLog(@"****************************************** [hideCustomLoader]");
       
    // hide components
    for (UIView* spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if (spinnerHolder.tag==44) {
            // hide all
            
            [[spinnerHolder viewWithTag:45] setHidden:TRUE];
            [[spinnerHolder viewWithTag:45] setAlpha:0.0];

            [[spinnerHolder viewWithTag:46] setHidden:TRUE];
            
            [[spinnerHolder viewWithTag:47] setHidden:TRUE];
            
            [[spinnerHolder viewWithTag:48] setHidden:TRUE];
            [[spinnerHolder viewWithTag:48] setAlpha:0.0];
            
            [spinnerHolder setHidden:TRUE];
        }
        
        
    }

    return NULL;
}


/*
 * removeSplashLoader
 */
-(CDVViewController*)removeCustomLoader:(UIView *)progressView
{
    WizLog(@"****************************************** remove spinner");
    // remove view
    for(UIActivityIndicatorView*spinnerView in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerView.tag==45){
            [spinnerView removeFromSuperview];
        }
    }
    for(UITextView*textView in self.view.subviews) {
        if(textView.tag==46){
            [textView removeFromSuperview];
        }
    }
    for(UIView*screen in self.view.subviews) {
        if(screen.tag==47){
            [screen removeFromSuperview];
        }
    }
    
    return NULL;
    
}


-(CDVViewController*)rotateCustomLoader:(int)orientation
{
    
    
    for(UIView*spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerHolder.tag==44){
            WizLog(@"rotating view.. %@ : orientation... %i", spinnerHolder , orientation);
            
            if (orientation == 1) {
                // portrait normal
                
                [spinnerHolder setAutoresizesSubviews:YES];
                
                spinnerHolder.transform = CGAffineTransformMakeRotation(0.0);
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];
                
                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];
                    }
                }
               
            } else if (orientation == 2) {
                // upside down
                
                [spinnerHolder setAutoresizesSubviews:YES];
                spinnerHolder.transform = CGAffineTransformMakeRotation(degreesToRadians(180)); // 180 degrees
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];

                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];
                    }
                }
                
            } else if (orientation == 3) {
                // landscape to left
                
                [spinnerHolder setAutoresizesSubviews:YES];
                spinnerHolder.transform = CGAffineTransformMakeRotation(degreesToRadians(90)); // 90 degress
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];

                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {                        
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.9)];
                    }
                }
                
            } else if (orientation == 4) {
                // landscape to right
                
                [spinnerHolder setAutoresizesSubviews:YES];
                spinnerHolder.transform = CGAffineTransformMakeRotation(degreesToRadians(-90)); // 270 degrees
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];

                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.9)];
                    }
                }
                
            }    
        }
    }
    

    
    
    return NULL;
}


-(CDVViewController*)showCustomLoader:(NSDictionary *)options
{
    
    WizLog(@"****************************************** [showCustomLoader] %@", options);
    BOOL customSpinner     = FALSE;
    BOOL showSpinner       = TRUE;
    NSString *customSpinnerPath = @"default";
    
    if (options) {
        // use custom options
        if ([options objectForKey:@"showSpinner"]) {
            showSpinner             = [[options objectForKey:@"showSpinner"] boolValue];
        }
        
        if ([options objectForKey:@"customSpinner"]) {
            customSpinner           = [[options objectForKey:@"customSpinner"] boolValue];        
        }
        
        
        NSString *pos               = [options objectForKey:@"position"];
        if (!pos) {
            // default values
            pos = @"middle";
        }  
        
        NSString *spinnerColor      = [options objectForKey:@"spinnerColor"];
        if (!spinnerColor) {
            // default values
            spinnerColor = @"white";
        }

        CGFloat opacity             = [[options objectForKey:@"opacity"] floatValue];
        if (!opacity) {
            // default values
            opacity = 0.0;
        } 

        
        NSString *label             = [options objectForKey:@"label"];
        if ([options objectForKey:@"labelText"]) {
            // backward compatibility for textLabel
            label = [options objectForKey:@"labelText"];
        }
        if (!label) {
            // default values
            label = @"Loading...";
        }

        NSString *color             = [options objectForKey:@"color"];
        if (!color) {
            // default values
            color = @"#fff";
        }
        
        customSpinnerPath           = [options objectForKey:@"customSpinnerPath"];
        if (!customSpinnerPath) {
            customSpinnerPath = @"default";
            
        }
        
        CGFloat width = [[options objectForKey:@"width"] floatValue];
        CGFloat height = [[options objectForKey:@"height"] floatValue];
        

        
        
        if (![customSpinnerPath isEqualToString:@"default"]) {
            // do not do anything a default value means a path has not been give so we can assume no need to change

            for(UIView* spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
                if (spinnerHolder.tag==44) {
                    [[spinnerHolder viewWithTag:45] setHidden:TRUE];
                    [[spinnerHolder viewWithTag:45] removeFromSuperview];
                    
                    NSURL *spinnerUrl = nil;
                    // use custom spinner if default is NOT defined
                    if ([self validateUrl:customSpinnerPath]) {
                        // is url
                        spinnerUrl = [[NSURL alloc] initWithString:customSpinnerPath];

                    } else {
                        // is path
                        spinnerUrl = [[NSURL alloc] initFileURLWithPath:customSpinnerPath];
                        
                    }
                    
                    WizActivitySpinnerView *activitySpinner = [[WizActivitySpinnerView alloc] initWithImageURL:spinnerUrl];
                    [spinnerUrl release];
                    NSLog(@"NEW spinner path - %@", customSpinnerPath);
                                        
                    CGRect screenRect = spinnerHolder.bounds;
                    CGFloat screenWidth = screenRect.size.width;
                    CGFloat screenHeight = screenRect.size.height;
                    
                    [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
                    [activitySpinner setAlpha:1.0];
                    [activitySpinner setBackgroundColor:[UIColor clearColor]];
                    [activitySpinner startAnimating];
                    [activitySpinner setTag:45];
                    [activitySpinner setClipsToBounds:TRUE];
                    [activitySpinner setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
                    [activitySpinner setContentMode:UIViewContentModeScaleToFill];
                    if ( width > 0 && height > 0 ) {
                        [activitySpinner setSize:CGSizeMake(width, height)];
                    }
                    
                    [activitySpinner setHidden:TRUE];
                    [activitySpinner setAlpha:0.0];
                    [spinnerHolder addSubview:activitySpinner];
                    
                    
                    [activitySpinner release];

                }
            }
            
            
        }

        
        // show and set components
        for(UIView* spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
            if(spinnerHolder.tag==44){
                
                CGRect screenRect = [spinnerHolder bounds];
                CGFloat screenWidth = screenRect.size.width;
                CGFloat screenHeight = screenRect.size.height;
                
                
                // additional settings for apple spinner
                UIActivityIndicatorView *appleSpinner = (UIActivityIndicatorView*)[spinnerHolder viewWithTag:48];
                if ([spinnerColor isEqualToString:@"white"]) {
                    [appleSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
                } else if ([spinnerColor isEqualToString:@"grey"]) {
                    [appleSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                } else {
                    [appleSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                }
                if ([pos isEqualToString:@"low"]) {
                    [appleSpinner setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
                } else if ([pos isEqualToString:@"middle"]) { 
                    [appleSpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
                } else {
                    // default middle
                    [appleSpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
                }
                
                // additional settings for the custom activity spinner
                WizActivitySpinnerView *activitySpinner = (WizActivitySpinnerView*)[spinnerHolder viewWithTag:45];
                if ( [options objectForKey:@"spinDuration"] ) {
                    NSTimeInterval spinDuration = [[options objectForKey:@"spinDuration"] floatValue];
                    if ( spinDuration <= 0 ) {
                        // Set animation duration to the default which is (according to UIImageView documentation)
                        // the number of images multiplied by 1/30th of a second.
                        spinDuration = [activitySpinner.image.images count] / 30.0;
                    }
                    [activitySpinner setAnimationDuration:spinDuration];
                }
                if ( [options objectForKey:@"spinLoops"] ) {
                    NSInteger spinLoops = MAX( 0, [[options objectForKey:@"spinLoops"] intValue] );
                    [activitySpinner setAnimationRepeatCount:spinLoops];
                }

                // set text label
                UITextView *textBox = (UITextView*)[spinnerHolder viewWithTag:46];
                [textBox setText:label];
                [textBox setHidden:FALSE];
                // move the centre point down so under the spinner (default is portrait)
                [textBox setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];
                if ([color isEqualToString:@"transparent"]) {
                    [textBox setTextColor:[UIColor clearColor]];
                } else {
                    [textBox setTextColor:[self colorWithHexString:color]];            
                }
                
                
                // set back screen
                [[spinnerHolder viewWithTag:47] setAlpha:opacity];
                [[spinnerHolder viewWithTag:47] setHidden:FALSE];
                
                if (showSpinner == 1) {
                    if (customSpinner == 1) {
                        // set custom spinner visible
                        [activitySpinner setHidden:FALSE];
                        [activitySpinner setAlpha:1.0];
                        [activitySpinner startAnimating];
                        [appleSpinner setHidden:TRUE];
                        [appleSpinner setAlpha:0.0];
                    } else {
                        // set Apple Spinner visible
                        [activitySpinner setHidden:TRUE];
                        [activitySpinner setAlpha:0.0];
                        [activitySpinner stopAnimating];
                        [appleSpinner setHidden:FALSE];
                        [appleSpinner setAlpha:1.0];
                    }
                } else {
                    [appleSpinner setHidden:TRUE];
                    [appleSpinner setAlpha:0.0];
                    [activitySpinner setHidden:TRUE];
                    [activitySpinner setAlpha:0.0];
                    [activitySpinner stopAnimating];
                }
                
                
            }
        }
                
        
    } else {
        // defaults

        
        // show components
        for (UIView* spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
            if (spinnerHolder.tag == 44){
                // show apple spinner
                [[spinnerHolder viewWithTag:48] setHidden:FALSE];
                [[spinnerHolder viewWithTag:48] setAlpha:1.0];
                
                // show text label
                UITextView *textBox = (UITextView*)[spinnerHolder viewWithTag:46];
                [textBox setText:@"Loading..."];
                [textBox setHidden:FALSE];
                
                // show black screen
                // CGFloat opacity = 0.4;
                // [[spinnerHolder viewWithTag:47] setAlpha:opacity];
                [[spinnerHolder viewWithTag:47] setHidden:FALSE];
            }
        }

    } 
    
    
    int orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (orientation != 1) {
        [self rotateCustomLoader:orientation];
    }

    
    for (UIView*spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if (spinnerHolder.tag == 44) {
            [spinnerHolder setHidden:FALSE];
        }
    }
    
    return NULL;
}


/*
 * createSplashLoader - Add loader with spinner using options
 */
-(CDVViewController*)createCustomLoader:(NSDictionary *)options
{
    for(UIView*screen in [UIApplication sharedApplication].keyWindow.subviews) {
        if(screen.tag==44){
            WizLog(@"****************************************** ALREADY CREATED SPLASH LOADER - return.");
            return NULL;
        }
    }
    
    WizLog(@"****************************************** CREATE SPLASH LOADER");
    
    
    // defaults
    NSString *pos           = @"middle";              
    NSString *label         = @"Loading..."; 
    NSString *color         = @"#fff"; 
    NSString *bgColor       = @"#000";
    CGFloat opacity         = 0.0;
    NSString *spinnerColor  = @"white";
    CGFloat width           = 0.0;
    CGFloat height          = 0.0;
    NSTimeInterval spinDuration = 0;
    NSInteger spinLoops = 0;
    NSString *customSpinnerPath = @"default";
    
    if (options) {      
        
        // get loader options
        spinnerColor                 = [options objectForKey:@"spinnerColor"];
        if (!spinnerColor) {
            // default values
            spinnerColor       = @"white";
        }
        
        pos            = [options objectForKey:@"position"];
        if (!pos) {
            // default values
            pos       = @"middle";
        }
        
        
        
        label               = [options objectForKey:@"label"];
        if ([options objectForKey:@"labelText"]) {
            // backward compatibility for textLabel
            label = [options objectForKey:@"labelText"];
        }
        if (!label) {
            // default values
            label           = @"Loading...";
        }
        
        
        opacity                 = [[options objectForKey:@"opacity"] floatValue];
        if (!opacity) {
            // default values
            opacity             = 0.0;
        }
        
        
        color              = [options objectForKey:@"color"];
        if (!color) {
            // default values
            color          = @"#fff";
        }
        
        customSpinnerPath       = [options objectForKey:@"customSpinnerPath"];
        if (!customSpinnerPath) {
            customSpinnerPath = @"default";

        }
        
        width = [[options objectForKey:@"width"] floatValue];
        height = [[options objectForKey:@"height"] floatValue];
        
        spinDuration = [[options objectForKey:@"spinDuration"] floatValue];
        spinLoops = [[options objectForKey:@"spinLoops"] intValue];
    }

    // the holder for everything
    // Note: The spinner holder will cover the whole winow so initialize using the application's window frame
    UIView *spinnerHolder = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    spinnerHolder.tag = 44;
    spinnerHolder.hidden = TRUE;
    [spinnerHolder setClipsToBounds:TRUE];
    [spinnerHolder setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [spinnerHolder setContentMode:UIViewContentModeScaleToFill];
    [spinnerHolder setAutoresizesSubviews:YES];

    
    CGRect screenRect = spinnerHolder.bounds;
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    // the background screen
    UIView *backgroundScreen = [[UIView alloc] initWithFrame:spinnerHolder.frame];
    if ([bgColor isEqualToString:@"transparent"]) {
        backgroundScreen.backgroundColor = [UIColor clearColor];
    } else {
        backgroundScreen.backgroundColor = [self colorWithHexString:bgColor];            
    }
    
    backgroundScreen.tag = 47;
    backgroundScreen.alpha = opacity;
    [backgroundScreen setClipsToBounds:TRUE];
    [backgroundScreen setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [backgroundScreen setContentMode:UIViewContentModeScaleToFill];
    
    
    // create Apple Spinner
    UIActivityIndicatorView *appleSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [appleSpinner setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
    [appleSpinner setAlpha:1.0];
    [appleSpinner setBackgroundColor:[UIColor clearColor]];
    [appleSpinner startAnimating];
    [appleSpinner setTag:48];
    [appleSpinner setClipsToBounds:TRUE];
    [appleSpinner setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    [appleSpinner setContentMode:UIViewContentModeScaleToFill];
    if ([pos isEqualToString:@"low"]) {
        [appleSpinner setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
    } else if ([pos isEqualToString:@"middle"]) { 
        [appleSpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
    } else {
        // default middle
        [appleSpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
    }
    
    if ([spinnerColor isEqualToString:@"white"]) {
        [appleSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    } else if ([spinnerColor isEqualToString:@"grey"]) {
        [appleSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    } else {
        [appleSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    
    
    
    
    
    // create custom spinner
    // Some URLs for testing local and remote loading of custom animated .gif
    // (Invalid URL or non-existent file will fail silently and not display any image)
    // TODO: Add some reasonable error handling and default image
    // NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"custom" ofType:@"gif" inDirectory:nil]];
    // NSURL *url = [NSURL URLWithString:@"https://github.com/aogilvie/practical-test-01/raw/master/custom.gif"];
    // NSURL *url = [NSURL URLWithString:@"http://images.animationfactory.com/thw/thw14/AF/animations/time/clocks/mr_alarm_dragging_feet/4966736.gif?mr_alarm_dragging_feet_lg_wm"];
    
    NSLog(@"customSpinnerPath is %@", customSpinnerPath);
    
    NSURL *spinnerUrl = nil;
    
    if ([customSpinnerPath isEqualToString:@"default"]) {
        spinnerUrl = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"www/phonegap/plugin/wizSpinner/spinner" ofType:@"gif" inDirectory:nil]];
    } else {
        // use custom spinner
        if ([self validateUrl:customSpinnerPath]) {
            // is url
            spinnerUrl = [[NSURL alloc] initWithString:customSpinnerPath];
        } else {
            // is path
            spinnerUrl = [[NSURL alloc] initFileURLWithPath:customSpinnerPath];
        }        
    }
    NSLog(@"spinner path - %@", customSpinnerPath);
    
    WizActivitySpinnerView *activitySpinner = [[WizActivitySpinnerView alloc] initWithImageURL:spinnerUrl];
    [spinnerUrl release];
    
    [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
    [activitySpinner setAlpha:1.0];
    [activitySpinner setBackgroundColor:[UIColor clearColor]];
    if ( spinDuration > 0 ) {
        [activitySpinner setAnimationDuration:spinDuration];
    }
    if ( spinLoops > 0 ) {
        [activitySpinner setAnimationRepeatCount:spinLoops];
    }
    [activitySpinner startAnimating];
    [activitySpinner setTag:45];
    [activitySpinner setClipsToBounds:TRUE];
    [activitySpinner setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    [activitySpinner setContentMode:UIViewContentModeScaleToFill];
    if ( width > 0 && height > 0 ) {
        [activitySpinner setSize:CGSizeMake(width, height)];
    }
        
    
    

    // create text..
    UITextView *loaderStatus = [[UITextView alloc] initWithFrame:spinnerHolder.bounds];
    [loaderStatus setTag:46];
    [loaderStatus setTextAlignment:UITextAlignmentCenter];
    [loaderStatus setFont:[UIFont italicSystemFontOfSize:10.0]];
    [loaderStatus setBackgroundColor:([UIColor clearColor])];
    [loaderStatus setScrollEnabled:FALSE];
    [loaderStatus setUserInteractionEnabled:FALSE];
    [loaderStatus setText:label];
    [loaderStatus setClipsToBounds:TRUE];
    
    // move the centre point down so under the spinner (default is portrait)
    [loaderStatus setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];

    [loaderStatus setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];    
    
    
    if ([color isEqualToString:@"transparent"]) {
        [loaderStatus setTextColor:[UIColor clearColor]];
    } else {
        [loaderStatus setTextColor:[self colorWithHexString:color]];            
    }
    

    [appleSpinner setHidden:TRUE];
    [appleSpinner setAlpha:0.0];
    
    [activitySpinner setHidden:TRUE];
    [activitySpinner setAlpha:0.0];
    
    [loaderStatus setHidden:TRUE];
    
    [[UIApplication sharedApplication].keyWindow addSubview:spinnerHolder];
    
    
    // add views to screen
    [spinnerHolder addSubview:backgroundScreen];
    [spinnerHolder addSubview:activitySpinner];
    [spinnerHolder addSubview:loaderStatus];
    [spinnerHolder addSubview:appleSpinner];
    
    
    // After these release messages are sent, the objects remain allocated
    // (with a retainCount of 1) for as long as they have a superview.
    // The previous code sent retain messages which incremented the retainCounts
    // without ever decrementing retainCounts (via release messages).  Worse, the
    // original code didn't even hang on to the objects as member variables or
    // properties -- so it was not even possible to send release messages later.
    [backgroundScreen release];
    [activitySpinner release];
    [loaderStatus release];
    [appleSpinner release];


    // release to spinnerHolder.
    [spinnerHolder release];
    
    return NULL;
    
}

-(CDVViewController*)updateLoaderLabel:(NSString *)loaderText
{
    for (UIView*spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerHolder.tag==44){
            for(UITextView*loaderLabel in spinnerHolder.subviews) {
                if(loaderLabel.tag==46){
                    [loaderLabel setText:loaderText];
                }
            }
        }
    }

    return NULL;
    
}


- (BOOL) validateUrl: (NSString *) candidate {
    NSString* lowerCased = [candidate lowercaseString];
    return [lowerCased hasPrefix:@"http://"] || [lowerCased hasPrefix:@"https://"];
}



/**
 
 COLOUR CALCULATOR
 
 
 **/

- (UIColor *) colorWithHexString: (NSString *) hexString 
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];          
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];                      
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];                      
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RGB, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length 
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
