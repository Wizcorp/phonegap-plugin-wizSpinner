# phonegap-plugin-wizSpinner 

- PhoneGap Version : 3.3

# Description

PhoneGap plugin for creating and manipulating native loader/spinner above Cordova.

*NOTE* - Android is portrait only, barebones (many iOS features yet to be implemented T-T)

# Install (iOS & Android with Plugman) 

	cordova plugin add https://github.com/Wizcorp/phonegap-plugin-wizSpinner

# Example Code

Example options for APIs
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

    customSpinnerPath	:	"http://google.gif" / "var/applications/local/file.gif" / "default" - 	default "default" (default spinner stored in bundle)
	customer spinner must be gif (currently). Can be loaded from URL. NOT cached.
	Required -> customerSpinner = true

   	width	:	100 - default is natural custom image size
	int in pixels of spinner width if rescaling a custom spinner

    height	:	150 - default is natural custom image size
	int in pixels of spinner height if rescaling a custom spinner

    spinLoops	:	0 - default is 0, which specifies to repeat the animation indefinitely.
	int specifying the number of times to repeat the animation of a custom spinner

    spinDuration	:	1.0 - default is equal to the number of images in the custom spinner 	multiplied by 1/30th of a second. Thus, if you had 30 images, the value would be 1 second.
	float indicating the time duration measured in seconds
</code></pre>

**Create spinner**

	wizSpinner.create(JSONObject options);

**Show spinner**

	wizSpinner.show(JSONObject options);

**Hide spinner**<br />
	
	wizSpinner.hide(); 

**Rotate spinner**

This is handled by PhoneGap event listener, though you can force this if you wish.

	wizSpinner.rotate(Int orientation);

Add this code to manually configure orientations
	
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
