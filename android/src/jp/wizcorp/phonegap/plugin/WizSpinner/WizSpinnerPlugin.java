package jp.wizcorp.phonegap.plugin.WizSpinner;

import org.json.JSONArray;

import android.util.Log;

import org.apache.cordova.api.Plugin;
import org.apache.cordova.api.PluginResult;
import org.apache.cordova.api.PluginResult.Status;

/**
 * 
 * @author WizCorp Inc. [ Incorporated Wizards ] 
 * @copyright 2012
 * @file WizSpinnerPlugin for Cordova
 * @about Handle JavaScript API calls from PhoneGap to WizNavi
 *
 */
public class WizSpinnerPlugin extends Plugin {

	/*
	 * 
	 * JavaScript Usage ->
	 * a is an array (send empty array if nothing to declare to SpinnerPlugin)
	 * s is success callback
	 * f is fail callback
	 * 
	 * var wizSpinner = { 
	 * 
	 * 		show: function(options) {
	 *			return cordova.exec( null, null, 'WizSpinnerPlugin', 'show', [options] );	
	 *		}
	 * 
	 * 
	 * }
	 * 
	 * 
	 * 
	 */
	

	
	@Override
	public PluginResult execute(String action, JSONArray data, String callbackId)  {
		
		PluginResult result = null;
		
		if (action.equals("create")) {
			// create spinner with options
			
			
		} else if (action.equals("show")) {
			
			// Show spinner with options
			Log.e("SpinnerPlugin", "[SHOW SPINNER] ******* ");
			WizSpinner.show(cordova.getActivity(), data);
			result = new PluginResult(Status.OK);
			
		} else if (action.equals("hide")) {

			// Hide spinner with options
			Log.e("SpinnerPlugin", "[HIDE SPINNER] ******* ");
			WizSpinner.hide(cordova.getActivity());
			result = new PluginResult(Status.OK);

		} 
		
		
		return result;
	}
	
}
