package com.lisantra.lifecycle;

import org.apache.cordova.*;
import org.json.JSONArray;
// import org.json.JSONObject;
import org.json.JSONException;

// import android.app.Activity;
// import android.app.ActivityManager;
// import android.os.Build;
// import android.content.Context;
// import android.content.Intent;

public class CordovaPluginLifecycleEventsExtra extends CordovaPlugin {

    private static final String LOG_TAG = "CordovaPluginLifecycleEventsExtra";

	/**
	 * Not sure that this should even be here?
	 * @param cordova [description]
	 * @param webView [description]
	 */
    @Override
    protected void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
    }

  	/**
	  * Called after plugin construction and fields have been initialized.
	  */
	protected void pluginInitialize() {}

	/**
	 * [onDestroy description]
	 * @return [description]
	 */
	@Override
	public void onDestroy() {
		LOG.d(LOG_TAG, "onDestroy");
		this.webView.loadUrl("javascript:cordova.fireDocumentEvent(\'destroy\', null, true);");
			// = ios' willterminate

	    super.onDestroy();
	};
}
