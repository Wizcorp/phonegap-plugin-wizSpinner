package jp.wizcorp.phonegap.plugin.WizSpinner;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.ProgressDialog;
import android.util.Log;



public class WizSpinner {
	
	private static ProgressDialog pd;
	public static boolean isVisible = false;


	public static void show(Activity activity, JSONArray data) {
		// create and show the spinner

		JSONObject dataObj = null;
		String text = "Loading...";
		try {
			dataObj = data.getJSONObject(0);
		} catch (JSONException e) {
			// failed to get any data
			dataObj = null;
		}
		if (dataObj != null ) {
			if ( dataObj.has("labelText")) {
				try {
					text = (String) dataObj.get("labelText");
				} catch (JSONException e) {
					// failed for some reason
				}
			}
		}

		final String labelText = text;
		final Activity _ctx = activity;
		
		if ( !isVisible ) {
			Log.i("wizSpinner", "[display spinner] ******* ");
			
			activity.runOnUiThread(
	            new Runnable() {
	                public void run() {
	                	pd = ProgressDialog.show(_ctx, null, labelText, true, false);
	                }
	            }
	        );
			
			isVisible = true;
		}
	}

	public static void hide(Activity activity) {
		// hide the spinner
		if ( isVisible ) {
			Log.i("wizSpinner", "[Hiding spinner] ******* ");
			
			activity.runOnUiThread(
	            new Runnable() {
	                public void run() {
	            		pd.dismiss();
	                }
	            }
	        );
			isVisible = false;
		}
	}

}
