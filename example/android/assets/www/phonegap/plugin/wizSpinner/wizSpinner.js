/* Spinner/Loader Cordova Plugin - JavaScript side of the bridge to iOS
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file JavaScript wizSpinner for Cordova
 *
 */

/*
 
 ============= example code ====================
 
 function shouldRotateToOrientation (orientation)
 {
 if (deviceIsReady == true) {
 switch (orientation) {
 case 0:
 // portrait normal
 window.wizSpinner.rotate(1);
 return true;
 break;
 case 90:
 // landscape left
 window.wizSpinner.rotate(3);
 return true;
 break;
 case -90:
 // landscape right
 window.wizSpinner.rotate(4);
 return true;
 break;
 case 180:
 // portrait upside down
 return false;
 break
 }
 }
 }
 
 
 function onDeviceReady()
 {
 deviceIsReady = true;
 }
 */

var wizSpinner = {
    
	create: function(options, s, f) {
	    
	    return cordova.exec(s, f, 'wizSpinnerPlugin', 'create', [options]);
	    
	},

    
	show: function(options) {
	    
	    if(typeof(options) == "undefined") {
	        
	        return cordova.exec(null, null, 'wizSpinnerPlugin', 'show', []);
	    } else {
	        return cordova.exec(null, null, 'wizSpinnerPlugin', 'show', [options]);
	    }
	    
	    
	},
	    
	hide: function() {
	    
	    return cordova.exec(null, null, 'wizSpinnerPlugin', 'hide', []);
	    
	},
	    
	rotate: function(orientation) {
	    cordova.exec(null, null, 'wizSpinnerPlugin', 'rotate', [orientation]);
	}
    
    
};