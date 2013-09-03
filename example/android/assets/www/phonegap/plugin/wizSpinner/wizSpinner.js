/* Spinner/Loader Cordova Plugin - JavaScript side of the bridge to iOS
 *
 * @author Ally Ogilvie
 * @copyright Wizcorp Inc. [ Incorporated Wizards ] 2013
 * @file wizSpinner.js
 *
 */

/*
============= Example rotation code ====================

function shouldRotateToOrientation (orientation) {
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
			break;
		}
	}
}

function onDeviceReady() {
	deviceIsReady = true;
}
*/


// For Cordova >= 3.0
(function (window) {

	// Object stringifier helper
	function propsToString(obj) {
		// stringify all vars
		for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                obj[i] = '' + obj[i];
            }
        }
    }
    
	// WizSpinner parent class
	function WizSpinner() {	};
	
	WizSpinner.prototype.throwError = function (cb, error) {
		if (cb) {
			cb(error);
		} else {
			throw error;
		}
	};
	
	WizViewManager.prototype.create = function (options) {
		propsToString(options);
		cordova.exec(win, fail, 'WizSpinnerPlugin', 'create', [options]);
	};
	
	WizViewManager.prototype.show = function (options) {
		propsToString(options);
		cordova.exec(null, null, 'WizSpinnerPlugin', 'show', [options]);
	};

	WizViewManager.prototype.hide = function (options) {
		propsToString(options);
		cordova.exec(null, null, 'WizSpinnerPlugin', 'hide', [options]);
	};
	
	WizViewManager.prototype.rotate = function (orientation) {
		cordova.exec(null, null, 'WizSpinnerPlugin', 'rotate', [orientation]);
	};
		
	// Instantiate the wizSpinner
	window.wizSpinner = new WizSpinner();
}(window));