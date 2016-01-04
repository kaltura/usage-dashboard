if(navigator.userAgent.toLowerCase().indexOf('firefox') > -1){
	navigator.isFF = true;
	
	HTMLElement.prototype.click = function() {
		var evt = this.ownerDocument.createEvent('MouseEvents');
		evt.initMouseEvent('click', true, true, this.ownerDocument.defaultView, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
		this.dispatchEvent(evt);
	}
}