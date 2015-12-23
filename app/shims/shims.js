if(navigator.isIE8orLess){
	document.createElement('header');
	document.createElement('article');
	document.createElement('section');
	document.createElement('aside');
	document.createElement('nav');
	document.createElement('footer');
	document.createElement('alert');
	document.createElement('select2');
	document.createElement('flot');
	document.createElement('wave-spinner');
	document.createElement('wave:spinner');
}

if(navigator.isIE){
	// Fix for IE ignoring relative base tags.
	(function() {
		var baseTag = document.getElementsByTagName('base')[0];
		baseTag.href = baseTag.href;
	})();
}