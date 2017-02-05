$( ".noDecoration" ).click(function() {
     $( this ).toggleClass( "activeCol" );
     $( this ).find( ".glyphicon" ).toggleClass( "glyphicon-plus" );
     $( this ).find( ".glyphicon" ).toggleClass( "glyphicon-minus" );

 });