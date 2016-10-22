#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIWindow+Private.h>
#import "Triforce.h"
#import "StarOfDavid.h"
#import "Cross.h"
#import "Ottoman.h"
#import "Star.h"
#import "YinYang.h"
#import "Sunburst.h"
#import "HualosUIWindow.h"

@interface SBScreenFlash: NSObject 

//CONSTANTS
#define ONOFF @"OnOff"
#define RANDOM @"Random"
#define PLIST_FILENAME @"/var/mobile/Library/Preferences/com.sst1337.NemerovPlus.plist"

//PLIST KEYS
#define DIRECTION @"Direction"
#define PRIMARYCOLOR @"Primary Color"
#define SECONDARYCOLOR @"Secondary Color"
#define ANIMATION @"Animation"
#define IMAGELOCATION @"Image Path"
#define SIZETOFIT @"Size To Fit"

/*DIRECTIONS:*/
#define TOP_LEFT @"Top Left"
#define TOP_RIGHT @"Top Right"
#define BOTTOM_LEFT @"Bottom Left"
#define BOTTOM_RIGHT @"Bottom Right"
#define CENTER @"Center"

/*ANIMATIONS:*/
#define RIPPLE @"Ripple"
#define CHECKERBOARD @"CheckerBoard"
#define TRIFORCE @"Triforce"
#define SHRINK @"Shrink"
#define EXPAND @"Expand"
#define FLASHANDREVERSE @"Flash and Reverse"
#define DOUBLECOLORFLASH @"Double Color Flash"
#define STAROFDAVID @"Star of David"
#define CROSS @"Cross"
#define OTTOMAN @"Ottoman"
#define AMERICANFLAG @"American Flag"
#define YINYANG @"Yinyang"
#define SUNBURST @"Sunburst"
#define SHATTER @"Shatter"
#define VERTICALFLIP @"Vertical Flip"
#define HORIZONTALFLIP @"Horizontal Flip"
#define DANCE @"Dance"
#define DISMISS @"Dismiss"
#define FALL @"Fall"
#define KHANDA @"Khanda"
#define ACEOFSPADES @"Ace of Spades"
#define LIKE @"Like"

//DEFAULT
#define ORIGINAL @"Original"
- (void)originalEffect:(UIView *)screenShotView;

//HELPERS
- (CGRect)newRect:(CGRect)rect withDirection:(NSString *)direction;
- (UIColor *)randomColor;
- (NSString *)randomDirection;
- (NSString *)randomAnimation;
- (UIColor *)getColorWithKey:(NSString *)key;
- (UIColor *)getPrimaryColor;
- (UIColor *)getSecondaryColor;
- (NSString *)getAnimation;
- (NSString *)getDirection;
- (NSString *)getImagePath;
- (BOOL)isSizeToFit;
- (void)animateScreen:(UIView *)screenShotView;
- (void)createWindow;
- (void)destroyWindow;
- (BOOL)isEnabled;
- (UIImage *)getImage;
- (BOOL)addImageToView:(UIView *)screenShotView;




//GOOD ANIMATIONS
- (void)shrinkFadeEffect:(UIView *)screenShotView fromDirection:(NSString *)direction; //take in flags for corners
- (void)expandFadeEffect:(UIView *)screenShotView fromDirection:(NSString *)direction; //take in flags for corners
- (void)rippleEffect:(UIView *)screenShotView;
- (void)checkerBoardEffect:(UIView *)screenShotView;
- (void)triforceEffect:(UIView *)screenShotView;
- (void)yinyangEffect:(UIView *)screenShotView;
- (void)sunburstEffect:(UIView *)screenShotView;
- (void)shatterEffect:(UIView *)screenShotView;


//OK ANIMATIONS
- (void)khandaEffect:(UIView *)screenShotView;
- (void)flashAndReverseEffect:(UIView *)screenShotView;
- (void)doubleRandomColorFadeEffect:(UIView *)screenShotView;
- (void)crossEffect:(UIView *)screenShotView;
- (void)starOfDavidEffect:(UIView *)screenShotView;
- (void)ottomanEffect:(UIView *)screenShotView;
- (void)americanFlagEffect:(UIView *)screenShotView;
- (void)verticalflipEffect:(UIView *)screenShotView;
- (void)horizontalflipEffect:(UIView *)screenShotView;
- (void)danceEffect:(UIView *)screenShotView;
- (void)dismissEffect:(UIView *)screenShotView;
- (void)fallEffect:(UIView *)screenShotView;
- (void)aceOfSpadesEffect:(UIView *)screenShotView;
- (void)likeEffect:(UIView *)screenShotView;
@end

static HualosUIWindow *content = nil;
static UIDynamicAnimator *animator = nil;

%hook SBScreenFlash


// HELPERS

%new
- (UIColor *)randomColor
{
  NSArray *Colors =    @[[UIColor redColor],
                        [UIColor cyanColor],
                        [UIColor greenColor],
                        [UIColor magentaColor],
                        [UIColor orangeColor],
                        [UIColor purpleColor],
                        [UIColor blueColor],
                        [UIColor yellowColor],
                        [UIColor whiteColor],
                        [UIColor blackColor]];
  NSUInteger randomIndex = arc4random() % [Colors count];
  UIColor *color = Colors[randomIndex];

  return color;
}

%new
- (NSString *)randomDirection
{
  NSArray *Directions =    @[CENTER, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT];
  NSUInteger randomIndex = arc4random() % [Directions count];
  NSString *direction = Directions[randomIndex];

  return direction;
}

