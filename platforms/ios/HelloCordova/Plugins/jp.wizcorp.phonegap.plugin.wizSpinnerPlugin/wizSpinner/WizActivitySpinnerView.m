/* WizActivitySpinnerView - Custom UIImageView for gifs
 *
 * @author Ally Ogilvie, Chris Wynn
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file WizActivitySpinnerView.m for PhoneGap
 *
 */

#import "WizActivitySpinnerView.h"
#import <ImageIO/ImageIO.h>

@implementation WizActivitySpinnerView

- (id)initWithImageURL:(NSURL *)url
{
    // For remote URLs, the read of data below will make app unresponsive.
    
    // TODO: Consider changing to asynchronous or background loading of URL data
    
    // Read data from the URL
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // Split data into individual frames using ImageIO (iOS4.0 and above).
    NSMutableArray *frames = nil;
    CGImageSourceRef imgSource = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    if ( imgSource ) {
        size_t count = CGImageSourceGetCount(imgSource);
        frames = [NSMutableArray arrayWithCapacity:count];
        for ( size_t i = 0; i < count; i++ ) {
            // NSLog(@"frame - %d",i);
            CGImageRef img = CGImageSourceCreateImageAtIndex(imgSource, i, NULL);
            if ( img ) {    
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(imgSource);
    }
    
    // Initialize with the frame data.  Note that if frames is nil,
    // both the image and animationImages will be initialized to nil.
    self = [super initWithImage:[frames objectAtIndex:0]];
    if (self) {
        self.animationImages = frames;
    }
    
    return self;
}

- (void)setSize:(CGSize)size
{
    CGRect myBounds = self.bounds;
    myBounds.size = size;
    self.bounds = myBounds;
}

@end
