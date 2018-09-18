#import <Cordova/CDV.h>
#import "CordovaPluginLifecycleEventsExtra.h"

@implementation CordovaPluginLifecycleEventsExtra

- (void)pluginInitialize {
    NSLog(@"[CordovaPluginLifecycleEventsExtra] Plugin is registered.");
}

/**
 * Override method for onAppTerminate provided in CDVPlugin.h
 */
- (void)onAppTerminate {

	//  - (void)evalJs:(NSString*)js scheduledOnRunLoop:(BOOL)scheduledOnRunLoop;
	// Can be used to evaluate JS right away instead of scheduling it on the run-loop.
	// This is required for dispatch resign and pause events, but should not be used
	// without reason. Without the run-loop delay, alerts used in JS callbacks may result
	// in dead-lock. This method must be called from the UI thread.
	[self.commandDelegate evalJs:@"cordova.fireDocumentEvent('willterminate', null, true);" scheduledOnRunLoop:NO];
		// cordova.fireDocumentEvent('event', null, true); <-- needs the two extra parameters to signal fireDocumentEvent to NOT use setTimeout(..., 0).
	NSLog(@"[CordovaPluginLifecycleEventsExtra] App is terminating.");
}

@end
