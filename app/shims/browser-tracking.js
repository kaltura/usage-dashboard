//firefox
if(navigator.userAgent.toLowerCase().indexOf('firefox') > -1){
	navigator.isFF = true;
	
	HTMLElement.prototype.click = function() {
		var evt = this.ownerDocument.createEvent('MouseEvents');
		evt.initMouseEvent('click', true, true, this.ownerDocument.defaultView, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
		this.dispatchEvent(evt);
	}

}

//ie
var detectIEregexp;
if (navigator.userAgent.indexOf('MSIE') != -1)
	detectIEregexp = /MSIE (\d+\.\d+);/ //test for MSIE x.x
else // if no "MSIE" string in userAgent
	detectIEregexp = /Trident.*rv[ :]*(\d+\.\d+)/ //test for rv:x.x or rv x.x where Trident string exists

if (detectIEregexp.test(navigator.userAgent)){ //if some form of IE
	var ieversion=new Number(RegExp.$1) // capture x.x portion and store as a number
	document.body.className += ' ie ie-'+ieversion;
}