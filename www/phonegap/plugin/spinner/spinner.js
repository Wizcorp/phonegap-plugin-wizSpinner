/* Popup PhoneGap Plugin - JavaScript side of the bridge to StatBarPlugin.java
*
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2011
 * @file JavaScript StatBarPlugin for PhoneGap
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
            window.nativeSpinner.rotate(1);
            return true;
            break;
            
            case 90:
            // landscape left 
            window.nativeSpinner.rotate(3);
            return true;
            
            break;
            
            case -90:
            // landscape right
            window.nativeSpinner.rotate(4);
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

var nativeSpinner = { 
	
	
    create: function(s,f,a) {
        if(typeof(a) == "undefined") { 
			return PhoneGap.exec(s, f, 'SpinnerPlugin', 'create', []);
		} else {
			return PhoneGap.exec(s, f, 'SpinnerPlugin', 'create', [a]);
		}
        
    },
    
    show: function(s,f,a) {

        if(typeof(a) == "undefined") { 
            	
            return PhoneGap.exec(s, f, 'SpinnerPlugin', 'show', []);
		} else {
            return PhoneGap.exec(s, f, 'SpinnerPlugin', 'show', [a]);
        }
        

    },
    
    hide: function(s,f) {

        return PhoneGap.exec(null, null, 'SpinnerPlugin', 'hide', []);	
        
    },
    
    rotate: function(orientation) {
        PhoneGap.exec(null, null, 'SpinnerPlugin', 'rotate', [orientation]);
    }
	

};
