/***************************************************************************************/
/*
	filename   	EmitterCircle.as 
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
	
	final public class EmitterCircle extends Emitter
	{
		internal var nInnerRadius:Number;
		internal var nOuterRadius:Number;
		internal var iInnerAngleRange:int;
		internal var iOuterAngleRange:int;
		private const PiOver180:Number = 0.01745329251;
		
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
				- nInnerRadius_: the emitter's inner radial limit
				- nOuterRadius_: the emitter's outer radial limit
				- iInnerAngleRange_: the particle's inner angle range
				- iOuterAngleRange_: the particle's outer angle range
				
			Return:
				- None
		*/
		/*******************************************************************************/
		public function EmitterCircle(nPosX_:Number, nPosY_:Number, uiEmissionRate_:uint, nEmissionDelay_:Number,
									  nInnerRadius_:Number, nOuterRadius_:Number, iInnerAngleRange_:int, iOuterAngleRange_:int)
		{
			super(nPosX_, nPosY_, uiEmissionRate_, nEmissionDelay_);
			nInnerRadius = nInnerRadius_;
			nOuterRadius = nOuterRadius_;
			iInnerAngleRange = iInnerAngleRange_;
			iOuterAngleRange = iOuterAngleRange_;
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for setting the particle's position within
				the circle emitter.
			
			Parameters:
				- particle: the actual particle receiving the position

				
			Return:
				- None
		*/
		/*******************************************************************************/
		override internal function SetParticlePosition(particle:Particle)
		{
			//Setting the particle when it is first created or reinitialized
			//If circle emitter like here, it is between innner and outer radius
			//This function is mepty in the parent			
			
			var randomAngle:Number = HelperFunctions.GetRandom(iInnerAngleRange, iOuterAngleRange);
			randomAngle *= PiOver180;
			//var pointFromAngle:Point = new Point(Math.cos(randomAngle), Math.sin(randomAngle));
			var randomRadius:Number = HelperFunctions.GetRandom(nInnerRadius, nOuterRadius);
			
			particle.displayobject.x = pPosition.x + (Math.cos(randomAngle) * randomRadius);
			particle.displayobject.y = pPosition.y + (Math.sin(randomAngle) * randomRadius);
			
		}
		
	}

}