%new
- (NSString *)randomAnimation
{
    NSArray *Animations =    @[AMERICANFLAG, RIPPLE, CHECKERBOARD, TRIFORCE, EXPAND, SHRINK, DOUBLECOLORFLASH, 
                                FLASHANDREVERSE];
  NSUInteger randomIndex = arc4random() % [Animations count];
  NSString *animation = Animations[randomIndex];

  return animation;
}

%new
- (CGRect)newRect:(CGRect)rect withDirection:(NSString *)direction
{

    if([direction isEqualToString:CENTER]) {
      CGFloat midX = CGRectGetMidX( rect );
      CGFloat midY = CGRectGetMidY( rect );
      return CGRectMake(midX, midY, 0, 0);
    }
    else if ([direction isEqualToString:TOP_RIGHT])
    {
      CGFloat maxX = CGRectGetMaxX( rect );
      return CGRectMake(maxX, 0, 0, 0);
    }
    else if ([direction isEqualToString:TOP_LEFT])
    {
      return CGRectMake(0, 0, 0, 0);
    }
    else if ([direction isEqualToString:BOTTOM_LEFT])
    {
      CGFloat maxY = CGRectGetMaxY( rect );
      return CGRectMake(0, maxY, 0, 0);
    }
    else if ([direction isEqualToString:BOTTOM_RIGHT])
    {
      CGFloat maxX = CGRectGetMaxX( rect );
      CGFloat maxY = CGRectGetMaxY( rect );
      return CGRectMake(maxX, maxY, 0, 0);
    }
    else {
      return rect;
    }
}

%new
- (UIColor *)getColorWithKey:(NSString *)key
{
  if([key isEqualToString:@"Red"]) return [UIColor redColor];
  else if ([key isEqualToString:@"Cyan"]) return [UIColor cyanColor];
  else if ([key isEqualToString:@"Green"]) return [UIColor greenColor];
  else if ([key isEqualToString:@"Magenta"]) return [UIColor magentaColor];
  else if ([key isEqualToString:@"Orange"]) return [UIColor orangeColor];
  else if ([key isEqualToString:@"Purple"]) return [UIColor purpleColor];
  else if ([key isEqualToString:@"Blue"]) return [UIColor blueColor];
  else if ([key isEqualToString:@"Yellow"]) return [UIColor yellowColor];
  else if ([key isEqualToString:@"White"]) return [UIColor whiteColor];
  else if ([key isEqualToString:@"Black"]) return [UIColor blackColor];
  else return [self randomColor];
}

%new
- (BOOL)isEnabled
{
  NSDictionary *settings = [[%c(NSDictionary) alloc] initWithContentsOfFile:PLIST_FILENAME];
  if([[settings objectForKey: ONOFF] boolValue] || [settings objectForKey: ONOFF] == nil) return YES;  
  return NO;
}

%new
- (BOOL)isSizeToFit
{
  NSDictionary *settings = [[%c(NSDictionary) alloc] initWithContentsOfFile:PLIST_FILENAME];
  if([[settings objectForKey: SIZETOFIT] boolValue] == NO|| [settings objectForKey: SIZETOFIT] == nil) return NO;  
  return YES;
}

%new
- (UIColor *)getPrimaryColor
{
    NSDictionary *settings = [[%c(NSDictionary) alloc] initWithContentsOfFile:PLIST_FILENAME];
    if ([settings objectForKey:PRIMARYCOLOR] == nil) return [self getColorWithKey:RANDOM];
    return [self getColorWithKey:[settings objectForKey:PRIMARYCOLOR] ];

}

%new
- (UIColor *)getSecondaryColor
{
    NSDictionary *settings = [[%c(NSDictionary) alloc] initWithContentsOfFile:PLIST_FILENAME];
    if ([settings objectForKey:SECONDARYCOLOR] == nil) return [self getColorWithKey:RANDOM];
    return [self getColorWithKey:[settings objectForKey:SECONDARYCOLOR]];
}

%new
- (NSString *)getAnimation
{
  NSDictionary *settings = [[%c(NSDictionary) alloc] initWithContentsOfFile:PLIST_FILENAME];
  if([settings objectForKey:ANIMATION] == nil) return ORIGINAL;
  return [settings objectForKey:ANIMATION];
}

%new 
- (NSString *)getDirection
{
    NSDictionary *settings = [[%c(NSDictionary) alloc] initWithContentsOfFile:PLIST_FILENAME];
    NSString *direction = (NSString *)[settings objectForKey:DIRECTION];
    if([direction isEqualToString:RANDOM] || direction == nil) return [self randomDirection];
    else return direction;
}

%new
- (NSString *)getImagePath
{
    NSDictionary *settings = [[%c(NSDictionary) alloc] initWithContentsOfFile:PLIST_FILENAME];
    NSString *imagePath = (NSString *)[settings objectForKey:IMAGELOCATION];
    if([imagePath isEqualToString: @""]) return nil;
    else return imagePath;
}

%new
- (UIImage *)getImage
{
  NSString *imagePath = [self getImagePath];
  if(imagePath != nil)
  { 
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if(image != nil) return image;
  }
  return nil;
}

%new
- (BOOL)addImageToView:(UIView *)screenShotView
{
  UIImage *image = [self getImage];
  if(image != nil)
  {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = screenShotView.bounds;
    if([self isSizeToFit]) imageView.contentMode = UIViewContentModeScaleAspectFit;
    [screenShotView addSubview: imageView];
    return YES;
  }
  return NO;
}


%new
- (void)createWindow
{

  content = [[%c(HualosUIWindow) alloc] initWithFrame: [[%c(UIScreen) mainScreen] bounds]];
  content.hidden = NO;
  [content _setSecure: YES];
  content.windowLevel = UIWindowLevelAlert + 1.0;
}

