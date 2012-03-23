/* WizAssetsPluginExtendsPGdelegate - Extend PhoneGapDelegate so we can reach top view
 *
 * @author WizCorp Inc. [ Incorporated Wizards ] 
 * @copyright 2011
 * @file WizAssetsPluginExtendsPGdelegate.m for PhoneGap
 *
 */ 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PhoneGap/PhoneGapDelegate.h>
#import "WizDebugLog.h"


@implementation PhoneGapDelegate (extendViews) 





-(PhoneGapDelegate *) addNewView:(UIView*)progressView

{
    
    [self.window addSubview:progressView];
    //[self.imageView addSubview:progressView];
    
    return NULL;
}

-(PhoneGapDelegate *) removeView:(UIView*)progressView

{
    
    [progressView removeFromSuperview];
    return NULL;
}












-(PhoneGapDelegate *) showPGSplash

{
    
    [self.imageView setHidden:FALSE];
    
    return NULL;
}

-(PhoneGapDelegate *) hidePGSplash

{
    
    [self.imageView setHidden:TRUE];
    
    return NULL;
}







/*
 * hideCustomLoader - Hide loader components
 */
-(PhoneGapDelegate *) hideCustomLoader:(UIView *)progressView
{
    
    
    
    WizLog(@"****************************************** [hideCustomLoader]");
    // remove view
    for(UIActivityIndicatorView*spinnerView in self.window.subviews) {
        if(spinnerView.tag==45){
            [spinnerView setHidden:TRUE];
            [spinnerView setAlpha:0.0];
        }
    }
    for(UITextView*textView in self.window.subviews) {
        if(textView.tag==46){
            [textView setHidden:TRUE];
        }
    }
    for(UIView*screen in self.window.subviews) {
        if(screen.tag==47){
            [screen setHidden:TRUE];
        }
    }
    
    return NULL;
}


/*
 * removeSplashLoader
 */
-(PhoneGapDelegate *) removeCustomLoader:(UIView *)progressView
{
    WizLog(@"****************************************** remove spinner");
    // remove view
    for(UIActivityIndicatorView*spinnerView in self.window.subviews) {
        if(spinnerView.tag==45){
            [spinnerView removeFromSuperview];
        }
    }
    for(UITextView*textView in self.window.subviews) {
        if(textView.tag==46){
            [textView removeFromSuperview];
        }
    }
    for(UIView*screen in self.window.subviews) {
        if(screen.tag==47){
            [screen removeFromSuperview];
        }
    }
    
    return NULL;
    
}




