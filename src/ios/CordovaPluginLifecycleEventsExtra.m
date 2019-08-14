#import <Cordova/CDV.h>
#import "CordovaPluginLifecycleEventsExtra.h"

@implementation CordovaPluginLifecycleEventsExtra

- (void) pluginInitialize {
    NSLog(@"[CordovaPluginLifecycleEventsExtra] Plugin is registered.");

	// The Notification may have already posted by the time this plugin is initialized?
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppLaunch:) name:UIApplicationDidFinishLaunchingNotification object:nil];

	NSLog(@"[CordovaPluginLifecycleEventsExtra] Registered an Observer for onAppLaunch.");
}

/**
 * CDVPlugin already adds an observer for this iOS event. Overriding it here is all that's needed.
 */
- (void) onMemoryWarning {
	NSLog(@"[CordovaPluginLifecycleEventsExtra] App is low on Memory.");

	[self.commandDelegate evalJs:@"cordova.fireDocumentEvent('lowmemory', null, true);" scheduledOnRunLoop:YES];
		// cordova.fireDocumentEvent('event', null, true); <-- needs the two extra parameters to signal fireDocumentEvent to NOT use setTimeout(..., 0).

	[super onMemoryWarning]; // it does nothing in CDVPlugin.m but for the future...
}

/**
 * Override method for onAppTerminate provided in CDVPlugin.h
 */
- (void) onAppTerminate {
	NSLog(@"[CordovaPluginLifecycleEventsExtra] App is terminating.");

	//  - (void)evalJs:(NSString*)js scheduledOnRunLoop:(BOOL)scheduledOnRunLoop;
	// "Can be used to evaluate JS right away instead of scheduling it on the run-loop.
	// This is required for dispatch resign and pause events, but should not be used
	// without reason. Without the run-loop delay, alerts used in JS callbacks may result
	// in dead-lock. This method must be called from the UI thread."
	[self.commandDelegate evalJs:@"cordova.fireDocumentEvent('willterminate', null, true);" scheduledOnRunLoop:NO];
		// cordova.fireDocumentEvent('event', null, true); <-- needs the two extra parameters to signal fireDocumentEvent to NOT use setTimeout(..., 0).

	[super onAppTerminate]; // it does nothing in CDVPlugin.m but for the future...
}

/**
 * this corresponds to a cold start of the app and should run before cordova's deviceready event.
 *
 * I'm not quite sure any JS could listen for this event if it fires before deviceready...
 */
- (void) onAppLaunch: (NSNotification *) notification {
	NSLog(@"[CordovaPluginLifecycleEventsExtra] App did Launch");
	NSLog(@"%@", [notification description]);
	NSLog(@"%@", [notification debugDescription]);
		// launch from shortcut will likely be shown by UIApplicationLaunchOptionsShortcutItemKey in the notification NSDictionary
		// if (notification[UIApplicationLaunchOptionsShortcutItemKey]) {}  although that bracket syntax may be only for Swift

	// read info from the notification
	// or
	// NSString* apiKey = [self.commandDelegate.settings objectForKey:[@"apiKey" lowercaseString]];

	[self.commandDelegate evalJs:@"cordova.fireDocumentEvent('didlaunch', null, true);" scheduledOnRunLoop:NO];
}

@end
