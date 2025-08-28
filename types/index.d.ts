interface ICdvEventWindowFocusChanged {
    eventName: 'android_onWindowFocusChanged';
    hasFocus: boolean;
}

interface ICdvEventAppWillResignActive {
    eventName: 'iOS_appWillResignActive';
}

interface ICdvEventAppWillEnterForeground {
    eventName: 'iOS_appWillEnterForeground';
}

interface ICdvEventAppWillTerminate {
    eventName: 'iOS_appWillTerminate';
}

interface ICdvEventAppDidBecomeActive {
    eventName: 'iOS_appDidBecomeActive';
}

interface ICdvEventAppDidEnterBackground {
    eventName: 'iOS_appDidEnterBackground';
}

type CdvExtraEvent = ICdvEventWindowFocusChanged
    | ICdvEventAppWillResignActive
    | ICdvEventAppWillEnterForeground
    | ICdvEventAppWillTerminate
    | ICdvEventAppDidBecomeActive
    | ICdvEventAppDidEnterBackground;

interface Window {
    plugins: {
        ExtraEvents: {
            registerForEvents: (listener: (event: CdvExtraEvent) => void,
                                error?: (err: any) => void
                ) => (() => void);
        }
    }
}
