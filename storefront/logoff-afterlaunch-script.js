CTXS.Extensions.postLaunch = function(app, status) {
    if (! CTXS.Device.isNativeClient()) {
        if (status == CTXS.LAUNCH_SUCCESS) {
            function logoff() {
                CTXS.Environment.logOff();
            }
            window.setTimeout(logoff, delayLogoffInSeconds * 1000);
        }
    }
};