%new
- (void)destroyWindow
{
  content.hidden = YES;
  content = nil;
  //[content release];
}


%new
- (void)animateScreen:(UIView *)screenShotView
{
  if([[self getAnimation] isEqualToString:RIPPLE]) [self rippleEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:CHECKERBOARD]) [self checkerBoardEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:TRIFORCE]) [self triforceEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:SHRINK]) [self shrinkFadeEffect: screenShotView fromDirection: [self getDirection]];
  else if([[self getAnimation] isEqualToString:EXPAND]) [self expandFadeEffect: screenShotView fromDirection: [self getDirection]];
  else if([[self getAnimation] isEqualToString:FLASHANDREVERSE]) [self flashAndReverseEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:DOUBLECOLORFLASH]) [self doubleRandomColorFadeEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:STAROFDAVID]) [self starOfDavidEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:CROSS]) [self crossEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:OTTOMAN]) [self ottomanEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:AMERICANFLAG]) [self americanFlagEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:YINYANG]) [self yinyangEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:SUNBURST]) [self sunburstEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:SHATTER]) [self shatterEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:VERTICALFLIP]) [self verticalflipEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:HORIZONTALFLIP]) [self horizontalflipEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:DANCE]) [self danceEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:DISMISS]) [self dismissEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:FALL]) [self fallEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:KHANDA]) [self khandaEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:LIKE]) [self likeEffect: screenShotView];
  else if([[self getAnimation] isEqualToString:ACEOFSPADES]) [self aceOfSpadesEffect: screenShotView];

  else [self originalEffect: screenShotView];
}



// ANIMATIONS

%new
- (void)shrinkFadeEffect:(UIView *)screenShotView fromDirection:(NSString *)direction 
{
  CGRect shrinkRect = [self newRect:(screenShotView.frame) withDirection:(direction)];
  if([self addImageToView: screenShotView]) screenShotView.backgroundColor = [UIColor clearColor];
  [UIView animateWithDuration:1.0
                     delay:0.0
                   options: UIViewAnimationOptionAllowUserInteraction
                animations:^{
                          screenShotView.alpha = 0.0;
                          if(screenShotView.subviews.count != 0) screenShotView.subviews[0].frame = shrinkRect;
                          else screenShotView.frame = shrinkRect;
                } 
                completion:^(BOOL finished) {
                  if(finished){
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                  }
                }
  ];
}

%new
- (void)expandFadeEffect:(UIView *)screenShotView fromDirection:(NSString *)direction 
{
    if([self addImageToView: screenShotView])
    {
      screenShotView.backgroundColor = [UIColor clearColor];
      screenShotView.subviews[0].frame = [self newRect:(screenShotView.frame) withDirection:(direction)];
    } 
    else screenShotView.frame = [self newRect:(screenShotView.frame) withDirection:(direction)];
    screenShotView.alpha = 0.0;
    [UIView animateWithDuration:1.0 
                          delay:0.0 
                        options:UIViewAnimationOptionAllowUserInteraction  
                      animations:^{
                        screenShotView.alpha = 0.75;
                          if(screenShotView.subviews.count != 0) screenShotView.subviews[0].frame = [[[[%c(UIApplication) sharedApplication] windows] lastObject] frame];
                          else screenShotView.frame =  [[[[%c(UIApplication) sharedApplication] windows] lastObject] frame];
                      } 
                      completion:^(BOOL finished) {
                              if(finished){
                                [screenShotView removeFromSuperview];
                                //[screenShotView release];
                                [self destroyWindow];
                              }
            }];
}

%new
- (void)rippleEffect:(UIView *)screenShotView
{
    CGFloat radius = screenShotView.frame.size.width/2.0;
    UIView *ripple = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, radius, radius)];
    ripple.layer.cornerRadius = radius * 0.5;
    ripple.backgroundColor = [self getSecondaryColor];
    ripple.alpha = 1.0;
    [screenShotView insertSubview:ripple atIndex:0];
    ripple.center = screenShotView.center;
    CGFloat scale = 8.0;
    [UIView animateWithDuration:1.0 
                          delay:0.0 
                          options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut 
                          animations:^{
                              ripple.transform = CGAffineTransformMakeScale(scale, scale);
                              ripple.alpha = 0.0;
                              ripple.backgroundColor = [self randomColor];
                              screenShotView.alpha = 0.0;
                          } 
                          completion:^(BOOL finished) {
                          if(finished){
                            [ripple removeFromSuperview];
                            //[ripple release];
                            [screenShotView removeFromSuperview];
                            //[screenShotView release];
                            [self destroyWindow];
                          }
    }];
}

