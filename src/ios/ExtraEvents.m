#import "ExtraEvents.h"

@implementation ExtraEvents {
    bool hasRegisteredForEvents;
    NSString* eventCallbackId;
}

- (void)pluginInitialize
{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onWillResignActive:)    name:UIApplicationWillResignActiveNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onWillTerminate:)       name:UIApplicationWillTerminateNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onDidBecomeActive:)     name:UIApplicationDidBecomeActiveNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onDidEnterBackground:)  name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)registerForEvents:(CDVInvokedUrlCommand*)command
{
    @try {
        hasRegisteredForEvents = true;
        eventCallbackId = command.callbackId;

        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        [result setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } @catch (NSException *exception) {
        [self onErrorWithMethodName:@"registerForEvents" exception:exception callbackId:command.callbackId];
   }
}

// ----------------------------------------------------
//                  Event Methods
// ----------------------------------------------------
- (void)onWillResignActive:(NSNotification*)notification
{
    NSLog(@"ExtraEvents: appWillResignActive");

    if (hasRegisteredForEvents) {
        NSMutableDictionary* props = [NSMutableDictionary dictionaryWithCapacity:1];
        props[@"eventName"] = @"iOS_appWillResignActive";

        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:props];
        [result setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:result callbackId:eventCallbackId];
        return;
    }
}

- (void)onWillEnterForeground:(NSNotification*)notification
{
    NSLog(@"ExtraEvents: appWillEnterForeground");

    if (hasRegisteredForEvents) {
        NSMutableDictionary* props = [NSMutableDictionary dictionaryWithCapacity:1];
        props[@"eventName"] = @"iOS_appWillEnterForeground";

        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:props];
        [result setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:result callbackId:eventCallbackId];
        return;
    }
}

- (void)onDidBecomeActive:(NSNotification*)notification
{
    NSLog(@"ExtraEvents: appDidBecomeActive");

    if (hasRegisteredForEvents) {
        NSMutableDictionary* props = [NSMutableDictionary dictionaryWithCapacity:1];
        props[@"eventName"] = @"iOS_appDidBecomeActive";

        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:props];
        [result setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:result callbackId:eventCallbackId];
        return;
    }
}

- (void)onDidEnterBackground:(NSNotification*)notification
{
    NSLog(@"ExtraEvents: appDidEnterBackground");

    if (hasRegisteredForEvents) {
        NSMutableDictionary* props = [NSMutableDictionary dictionaryWithCapacity:1];
        props[@"eventName"] = @"iOS_appDidEnterBackground";

        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:props];
        [result setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:result callbackId:eventCallbackId];
        return;
    }
}

- (void)onWillTerminate:(NSNotification*)notification
{
    NSLog(@"ExtraEvents: appWillTerminate");

    if (hasRegisteredForEvents) {
        NSMutableDictionary* props = [NSMutableDictionary dictionaryWithCapacity:1];
        props[@"eventName"] = @"iOS_appWillTerminate";

        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:props];
        [result setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:result callbackId:eventCallbackId];
        return;
    }
}

// ----------------------------------------------------
//                  Error Handling
// ----------------------------------------------------
- (void) onErrorWithMethodName:(NSString*)method
                     exception:(NSException*)e
                    callbackId:(NSString*)callbackId
{
    NSString* msg = [NSString stringWithFormat:@"%@ - %@", e.name, e.reason];
    [self onErrorWithMethodName:method msg:msg callbackId:callbackId];
}

- (void) onErrorWithMethodName:(NSString*)method
                           msg:(NSString*)msg
                    callbackId:(NSString*)callbackId
{
    NSString* err = [NSString stringWithFormat:@"ExtraEvents - %@ ERROR: %@", method, msg];
    NSLog(@"%@", err);

    if (callbackId) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:err];
        [result setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:result callbackId:callbackId];
    }
}

@end
