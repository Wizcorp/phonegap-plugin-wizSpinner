# PLUGIN: 

phonegap-plugin-wizSpinner<br />
phonegap version : 1.7<br />
last update : 19/06/2012<br />

<br />
![MLB](https://github.com/Wizcorp/phonegap-plugin-wizSpinner/raw/v1.7/screen.jpg)
<br />
# DESCRIPTION :

PhoneGap plugin for creating and manipulating native loader/spinner above Cordova.
<br />
NOTE - Android is portrait only
<br />
<br />
# EXAMPLE CODE : #
<br />
<br />
Show spinner<br />
<pre><code>
wizSpinner.show(JSONObject options);
Example option object;
{
"showSpinner": TRUE, [TRUE/FALSE - default : TRUE]
"position": "low", ["low", "middle" - default : "low"]
"spinnerColour": "white", ["white", "grey" - default : "white"]
"opacity": "0.0", [0.0/1.0 - default : 0.0]
"labelText": "Loading...", [default : "Loading..."]
"textColour": "white" ["white", "black" - default : "white"]
};
</code></pre>
<br />
<br />
Hide spinner<br />
<pre><code>
wizSpinner.hide(); 
</code></pre>
<br />
<br />
Rotate spinner<br />
This is handled by PhoneGap event listener, though you can force this if you wish.<br />
<pre><code>
wizSpinner.rotate(Int orientation);
</code></pre>
<br />
<br />
Add this code to manually configure orientations
<pre><code>
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
            break;
    }
    }
}


function onDeviceReady()
{
    deviceIsReady = true;
}
</code></pre>