%new
- (void)triforceEffect:(UIView *)screenShotView
{
  screenShotView.backgroundColor = [UIColor clearColor];
  CGFloat side = screenShotView.frame.size.width/3.0;
  CGFloat midX = CGRectGetMidX(screenShotView.frame);
  CGFloat midY = CGRectGetMidY(screenShotView.frame);
  CGFloat maxX = CGRectGetMaxX(screenShotView.frame);
  CGFloat maxY = CGRectGetMaxY(screenShotView.frame);

  CGRect powerRect = CGRectMake(midX - side/2.0, 0 - side, side, side);
  CGRect courageRect = CGRectMake(0 - side, maxY + side, side, side);
  CGRect wisdomRect = CGRectMake(maxX, maxY + side, side, side);

  Triforce *power = [[Triforce alloc] initWithFrame:powerRect];
  Triforce *courage = [[Triforce alloc] initWithFrame:courageRect];
  Triforce *wisdom = [[Triforce alloc] initWithFrame:wisdomRect];

  UIColor *color = [self getPrimaryColor];
  power.triforceColor = color;
  courage.triforceColor = color;
  wisdom.triforceColor = color;

  [screenShotView addSubview: power];
  [screenShotView addSubview: courage];
  [screenShotView addSubview: wisdom];

    [UIView animateWithDuration:0.50 
            delay:0.0 
            options: UIViewAnimationOptionAllowUserInteraction
            animations:^{
                      power.transform = CGAffineTransformMakeRotation(M_PI);
                      courage.transform = CGAffineTransformMakeRotation(M_PI);
                      wisdom.transform = CGAffineTransformMakeRotation(M_PI);

                      power.frame = CGRectMake(midX - side/2.0, midY - (1.50*side), side, side);
                      courage.frame = CGRectMake(midX - side, midY - (side/2.0), side, side);
                      wisdom.frame = CGRectMake(midX, midY - (side/2.0), side, side);

            } 
            completion:^(BOOL finished) {
                    if(finished){
                      [UIView animateWithDuration:0.50
                              delay:0.0
                              options: UIViewAnimationOptionAllowUserInteraction
                              animations:^{
                                          power.frame = powerRect;
                                          courage.frame = courageRect;
                                          wisdom.frame = wisdomRect;
                              }
                              completion:^(BOOL finished){
                                //[power release];
                                //[courage release];
                                //[wisdom release];
                                [screenShotView removeFromSuperview];
                                //[screenShotView release];
                                [self destroyWindow];
                              }];
                    }
                    else 
                    {
                                //[power release];
                                //[courage release];
                                //[wisdom release];
                                [screenShotView removeFromSuperview];
                                //[screenShotView release];
                                [self destroyWindow];
                    }
            }];



}


%new
- (void)flashAndReverseEffect:(UIView *)screenShotView
{

  if([self addImageToView: screenShotView])
  {
    screenShotView.backgroundColor = [UIColor clearColor];
  }

  [UIView animateKeyframesWithDuration:0.5
                     delay:0.0
                   options: UIViewAnimationOptionAutoreverse | 
                            UIViewAnimationOptionAllowUserInteraction | 
                            UIViewAnimationCurveEaseInOut
                animations:^{
                          screenShotView.alpha = 0.0;
                } 
                completion:^(BOOL finished) {
                        if(finished){
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                        }
                }
  ];
}

%new
- (void)doubleRandomColorFadeEffect:(UIView *)screenShotView
{
  [UIView animateKeyframesWithDuration:1.0
                     delay:0.0
                   options: UIViewAnimationOptionAllowUserInteraction 
                animations:^{
                          screenShotView.alpha = 0.0;
                          screenShotView.backgroundColor = [self getSecondaryColor];
                } 
                completion:^(BOOL finished) {
                        if(finished){
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                        }
                }
  ];
}

%new
- (void)crossEffect:(UIView *)screenShotView
{
  Cross *cross = [[Cross alloc] initWithFrame: screenShotView.frame];
  cross.crossColor = [self getPrimaryColor];
  screenShotView.backgroundColor = [UIColor clearColor];
  [screenShotView addSubview: cross];
  [UIView animateWithDuration:1.0
                        delay:0.0
                      options:UIViewAnimationOptionAllowUserInteraction
                   animations:^{
                       cross.alpha = 0.0;
                   }
                   completion:^(BOOL finished) {
                        if(finished){
                          //[cross release];
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                        }
                   }];
}

%new
- (void)starOfDavidEffect:(UIView *)screenShotView
{
  screenShotView.backgroundColor = [UIColor clearColor];
  CGFloat starSide = screenShotView.frame.size.width*3.0/4.0;
  CGFloat xPosition = CGRectGetMidX(screenShotView.frame) - starSide/2.0;
  CGFloat yPosition = CGRectGetMidY(screenShotView.frame) - starSide/2.0;
  StarOfDavid *star = [[StarOfDavid alloc] initWithFrame: CGRectMake(xPosition, yPosition, starSide, starSide)];
  star.starColor = [self getPrimaryColor];
  [screenShotView addSubview: star];
  [UIView transitionWithView:star
                  duration:1.0
                    options: UIViewAnimationOptionAllowUserInteraction
                 animations:^{
                      star.transform = CGAffineTransformMakeScale(-2, 2);
                     star.alpha = 0.0;
                    } 
                  completion:^(BOOL finished) {
                        if(finished){
                          //[star release];
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                        }
                    }];
}

%new
- (void)ottomanEffect:(UIView *)screenShotView
{
  screenShotView.backgroundColor = [UIColor clearColor];
  CGFloat ottomanSide = screenShotView.frame.size.width*3.0/4.0;
  CGFloat xPosition = CGRectGetMidX(screenShotView.frame) - ottomanSide/2.0;
  CGFloat yPosition = CGRectGetMidY(screenShotView.frame) - ottomanSide/2.0;
  Ottoman *ottoman = [[Ottoman alloc] initWithFrame: CGRectMake(xPosition, yPosition, ottomanSide, ottomanSide)];
  ottoman.crescentColor = [self getPrimaryColor];
  ottoman.starColor = [self getSecondaryColor];
  [screenShotView addSubview: ottoman];
    [UIView transitionWithView:ottoman
                  duration:1.0
                    options: UIViewAnimationOptionAllowUserInteraction
                 animations:^{
                      ottoman.transform = CGAffineTransformMakeRotation(-M_PI*3.0/2.0);
                     ottoman.alpha = 0.0;
                    } 
                  completion:^(BOOL finished) {
                        if(finished){
                          //[ottoman release];
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                        }
                    }];
}

