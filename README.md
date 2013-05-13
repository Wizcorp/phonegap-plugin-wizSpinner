# PLUGIN: 

phonegap-plugin-wizSpinner<br />
phonegap version : 2.7<br />
last update : 13/05/2013<br />
<br />
![MLB](https://github.com/Wizcorp/phonegap-plugin-wizSpinner/raw/v1.7/screen.jpg)
<br />
# DESCRIPTION :

PhoneGap plugin for creating and manipulating native loader/spinner above Cordova.
<br />
NOTE - Android is portrait only, barebones (many iOS features yet to be implemented T-T)
<br />

# USAGE :

- For iOS, add the following frameworks:
	- ImageIO.framework

<br />
Options<br />
<pre><code>
    position	:	"low" / "middle" / "high" - default "middle"
	position of spinner.
            
    label	:	"my loading text" - default "loading..."
	text to show an empty string will not show any text.

    color	:	"#RGB" / "#ARGB" / "#RRGGBB" / "#AARRGGBB" / "transparent" - default #fff 
	hex colour string with the wrong spelling of colour.

    bgColor	:	"#RGB" / "#ARGB" / "#RRGGBB" / "#AARRGGBB" / "transparent" - default #fff  
	hex colour string with the wrong spelling of colour.

   	opacity	:	0.0 - default 0.4 
	float int between 0.0 and 1.0 for background black canvas

    spinnerColor	:	"white" / "grey" - default "white"
	Colour of Apple spinner if using Apple spinner

	showSpinner		: true / false - default true
	shows an Apple spinner

	customSpinner : true / false - default false
	Override Apple Spinner with a gif (use customSpinnerPath to provide custom path if not default in bundle is used)
	Required -> showSpinner = true

    customSpinnerPath	:	"http://google.gif" / "var/applications/local/file.gif" / "default" - default "default" (default spinner stored in bundle)
	customer spinner must be gif (currently). Can be loaded from URL. NOT cached.
	Required -> customerSpinner = true

   	width	:	100 - default is natural custom image size
	int in pixels of spinner width if rescaling a custom spinner

    height	:	150 - default is natural custom image size
	int in pixels of spinner height if rescaling a custom spinner

    spinLoops	:	0 - default is 0, which specifies to repeat the animation indefinitely.
	int specifying the number of times to repeat the animation of a custom spinner

    spinDuration	:	1.0 - default is equal to the number of images in the custom spinner multiplied by 1/30th of a second. Thus, if you had 30 images, the value would be 1 second.
	float indicating the time duration measured in seconds
</code></pre>
<br />
# EXAMPLE CODE : #
<br />
<br />
Create spinner<br />
<pre><code>
wizSpinner.create(JSONObject options);
</pre></code>
<br />
<br />
Show spinner<br />
<pre><code>
wizSpinner.show(JSONObject options);
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
