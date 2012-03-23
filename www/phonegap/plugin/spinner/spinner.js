/* Popup PhoneGap Plugin - JavaScript side of the bridge to StatBarPlugin.java
*
 * @author WizCorp Inc. [ Incorporated Wizards ] 
 * @copyright 2011
 * @file JavaScript StatBarPlugin for PhoneGap
 *
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
    }
	

};