%new
- (void)checkerBoardEffect:(UIView *)screenShotView 
{
    CGFloat checkerWidth = screenShotView.frame.size.width/4.0;
    CGFloat checkerHeight = screenShotView.frame.size.height/8.0;
    UIColor *primaryColor = [self getPrimaryColor];
    UIColor *secondaryColor = [self getSecondaryColor];
    for(int col = 0; col < 8; col++)
    {
      for(int row = 0; row < 4; row++)
      {
         CGRect checkerRect = CGRectMake(row*checkerWidth, col*checkerHeight, checkerWidth, checkerHeight);
         UIView *checker = [[UIView alloc] initWithFrame: checkerRect];
          if([self addImageToView: checker]) checker.backgroundColor = [UIColor clearColor];
          else {
            if(row % 2 == 0 && col % 2 == 0)
            {
              checker.backgroundColor = primaryColor;
            } 
            else if (row % 2 == 0 && col % 2 == 1)
            {
              checker.backgroundColor = secondaryColor;
            }
            else if (row % 2 == 1 && col % 2 == 0)
            {
              checker.backgroundColor = secondaryColor;
            }
            else if (row % 2 == 1 && col % 2 == 1)
            {
              checker.backgroundColor = primaryColor;
            }
          }
         [screenShotView addSubview: checker];
      }
    }
    screenShotView.backgroundColor = [UIColor clearColor];
    [UIView transitionWithView:screenShotView
            duration:1.0
            options: UIViewAnimationOptionAllowUserInteraction
            animations:^{
                          screenShotView.alpha = 0.0;
                          for(UIView *subView in screenShotView.subviews)
                          {
                              if(subView.subviews.count != 0) {
                                  CGRect shrinkRect = [self newRect:(subView.subviews[0].frame) withDirection:CENTER];
                                  subView.subviews[0].frame = shrinkRect;
                              }
                              else {
                                CGRect shrinkRect = [self newRect:(subView.frame) withDirection:CENTER];
                                subView.frame = shrinkRect;
                              }
                          }
                } 
            completion:^(BOOL finished) {
                        if(finished){
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                        }
                }];
}

%new
- (void)americanFlagEffect:(UIView *)screenShotView
{
  screenShotView.backgroundColor = [UIColor clearColor];
  CGFloat stripeWidth = screenShotView.frame.size.width/13.0;
  CGFloat stripeHeight = screenShotView.frame.size.height;
  for(int i = 0; i < 13; i++)
  {
    UIView *stripe = [[UIView alloc] initWithFrame: CGRectMake(i * stripeWidth, 0, stripeWidth, stripeHeight)];
    if(i % 2 == 1) stripe.backgroundColor = [UIColor whiteColor];
    else stripe.backgroundColor = [UIColor redColor];
    stripe.alpha = 0.0;
    [screenShotView addSubview: stripe];
  }
  CGFloat starBannerWidth = 0.5385*screenShotView.frame.size.width;
  CGFloat starBannerHeight = 0.76*screenShotView.frame.size.width;
  UIView *starBanner = [[UIView alloc] initWithFrame: CGRectMake(CGRectGetMaxX(screenShotView.frame) - starBannerWidth, 0, starBannerWidth, starBannerHeight)];
  starBanner.backgroundColor = [UIColor blueColor];
  starBanner.alpha = 0.0;
  [screenShotView addSubview: starBanner];
  CGFloat starSide = starBannerWidth/9.0;
  CGFloat spaceInBetweenStars = starSide + (starSide/7.0);
  for(int row = 1; row < 10; row++)
  {
    CGFloat xPosition = screenShotView.frame.size.width - (row*starSide);
    CGFloat yPosition = 0;
    for(int col = 0; col < 6; col++)
    {
      if(row % 2 == 0)
      {
        if(col >= 5) break;
        if(col == 0) yPosition += spaceInBetweenStars;
      }
      Star *stateStar = [[Star alloc] initWithFrame:CGRectMake(xPosition, yPosition, starSide, starSide)];
      stateStar.alpha = 0;
      stateStar.transform = CGAffineTransformMakeRotation(M_PI_2);
      stateStar.starColor = [UIColor whiteColor];
      [screenShotView addSubview: stateStar];
      yPosition += 2.0*spaceInBetweenStars;
    }
  }


  [UIView animateWithDuration:0.50
                        delay:0.0
                      options:UIViewAnimationOptionAllowUserInteraction
                   animations:^{
                          for(UIView *subView in screenShotView.subviews)
                          {
                              if([subView isKindOfClass:[Star class]]) subView.transform =  CGAffineTransformMakeRotation(M_PI);
                               subView.alpha = 0.85;
                          }                   
                        }
                   completion:^(BOOL finished) {
                        if(finished){
                          [UIView animateWithDuration:0.50
                                  delay:0.0
                                  options:UIViewAnimationOptionAllowUserInteraction
                                  animations:^{
                                      for(UIView *subView in screenShotView.subviews)
                                      {
                                          if([subView isKindOfClass:[Star class]]) subView.transform =  CGAffineTransformMakeRotation(-M_PI_2);
                                           subView.alpha = 0.0;
                                      } 
                                  }
                                  completion:^(BOOL finished)
                                  {
                                    if(finished)
                                    {
                                      [screenShotView removeFromSuperview];
                                      //[screenShotView release];
                                      [self destroyWindow];
                                    }
                                  }
                          ];
                        }
                        else
                        {
                          [screenShotView removeFromSuperview];
                          //[screenShotView release];
                          [self destroyWindow];
                        }
                   }];
}