-(PhoneGapDelegate *) showCustomLoader:(NSDictionary *)options
{
    
    WizLog(@"****************************************** [showCustomLoader]");
    
    if (options) 
	{
        // use custom options
        bool showSpinner            = [options objectForKey:@"showSpinner"];
        if (!showSpinner) {
            // default show it
            showSpinner = TRUE;
        } 
        for(UIActivityIndicatorView*spinnerView in self.window.subviews) {
            if(spinnerView.tag==45){
                if (showSpinner == 1) {
                    [spinnerView setHidden:FALSE];
                    [spinnerView setAlpha:1.0];
                    WizLog(@"showSpinner default %i", showSpinner);
                } else {
                    [spinnerView setHidden:TRUE];
                    [spinnerView setAlpha:0.0];
                    WizLog(@"showSpinner default %i", showSpinner);
                }
            }
        }
        
        
        NSString *pos            = [options objectForKey:@"position"];
        if (!pos) {
            // default values
            pos       = @"low";
        }
        for(UIActivityIndicatorView*spinnerView in self.window.subviews) {
            if(spinnerView.tag==45){
                
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                CGFloat screenWidth = screenRect.size.width;
                CGFloat screenHeight = screenRect.size.height;
                
                if ([pos isEqualToString:@"low"]) {
                    
                    [spinnerView setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
                    
                } else if ([pos isEqualToString:@"middle"]) { 
                    
                    [spinnerView setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
                    
                } else if ([pos isEqualToString:@"high"]) {
                    
                    [spinnerView setCenter:CGPointMake(screenWidth/2, screenHeight/0.75)];
                    
                }
            }
        }
        
        
        NSString *spinnerColour                 = [options objectForKey:@"spinnerColour"];
        if (!spinnerColour) {
            // default values
            spinnerColour       = @"white";
        }
        // set spinner colour
        for(UIActivityIndicatorView*spinnerView in self.window.subviews) {
            if(spinnerView.tag==45){
                
                if ([spinnerColour isEqualToString:@"white"]) {
                    [spinnerView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
                } else if ([spinnerColour isEqualToString:@"grey"]) {
                    [spinnerView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                } else {
                    [spinnerView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                }
            }
        }
        
        WizLog(@"spinnerColour %@", spinnerColour);
        
        CGFloat opacity                 = [[options objectForKey:@"opacity"] floatValue];
        if (!opacity) {
            // default values
            opacity       = 0.0;
        } 
        // show black screen
        for(UIView*screen in self.window.subviews) {
            if(screen.tag==47){
                [screen setAlpha:opacity];
                [screen setHidden:FALSE];
            }
        }
        
        
        NSString *labelText               = [options objectForKey:@"labelText"];
        if (!labelText) {
            // default values
            labelText                       = @"Loading...";
        }
        // show text label
        for(UITextView*textView in self.window.subviews) {
            if(textView.tag==46){
                [textView setText:labelText];
                [textView setHidden:FALSE];
            }
        }
        
        
        
        NSString *textColour                 = [options objectForKey:@"textColour"];
        if (!textColour) {
            // default values
            textColour       = @"white";
        }
        // set text colour
        for(UITextView*textView in self.window.subviews) {
            if(textView.tag==46){
                
                // TODO add more colours?
                if ([textColour isEqualToString:@"white"]) {
                    [textView setTextColor:[UIColor whiteColor]];
                } else if ([textColour isEqualToString:@"black"]) {
                    [textView setTextColor:[UIColor blackColor]];
                } else {
                    [textView setTextColor:[UIColor blackColor]];
                }
            }
        }
        
        
        
    } else {
        // defaults
        
        // show spinner
        for(UIActivityIndicatorView*spinnerView in self.window.subviews) {
            if(spinnerView.tag==45){
                [spinnerView setHidden:FALSE];
                [spinnerView setAlpha:1.0];
                [spinnerView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
                
            }
        }
        // show text label
        for(UITextView*textView in self.window.subviews) {
            if(textView.tag==46){
                [textView setText:@"Loading..."];
                [textView setHidden:FALSE];
            }
        }
        // show black screen
        for(UIView*screen in self.window.subviews) {
            if(screen.tag==47){
                CGFloat opacity = 0.4;
                [screen setAlpha:opacity];
                [screen setHidden:FALSE];
            }
        }
        
        
    } 
    
    return NULL;
}


/*
 * createSplashLoader - Add loader with spinner using options
 */
-(PhoneGapDelegate *) createCustomLoader:(NSDictionary *)options
{
    for(UIView*screen in self.window.subviews) {
        if(screen.tag==47){
            WizLog(@"****************************************** ALREADY CREATED SPLASH LOADER - return.");
            return NULL;
        }
    }
    
    WizLog(@"****************************************** CREATE SPLASH LOADER");
    
    
    // defaults
    NSString *pos           = @"white";              
    NSString *labelText     = @"Loading..."; 
    NSString *textColour    = @"white"; 
    CGFloat opacity         = 0.0 ;            
    NSString *spinnerColour = @"white";
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    
    if (options) 
	{
        // get loader options
        spinnerColour                 = [options objectForKey:@"spinnerColour"];
        if (!spinnerColour) {
            // default values
            spinnerColour       = @"white";
        }
        
        pos            = [options objectForKey:@"position"];
        if (!pos) {
            // default values
            pos       = @"low";
        }
        
        
        
        labelText               = [options objectForKey:@"labelText"];
        if (!labelText) {
            // default values
            labelText           = @"Loading...";
        }
        
        
        opacity                 = [[options objectForKey:@"opacity"] floatValue];
        if (!opacity) {
            // default values
            opacity             = 0.0;
        }
        
        
        textColour              = [options objectForKey:@"textColour"];
        if (!textColour) {
            // default values
            textColour          = @"white";
        }
        
    }
    
    // the background screen
    UIView *backgroundScreen = [[UIView alloc] initWithFrame:screenRect];
    backgroundScreen.backgroundColor = [UIColor blackColor];
    backgroundScreen.tag = 47;
    backgroundScreen.alpha = opacity;
    
    
    
    
    // create spinner
    UIActivityIndicatorView *activitySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
    [activitySpinner setAlpha:1.0];
    [activitySpinner setBackgroundColor:[UIColor clearColor]];
    [activitySpinner startAnimating];
    [activitySpinner setTag:45];
    if ([pos isEqualToString:@"low"]) {
        
        [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
        
    } else if ([pos isEqualToString:@"middle"]) { 
        
        [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
        
    } else if ([pos isEqualToString:@"high"]) {
        
        [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/0.75)];
        
    }
    
    if ([spinnerColour isEqualToString:@"white"]) {
        [activitySpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    } else if ([spinnerColour isEqualToString:@"grey"]) {
        [activitySpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    } else {
        [activitySpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    
    
    
    
    // create text..
    UITextView *loaderStatus = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
    [loaderStatus setTag:46];
    [loaderStatus setTextAlignment:UITextAlignmentCenter];
    [loaderStatus setCenter:CGPointMake(screenWidth/2, screenHeight/1.7)];
    [loaderStatus setClipsToBounds:TRUE];
    [loaderStatus setFont:[UIFont italicSystemFontOfSize:10.0]];
    [loaderStatus setBackgroundColor:([UIColor clearColor])];
    [loaderStatus setScrollEnabled:FALSE];
    [loaderStatus setUserInteractionEnabled:FALSE];
    [loaderStatus setText:labelText];
    // TODO more colours?
    if ([textColour isEqualToString:@"white"]) {
        [loaderStatus setTextColor:[UIColor whiteColor]];
    } else if ([textColour isEqualToString:@"black"]) {
        [loaderStatus setTextColor:[UIColor blackColor]];
    }
    
    
    
    
    [self.window addSubview:backgroundScreen];
    
    
    [activitySpinner setHidden:TRUE];
    [activitySpinner setAlpha:0.0];
    // [activitySpinner setCenter:CGPointMake(screenWidth/2, 99999)]; // hidden does not work for some reason
    [loaderStatus setHidden:TRUE];
    
    
    
    
    // add views to screen
    [self.window addSubview:activitySpinner];
    [self.window addSubview:loaderStatus];
    [backgroundScreen retain];
    [activitySpinner retain];
    [loaderStatus retain];
    
    return NULL;
    
}

-(PhoneGapDelegate *) updateLoaderLabel:(NSString *)loaderText
{
    for(UITextView*loaderLabel in self.window.subviews) {
        if(loaderLabel.tag==46){
            [loaderLabel setText:loaderText];
        }
    }
    
    
    return NULL;
    
}





@end
