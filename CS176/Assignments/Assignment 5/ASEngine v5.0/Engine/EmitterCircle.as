/***************************************************************************************/
/*
	filename   	EmitterCircle.as 
	author		Elie Abi Chahine
	email   	eabichahine@digipen.edu
	date		24/05/2011 
	
	brief:
	Child function of Emitter that has features specific to a Circle

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
		
		public function EmitterCircle(nPosX_:Number, nPosY_:Number, uiEmissionRate_:uint, nEmissionDelay_:Number,
									  nInnerRadius_:Number, nOuterRadius_:Number, iInnerAngleRange_:int, iOuterAngleRange_:int)
		{
			super(nPosX_, nPosY_, uiEmissionRate_, nEmissionDelay_);
			nInnerRadius = nInnerRadius_;
			nOuterRadius = nOuterRadius_;
			iInnerAngleRange = iInnerAngleRange_;
			iOuterAngleRange = iOuterAngleRange_;
		}

		override internal function SetParticlePosition(particle:Particle)
		{
			//Setting the particle when it is first created or reinitialized
			//If circle emitter like here, it is between innner and outer radius
			//This function is mepty in the parent
			//WAY EASIER THAN RECTANGLE
			/* STUDENT CODE GOES HERE */
		}
		
	}

}