%new
- (void)yinyangEffect:(UIView *)screenShotView
{
  screenShotView.backgroundColor = [UIColor clearColor];
  UIColor *primaryColor = [self getPrimaryColor];
  UIColor *secondaryColor = [self getSecondaryColor];
  CGFloat yinyangRadius = screenShotView.bounds.size.width*2.0/3.0;
  CGFloat yinX = 0 - yinyangRadius;
  CGFloat yinY = CGRectGetMaxY(screenShotView.frame);
  CGFloat yangX = CGRectGetMaxX(screenShotView.frame);
  CGFloat yangY = 0 - yinyangRadius;
  YinYang *yin = [[YinYang alloc] initWithFrame:CGRectMake(yinX, yinY, yinyangRadius, yinyangRadius)];
  yin.yinColor = primaryColor;
  yin.yangColor = secondaryColor;
  YinYang *yang = [[YinYang alloc] initWithFrame:CGRectMake(yangX, yangY, yinyangRadius, yinyangRadius)];
  yang.yinColor = secondaryColor;
  yang.yangColor = primaryColor;
  yang.transform = CGAffineTransformMakeRotation(M_PI);
  yin.alpha = 0.85;
  yang.alpha = 0.85;
  [screenShotView addSubview: yin];
  [screenShotView addSubview: yang];

  CGFloat xCenter = CGRectGetMidX(screenShotView.frame) - yinyangRadius/2.0;
  CGFloat yCenter = CGRectGetMidY(screenShotView.frame) - yinyangRadius/2.0;

  [UIView animateWithDuration:0.25 
          delay:0.0 
          options: UIViewAnimationOptionAllowUserInteraction
          animations:^{
            yin.frame = CGRectMake(xCenter, yCenter, yinyangRadius, yinyangRadius);
            yang.frame = CGRectMake(xCenter, yCenter, yinyangRadius, yinyangRadius);
          }
          completion:^(BOOL finished){
            if(finished)
            {
                yin.yinColor = secondaryColor;
                yin.yangColor = primaryColor;
                yang.yinColor = primaryColor;
                yang.yangColor = secondaryColor;
                [yin setNeedsDisplay];
                [yang setNeedsDisplay];
                [UIView transitionWithView:yin duration:0.50
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    [yin.layer displayIfNeeded];
                                } completion:nil];
                [UIView transitionWithView:yang duration:0.5
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    [yang.layer displayIfNeeded];
                                } completion:^(BOOL finished) {
                                  if(finished)
                                  {
                                      [UIView animateWithDuration:0.25
                                              delay:0.0 
                                              options: UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  yin.transform = CGAffineTransformMakeRotation(M_PI_2);
                                                  yang.transform = CGAffineTransformMakeRotation(-M_PI_2);

                                                  yin.frame = CGRectMake(0 - yinyangRadius, 0 - yinyangRadius, yinyangRadius, yinyangRadius);
                                                  yang.frame = CGRectMake(CGRectGetMaxX(screenShotView.frame) + yinyangRadius, CGRectGetMaxY(screenShotView.frame) + yinyangRadius, yinyangRadius, yinyangRadius);
                                              }
                                              completion:^(BOOL finished)
                                              {
                                                  [screenShotView removeFromSuperview];
                                                  //[screenShotView release];
                                                  [self destroyWindow];
                                              }];
                                  } else {
                                      [screenShotView removeFromSuperview];
                                      //[screenShotView release];
                                      [self destroyWindow];
                                    }
                                }];
            } 
            else
            {
              [screenShotView removeFromSuperview];
              //[screenShotView release];
              [self destroyWindow];
            }
          }];
}

%new
- (void)sunburstEffect:(UIView *)screenShotView
{
  screenShotView.backgroundColor = [UIColor clearColor];
  Sunburst *sunburst = [[Sunburst alloc] initWithFrame: screenShotView.frame];
  sunburst.burstOneColor = [self getPrimaryColor];
  sunburst.burstTwoColor = [self getSecondaryColor];
  sunburst.originDirection = [self getDirection];
  [screenShotView addSubview: sunburst];

  [UIView animateWithDuration:1.0 
        delay:0.0 
        options: UIViewAnimationOptionAllowUserInteraction
        animations:^{
          sunburst.alpha = 0.0;
        }
        completion:^(BOOL finished){
              [screenShotView removeFromSuperview];
              //[screenShotView release];
              [self destroyWindow];
        }];
}

