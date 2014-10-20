/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComSencloudDocumentModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

#import "TiApp.h"

@interface ComSencloudDocumentModule ()<UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) UIDocumentInteractionController* fileInteractionController;

@end

@implementation ComSencloudDocumentModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"b80559df-97c9-491b-a2dc-11a9c43529eb";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.sencloud.document";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

-(void)openurl:(id)args
{
//    NSLog(@"args---------------:%@",args);
 
    ENSURE_SINGLE_ARG(args, NSString);
    
    NSString* path = (NSString*)args;

    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        if (self.fileInteractionController == nil) {
            self.fileInteractionController = [[UIDocumentInteractionController interactionControllerWithURL:fileURL] retain];
            
//            self.fileInteractionController.delegate = self;
            
        } else {
            
            self.fileInteractionController.URL = fileURL;
            
        }
        
        UIViewController* controller =  [self topViewController]; /*[UIApplication sharedApplication].keyWindow.rootViewController;*/
        
        if ([TiUtils isIOS7OrGreater]) {
            [self.fileInteractionController presentOptionsMenuFromRect:controller.view.frame inView:controller.view animated:YES];
        } else {
            self.fileInteractionController.delegate = self;
            [self.fileInteractionController presentPreviewAnimated:YES];
        }
    }
}

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

//- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller canPerformAction:(SEL)action
//{
//    return false;
//}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return [TiApp app].window.rootViewController;
}

@end
