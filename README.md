# cordova-plugin-lifecycle-events-extra

Cordova Plugin for Extra App Lifecycle Events, including Terminate and Destroy.

Based heavily on:

* https://github.com/88dots/cordova-plugin-memory-warning
* https://github.com/agamemnus/cordova-plugin-ondestroy

Similar plugins which may better meet one's requirements include:

* https://github.com/katzer/cordova-plugin-app-event
* https://github.com/bsorrentino/cordova-broadcaster

## Installation

`cordova plugin add cordova-plugin-lifecycle-events-extra`

Warning! You should not call any interactive Javascript in the event handler!
This includes `alert()` and any other interaction with the user. Ensure that
your handler is "headless".

In your JS event handler, you should strong consider wrapping your JS code in setTimeout.
Otherwise, AJAX calls, for example, will not work.

## Included Additional Lifecycle Events

* willterminate = (UIApplicationWillTerminateNotification)[]
* didlaunch = (UIApplicationDidFinishLaunchingNotification)[https://developer.apple.com/documentation/uikit/uiapplicationdidfinishlaunchingnotification?language=objc]

## Usage

Only after the `deviceready` event has fired, add these event listeners within the deviceready handler's function body:

### iOS

Warning! iOS does not broadcast any event upon termination when the app is already in the background!

```javascript
 document.addEventListener("deviceready", function (event1) {

	 document.addEventListener('willterminate', function (event2) {
		/* iOS cordova quirk */
	    setTimeout(function() {
		    console.log('terminate event has fired.');
	        // more JS here!
	   }, 0);
	});

 }, false);
```

### Android

```javascript
document.addEventListener('destroy', function () {
    // your JS code here!
});
```

## Browser Platform

Just register a beforeunload event on the body:

```javascript
window.addEventListener("beforeunload", function (event) {
  event.preventDefault();

  myUnloadFunction("erase all the things!");

  return '';
});
```