%new
- (void)shatterEffect:(UIView *)screenShotView
{
    screenShotView.backgroundColor = [UIColor clearColor];
    UIColor *primaryColor = [self getPrimaryColor];
    UIColor *secondaryColor = [self getSecondaryColor];
    int row = 4;
    int col = 4;
    CGFloat width = screenShotView.frame.size.width/row;
    CGFloat height = screenShotView.frame.size.height/col;
    NSMutableArray *glassBricks = [[NSMutableArray alloc] init];
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            CGRect rect = CGRectMake(j*width, i*height, width, height);
            UIView *glass = [[UIView alloc] initWithFrame:rect];
            CGFloat angle = ((j + i) % 2 ? 1 : -1) * (rand() % 5 / 10.0);
            glass.transform = CGAffineTransformMakeRotation(angle);
            if([self addImageToView: glass]) {
              NSLog(@"success!");
            }
            glass.layer.borderWidth = 0.5;
            glass.layer.borderColor = secondaryColor.CGColor;
            glass.layer.backgroundColor = primaryColor.CGColor;
            [screenShotView addSubview:glass];
            [glassBricks addObject:glass];
        }
    }
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:screenShotView];
    UIDynamicBehavior *behaviour = [[UIDynamicBehavior alloc] init];
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:glassBricks];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:glassBricks];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    
    [behaviour addChildBehavior:gravityBehaviour];
    [behaviour addChildBehavior:collisionBehavior];
    
    for (UIView *glass in glassBricks) {
        UIDynamicItemBehavior *itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[glass]];
        itemBehaviour.elasticity = (rand() % 5) / 8.0;
        itemBehaviour.density = (rand() % 5 / 3.0);
            itemBehaviour.allowsRotation = YES;
        [behaviour addChildBehavior:itemBehaviour];
    }
    
    [animator addBehavior:behaviour];
    

    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                                for (UIView *glass in glassBricks) {
                                    glass.alpha = 0.0;
                                }
                    }
                     completion:^(BOOL finished) {
                                for (UIView *glass in glassBricks) {
                                    [glass removeFromSuperview];
                                }
                                [glassBricks removeAllObjects];
                                [screenShotView removeFromSuperview];
                                //[screenShotView release];
                                [self destroyWindow];
                                animator = nil;
                                //[animator release];
                    }];
}

%new
- (void)horizontalflipEffect:(UIView *)screenShotView
{

  [self addImageToView: screenShotView];

  [UIView animateWithDuration:1.0
          delay:0.0
        options: UIViewAnimationOptionAllowUserInteraction
     animations:^{
          screenShotView.transform = CGAffineTransformMakeScale(1, -1);
          screenShotView.alpha = 0.0;
     }
     completion:^(BOOL finished) {
          [screenShotView removeFromSuperview];
          //[screenShotView release];
          [self destroyWindow];
  }];
}

%new
- (void)verticalflipEffect:(UIView *)screenShotView
{

  [self addImageToView: screenShotView];

  [UIView animateWithDuration:1.0
          delay:0.0
        options: UIViewAnimationOptionAllowUserInteraction
     animations:^{
          screenShotView.transform = CGAffineTransformMakeScale(-1, 1);
          screenShotView.alpha = 0.0;
     }
     completion:^(BOOL finished) {
          [screenShotView removeFromSuperview];
          //[screenShotView release];
          [self destroyWindow];
  }];
}

%new
- (void)danceEffect:(UIView *)screenShotView
{

  [self addImageToView: screenShotView];

  [UIView animateWithDuration:1.0
          delay:0.0
        options: UIViewAnimationOptionAllowUserInteraction
     animations:^{
          screenShotView.transform = CGAffineTransformMakeScale(-1, -1);
          screenShotView.transform = CGAffineTransformMakeScale(-1, 1);
          screenShotView.alpha = 0.0;
     }
     completion:^(BOOL finished) {
          [screenShotView removeFromSuperview];
          //[screenShotView release];
          [self destroyWindow];
  }];
}

%new
- (void)dismissEffect:(UIView *)screenShotView
{

    CGFloat shrinkWidth = screenShotView.frame.size.width/4.0;
    CGFloat shrinkHeight = screenShotView.frame.size.height/4.0;
    CGFloat xPostion = CGRectGetMidX(screenShotView.frame) - shrinkWidth/2.0;
    CGFloat yPostion = CGRectGetMidY(screenShotView.frame) - shrinkHeight/2.0;
    CGRect shrinkRect = CGRectMake(xPostion, yPostion, shrinkWidth, shrinkHeight);
    CGFloat finalYPosition = CGRectGetMaxY(screenShotView.frame);
    CGRect finalRect = CGRectMake(xPostion, finalYPosition, shrinkWidth, shrinkHeight);

     if([self addImageToView: screenShotView])
    {
      screenShotView.backgroundColor = [UIColor clearColor];
    }
    
     [UIView animateWithDuration:0.5
                           delay:0.0
                         options: UIViewAnimationOptionAllowUserInteraction
                      animations:^{
                            if(screenShotView.subviews.count != 0){
                              screenShotView.subviews[0].frame = shrinkRect;
                            } 
                            else screenShotView.frame = shrinkRect;
                            screenShotView.alpha = 0.5;
                      } completion:^(BOOL finished) {
                          [UIView animateWithDuration:0.4
                                                delay:0.1
                                              options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn
                                           animations:^{
                                              if(screenShotView.subviews.count != 0){
                                                screenShotView.subviews[0].frame = finalRect;
                                              } 
                                              else screenShotView.frame = finalRect;
                                              screenShotView.alpha = 0.0;
                                           }
                                           completion:^(BOOL finished) {
                                               [screenShotView removeFromSuperview];
                                                [self destroyWindow];
                                           }];
                      }];
}

%new 
- (void)fallEffect:(UIView *)screenShotView
{
    screenShotView.layer.anchorPoint = CGPointMake(0.0, 0.0);
    screenShotView.layer.position = CGPointMake(0.0, 0);
    
    [self addImageToView: screenShotView];

        [UIView animateWithDuration:0.50
                              delay:0.0
             usingSpringWithDamping:0.30
              initialSpringVelocity:2.0
                            options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                                        screenShotView.transform = CGAffineTransformMakeRotation(M_PI / 6.0);
                                        screenShotView.alpha = 0.5;
                         }
                         completion:nil];
    
    [UIView animateWithDuration:0.40
                          delay:0.10
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                                CGPoint center = screenShotView.superview.center;
                                center.y = 2 * CGRectGetHeight(screenShotView.superview.bounds);
                                center.x -= 20;
                                screenShotView.center = center;
                                screenShotView.alpha = 0.0;
                            }
                     completion:^(BOOL finished) {
                        [screenShotView removeFromSuperview];
                        [self destroyWindow];
    }];
    
}

