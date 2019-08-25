void setModalY( float y )
{
	Element @body = @window.document.body;

	Element @rel = @body.getElementById( 'modal-block-rel' );
	if( @rel == null ) {
		return;
	}

	rel.css( 'transform-origin-y', '-' + String( y * 100.0 ) + '%' );
}
