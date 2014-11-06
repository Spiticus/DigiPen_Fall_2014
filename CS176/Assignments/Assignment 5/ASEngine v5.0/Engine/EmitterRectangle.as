/***************************************************************************************/
/*
	filename   	EmitterRectangle.as 
	author		Elie Abi Chahine
	email   	eabichahine@digipen.edu
	date		24/05/2011 
	
	brief:
	

*/        	 
/***************************************************************************************/
package Engine
{
	import flash.geom.Point;
	
	final public class EmitterRectangle extends Emitter
	{
		internal var uiInnerHalfWidth:uint;
		internal var uiOuterHalfWidth:uint;
		internal var uiInnerHalfHeight:uint;
		internal var uiOuterHalfHeight:uint;
		
		public function EmitterRectangle(nPosX_:Number, nPosY_:Number, uiEmissionRate_:uint, nEmissionDelay_:Number,
										 uiInnerHalfWidth_:uint, uiOuterHalfWidth_:uint, uiInnerHalfHeight_:uint, uiOuterHalfHeight_:uint)
		{
			super(nPosX_, nPosY_, uiEmissionRate_, nEmissionDelay_);
			uiInnerHalfWidth = uiInnerHalfWidth_;
			uiOuterHalfWidth = uiOuterHalfWidth_;
			uiInnerHalfHeight = uiInnerHalfHeight_;
			uiOuterHalfHeight = uiOuterHalfHeight_;
		}

		override internal function SetParticlePosition(particle:Particle)
		{
			//Same as in Circle Emitter, but now it's between the width and the height
			//This function is empty in the parent
			//Lots of math here.
			/* STUDENT CODE GOES HERE */
		}
	}

}