%new
- (void)khandaEffect:(UIView *)screenShotView
{
    screenShotView.backgroundColor = [UIColor clearColor];
    UILabel *khanda = [[UILabel alloc] initWithFrame: screenShotView.frame];
    khanda.textAlignment = NSTextAlignmentCenter;
    khanda.font = [UIFont systemFontOfSize: khanda.frame.size.width];
    khanda.text = @"☬";
    khanda.textColor = [self getPrimaryColor];
    [screenShotView addSubview:khanda];

    [UIView transitionWithView:khanda
                  duration:1.0
                   options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowUserInteraction
                animations:^{
                    khanda.transform = CGAffineTransformMakeScale(-1, 1);
                    khanda.alpha = 0.0;
                }
                completion:^(BOOL finished) {
                    [khanda removeFromSuperview];
                    [screenShotView removeFromSuperview];
                    [self destroyWindow];
                }];
}

%new
- (void)likeEffect:(UIView *)screenShotView
{
    screenShotView.backgroundColor = [UIColor clearColor];
    UILabel *heart = [[UILabel alloc] initWithFrame: screenShotView.frame];
    heart.textAlignment = NSTextAlignmentCenter;
    heart.font = [UIFont systemFontOfSize: heart.frame.size.width];
    heart.text = @"♡";
    heart.textColor = [self getPrimaryColor];
    [screenShotView addSubview:heart];

    [UIView transitionWithView:heart
                  duration:1.0
                   options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowUserInteraction
                animations:^{
                    heart.alpha = 0.0;
                }
                completion:^(BOOL finished) {
                    [heart removeFromSuperview];
                    [screenShotView removeFromSuperview];
                    [self destroyWindow];
                }];
}

%new
- (void)aceOfSpadesEffect:(UIView *)screenShotView
{
    UIColor *primaryColor = [self getPrimaryColor];
    UIColor *secondaryColor = [self getSecondaryColor];

    screenShotView.backgroundColor = [UIColor clearColor];
    UILabel *spade = [[UILabel alloc] initWithFrame: screenShotView.frame];
    spade.textAlignment = NSTextAlignmentCenter;
    spade.font = [UIFont systemFontOfSize: spade.frame.size.width];
    spade.text = @"♤";
    spade.textColor = primaryColor;
    [screenShotView addSubview:spade];

    UILabel *smallSpade = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenShotView.frame.size.width/6.0, screenShotView.frame.size.height/4.0)];
    smallSpade.numberOfLines = 0;
    smallSpade.textAlignment = NSTextAlignmentCenter;
    smallSpade.lineBreakMode = NSLineBreakByWordWrapping;
    smallSpade.font = [UIFont systemFontOfSize: smallSpade.frame.size.width];
    smallSpade.text = [NSString stringWithFormat:@"A\n♤"];
    smallSpade.textColor = secondaryColor;
    [screenShotView addSubview:smallSpade];

    CGFloat xPostion = CGRectGetMaxX(screenShotView.frame) - screenShotView.frame.size.width/6.0;
    CGFloat yPosition = CGRectGetMaxY(screenShotView.frame) - screenShotView.frame.size.height/4.0;
    UILabel *smallSpadeTwo = [[UILabel alloc] initWithFrame:CGRectMake(xPostion, yPosition, screenShotView.frame.size.width/6, screenShotView.frame.size.height/4.0)];
    smallSpadeTwo.numberOfLines = 0;
    smallSpadeTwo.textAlignment = NSTextAlignmentCenter;
    smallSpadeTwo.lineBreakMode = NSLineBreakByWordWrapping;
    smallSpadeTwo.font = [UIFont systemFontOfSize: smallSpadeTwo.frame.size.width];
    smallSpadeTwo.text = [NSString stringWithFormat:@"A\n♤"];
    smallSpadeTwo.textColor = secondaryColor;
    smallSpadeTwo.transform = CGAffineTransformMakeScale(1, -1);
    [screenShotView addSubview:smallSpadeTwo];

    [UIView transitionWithView:spade
                  duration:1.0
                   options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowUserInteraction
                animations:^{
                    spade.alpha = 0.0;
                    smallSpade.alpha = 0.0;
                    smallSpadeTwo.alpha = 0.0;
                }
                completion:^(BOOL finished) {
                    [spade removeFromSuperview];
                    [smallSpade removeFromSuperview];
                    [smallSpadeTwo removeFromSuperview];
                    [screenShotView removeFromSuperview];
                    [self destroyWindow];
                }];
}

%new
- (void)originalEffect:(UIView *)screenShotView
{

    [self addImageToView: screenShotView];

    [UIView animateWithDuration:1.0
          delay:0.0
        options: UIViewAnimationOptionAllowUserInteraction
     animations:^{
          screenShotView.alpha = 0.0;
     }
     completion:^(BOOL finished) {
          [screenShotView removeFromSuperview];
          //[screenShotView release];
          [self destroyWindow];
  }];
}

- (void)flashColor:(id)arg1 withCompletion:(id)arg2 
{
        if([self isEnabled])
        {
            if(!content) 
            {
                [self createWindow];
                UIView *screenShotView = [[UIView alloc] initWithFrame: content.frame]; //get screenshot view
                screenShotView.backgroundColor = [self getPrimaryColor]; //assign color to screenshot view (get this from preference bundle)
                [content addSubview: screenShotView];
                [self animateScreen: screenShotView]; //animate screenshot view (get this from preference bundle)
            } 
        } 
        else 
        {
          %orig;
        }
}


%end