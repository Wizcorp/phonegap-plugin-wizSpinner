package jp.wizcorp.phonegap.plugin.WizSpinner;

import org.json.JSONArray;
import org.json.JSONException;

import android.util.Log;

import org.apache.cordova.api.CallbackContext;
import org.apache.cordova.api.CordovaPlugin;

/**
 * 
 * @author WizCorp Inc. [ Incorporated Wizards ] 
 * @copyright 2013
 * @file WizSpinnerPlugin for Cordova
 * @about Handle JavaScript API calls from PhoneGap to WizSpinner
 *
 */
public class WizSpinnerPlugin extends CordovaPlugin {

	private String TAG = "WizSpinnerPlugin";

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		if (action.equals("create")) {
			// create spinner with options
			// Not supported in Android
			callbackContext.success();
			return true;
		} else if (action.equals("show")) {
			// Show spinner with options
			Log.i(TAG, "[SHOW SPINNER] ******* ");
			WizSpinner.show(cordova.getActivity(), args);
			callbackContext.success();
			return true;
		} else if (action.equals("hide")) {
			// Hide spinner with options
			Log.i(TAG, "[HIDE SPINNER] ******* ");
			WizSpinner.hide(cordova.getActivity());
			callbackContext.success();
			return true;
		} 
		
		return false;
	}
	
}
