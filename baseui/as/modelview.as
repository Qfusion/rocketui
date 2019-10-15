/*
Copyright (C) 2011 Cervesato Andrea ("koochi")

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

/* 
	This class provide to manage the model view properties.
 */
String basePath = 'models/players/';
String modelFile = 'tris.iqm';
String skinExt  = '.skin';

funcdef bool MVIEW_ANIM_CALLBACK(any &input);

class ModelView
{
	String modelId;
	String modelType;
	String modelSkin;
	float maxScale;
	
	ModelView( String modelId )
	{
		this.modelId = modelId;
		this.maxScale = 1.0;
	}
	
	void Initialize( Element @elem, const String &modelType, const String &skin  )
	{
		this.modelType = modelType;
		this.modelSkin = skin;
		
		// initialize model and skin
		SetModel( @elem, modelType );
		SetSkin( @elem, skin );
	}
	
	Element@ GetModel( Element @elem )
	{
		return elem.getElementById( modelId );
	}
	
	// refresh the view
	void Refresh( Element @elem )
	{
		SetModel( @elem, this.modelType );
		SetSkin( @elem, this.modelSkin );
	}
	
	// Set the model
	void SetModel( Element @elem, const String &modelType )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null && modelType.length() != 0  )
		{
			// save model type
			this.modelType = modelType;
			
			String modelPath = basePath + this.modelType + '/' + modelFile;
			
			model.setAttr( 'model-scale', 0.0 );
			MVIEW_ANIM_CALLBACK @animate = MVIEW_ANIM_CALLBACK(this.__AnimModelScale);
			window.setInterval( animate, 10, any(@model) );
			
			// skin looks bad when model changes
			SetSkin( @elem, this.modelSkin );

			model.setAttr( 'model-modelpath', modelPath );
		}
	}
	
	bool __AnimModelScale(any &obj)
	{
		Element @model;
		obj.retrieve(@model);
		
		float scale = model.getAttr( 'model-scale', 0.0 ) + 0.05;
		if( scale >= maxScale ) {
			model.setAttr( 'model-scale', maxScale );
			return false;
		}
		model.setAttr( 'model-scale', scale );
		return true;
	}
	
	// Set the model's skin
	void SetSkin( Element @elem, const String &skin )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			if( skin.empty() ) {
				this.modelSkin = 'default';
			} else {
				// save current skin for future refresh
				this.modelSkin = skin;
			}

			String skinPath = basePath + this.modelType + '/' + this.modelSkin + skinExt;
			model.setAttr( 'model-skinpath', skinPath );
		}
	}
	
	// Set the horizontal fov to use for the model
	void SetFovX( Element @elem, const float fov )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-fov-x', fov );
		}
	}
	
	// Set the vertical fov to use for the model
	void SetFovY( Element @elem, const float fov )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-fov-y', fov );
		}
	}
	
	// Set the model's scaling factor
	void SetScale( Element @elem, const float scale )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-scale', scale );
		}
	}
	
	void SetMaxScale( const float scale )
	{
		this.maxScale = scale;
	}
	
	// color as decimal rgb triplet: "R G B"
	void SetShaderColor( Element @elem, const String &color )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null && !color.empty() )
		{
			model.setAttr( 'model-shader-color', color );
		}
	}
	
	// color as decimal rgb triplet: "R G B"
	void SetOutlineColor( Element @elem, const String &color )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null && !color.empty() )
		{
			model.setAttr( 'model-outline-color', color );
		}
	}
	
	// model's x axis rotation
	void XRotation( Element @elem, const float rotation ) 
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-rotation-pitch', rotation );
		}
	}

	// model's y axis rotation
	void YRotation( Element @elem, const float rotation )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-rotation-yaw', rotation );
		}
	}

	// model's z axis rotation
	void ZRotation( Element @elem, const float rotation )
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-rotation-roll', rotation );
		}
	}
	
	// set the model's x axis rotation speed
	void SetXRotationSpeed( Element @elem, const float speed ) 
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-rotation-speed-pitch', speed );
		}
	}
	
	// set the model's y axis rotation speed
	void SetYRotationSpeed( Element @elem, const float speed ) 
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-rotation-speed-yaw', speed );
		}
	}	
	
	// set the model's z axis rotation speed
	void SetZRotationSpeed( Element @elem, const float speed ) 
	{
		Element @model = GetModel( @elem );
		
		if( @model != null )
		{
			model.setAttr( 'model-rotation-speed-roll', speed );
		}
	}		
}