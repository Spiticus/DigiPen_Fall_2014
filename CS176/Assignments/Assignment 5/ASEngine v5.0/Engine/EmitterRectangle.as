/***************************************************************************************/
/*
	filename   	EmitterRectangle.as 
	author		Elie Abi Chahine and Jason Clark
	email   	eabichahine@digipen.edu / jason.w@digipen.edu
	date		24/11/2014 
	
	brief: This class is for the rectangle type of emitter. It's main function is
	to set the position of particles within the confines of the rectangle emitter,
	which itself is defined through an XML.	

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
		
		/*******************************************************************************/
		/*
			Description:
				This method is the Constructor. It is responsible for initializing
				all the Circle Emitter's variables. 				
			
			Parameters:
				- nPosX_: the emitter's x coordinate
				- nPosY_: the emitter's y coordinate
				- uiEmissionRate_: the particle's emission rate
				- nEmissionDelay_: the particle's emission delay
				- uiInnerHalfWidth_: the emitter's inner half width
				- uiOuterHalfWidth_: the emitter's outer half width
				- uiInnerHalfHeight_: the particle's inner half height
				- uiOuterHalfHeight_: the particle's outer helf height
				
			Return:
				- None
		*/
		/*******************************************************************************/
		public function EmitterRectangle(nPosX_:Number, nPosY_:Number, uiEmissionRate_:uint, nEmissionDelay_:Number,
										 uiInnerHalfWidth_:uint, uiOuterHalfWidth_:uint, uiInnerHalfHeight_:uint,
										 uiOuterHalfHeight_:uint)
		{
			super(nPosX_, nPosY_, uiEmissionRate_, nEmissionDelay_);
			uiInnerHalfWidth = uiInnerHalfWidth_;
			uiOuterHalfWidth = uiOuterHalfWidth_;
			uiInnerHalfHeight = uiInnerHalfHeight_;
			uiOuterHalfHeight = uiOuterHalfHeight_;
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for setting the particle's position within
				the rectangle emitter.
			
			Parameters:
				- particle: the actual particle receiving the position

				
			Return:
				- None
		*/
		/*******************************************************************************/
		override internal function SetParticlePosition(particle:Particle)
		{
			//Same as in Circle Emitter, but now it's between the width and the height
			//This function is empty in the parent
			
			//Two variables each finding a random value of either 0 or 1
			var iCount:int = (Math.random() * 100) % 2;
			var iSecondCount:int = (Math.random() * 100) % 2;
			
			//Sets the particle x and y coordinates according to the settings passed in from the constructor
			if(iCount == 0)
			{
				particle.displayobject.x = pPosition.x + HelperFunctions.GetRandom(-uiOuterHalfWidth, uiOuterHalfWidth);
				if(iSecondCount == 0)
				{
					particle.displayobject.y = pPosition.y + HelperFunctions.GetRandom(uiInnerHalfHeight, uiOuterHalfHeight);
				}
				else
				{
					particle.displayobject.y = pPosition.y + HelperFunctions.GetRandom(-uiOuterHalfHeight, -uiInnerHalfHeight);
				}
			}
			
			if(iCount == 1)
			{
				particle.displayobject.y = pPosition.y + HelperFunctions.GetRandom(-uiOuterHalfHeight, uiOuterHalfHeight);
				if(iSecondCount == 0)
				{
					particle.displayobject.x = pPosition.x + HelperFunctions.GetRandom(uiInnerHalfWidth, uiOuterHalfWidth);
				}
				else
				{
					particle.displayobject.x = pPosition.x + HelperFunctions.GetRandom(-uiOuterHalfWidth, -uiInnerHalfWidth);
				}
			}
			
		}
	}

}