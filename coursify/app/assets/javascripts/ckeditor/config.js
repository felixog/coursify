CKEDITOR.editorConfig = function( config ) {
       config.toolbar = 'Lessonbody';
       config.extraAllowedContent = 'div(*)';
       config.forceEnterMode = true;
       

};

CKEDITOR.config.toolbar_Lessonbody = [
	   ['Source'], ["NumberedList", "BulletedList","Blockquote", "JustifyLeft", "JustifyCenter" , "JustifyRight" ,"JustifyBlock"],
	   ["TextColor"],	  
	   ["Bold", "Italic", "Underline", "Strike", "Subscript", "Superscript", "RemoveFormat"],       
	   {name: 'insert', items : [ 'Image', 'Iframe' ] }
] ;

