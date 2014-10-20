var document = require('com.sencloud.document');
function doClick(e) {
	
    // alert($.label.text);
    
    Ti.API.info(Ti.Filesystem.getResourcesDirectory() + "a.docx");
    
    var file = Ti.Filesystem.getFile(Ti.Filesystem.getResourcesDirectory() + "a.docx");
    
    if (file.exists()) {
   	 	document.openurl(file.resolve());
    }
    
    
}

$.index.open();
