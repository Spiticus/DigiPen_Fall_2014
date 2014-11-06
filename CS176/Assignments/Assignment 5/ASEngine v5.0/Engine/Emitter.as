/***************************************************************************************/
/*
	filename   	Emitter.as 
	author		Elie Abi Chahine
	email   	eabichahine@digipen.edu
	date		24/05/2011 
	
	brief:
	3rd looked at (after Particle)
	Inside any class you can make a helper function, but just set it to private
	

*/        	 
/***************************************************************************************/
package Engine
{
	import flash.geom.Point;
	
	internal class Emitter
	{
		public var pPosition:Point;
		//Using DT, how many particles are spawned every frame(similar to 
		public var uiEmissionRate:uint;
		public var nEmissionDelay:Number;
		//See the Range class where the Ranges are created that will be pushed in here
		private var vForceRanges:Vector.<Range>;
		
		//EXAMPLE: If emission rate is 100:
		//EXAMPLE: 0.4 seconds / DT = 12 frames (need to have 100 particles)
		//Once you reach a MAX amount, do not generate any amount
		//Check to see if you've reached the MAX every frame,
		//If not then create the set numnber of particles for Rate & Delay (pre-computed)
		
		public function Emitter(nPosX_:Number, nPosY_:Number, uiEmissionRate_:uint, nEmissionDelay_:Number)
		{
			pPosition = new Point(nPosX_, nPosY_);
			uiEmissionRate = uiEmissionRate_;
			nEmissionDelay = nEmissionDelay_;
			vForceRanges = new Vector.<Range>();
		}
		
		//KEEP THIS FUNCTION EMPTY; USE CHILD CLASSES
		internal function SetParticlePosition(particle:Particle)
		{
		}
		
		final public function AddForceOnParticle(iLowerAngle:int, iUpperAngle:int,
					   					   nLowerMagnitude:Number, nUpperMagnitude:Number, 
					                       nLowerLifetime:Number, nUpperLifetime:Number)
		{
			//Adds a new range to the vector of ranges based on the passed in parameters (using the
			//function in Range class)
			/* STUDENT CODE GOES HERE */
		}
		
		internal function SetParticleForces(particle:Particle):void
		{
			//Looping through all the ranges in the vector, calling the GetForce,
			//then applying the force on the particle
			/* STUDENT CODE GOES HERE */
		}
				
		internal function Destroy()
		{
			//Destroyrs vector
			//Cleans up ranges
			//Wipes vector, null things, etc..
			/* STUDENT CODE GOES HERE */
		}
	}
}