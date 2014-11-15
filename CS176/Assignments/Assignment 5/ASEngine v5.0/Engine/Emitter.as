/***************************************************************************************/
/*
	filename   	Emitter.as 
	author		Elie Abi Chahine and Jason Clark
	email   	eabichahine@digipen.edu / jason.w@digipen.edu
	date		24/11/2014 
	
	brief:
	This is the class for Emitter. It provides the SetParticlePosition function, which
	will be used in emitter type classes than inherit. It also sets and adds forces
	on the particles.	

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
		
		/*******************************************************************************/
		/*
			Description:
				This method is the Constructor. It is responsible for initializing
				all the Emitter's variables. 				
			
			Parameters:
				- nPosX_: the emitter's x coordinate
				- nPosY_: the emitter's y coordinate
				- uiEmissionRate_: the particle's emission rate
				- nEmissionDelay_: the particle's emission delay
				
			Return:
				- None
		*/
		/*******************************************************************************/
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
		
		/**************************************************************************
		/*
			Description:
				This method is responsible for adding a range for a force into
				the vector of force ranges to be used below in the next function.
				
			Parameters:
				- iLowerAngle: the range's lower angle limit
				- iUpperAngle: the range's upper angle limit
				- nLowerMagnitude: the range's lower magnitude limit
				- nUpperMagnitude: the range's upper magnitude limit
				- nLowerLifetime: the range's lower lifetime limit
				- nUpperLifetime: the rang'e upper lifetime limit
				
			Return:
				- None
		*/
		/*************************************************************************/
		final public function AddForceOnParticle(iLowerAngle:int, iUpperAngle:int,
					   					   nLowerMagnitude:Number, nUpperMagnitude:Number, 
					                       nLowerLifetime:Number, nUpperLifetime:Number)
		{
			//Adds a new range to the vector of ranges based on the passed in parameters (using the
			//function in Range class)
			vForceRanges.push(new Range(iLowerAngle, iUpperAngle, nLowerMagnitude, nUpperMagnitude, nLowerLifetime, nUpperLifetime));
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for adding the force defined in the vector
				to the particle's physics info.
			
			Parameters:
				- particle: the actual particle receiving the force

				
			Return:
				- None
		*/
		/*******************************************************************************/
		internal function SetParticleForces(particle:Particle):void
		{
			//Looping through all the ranges in the vector, calling the GetForce,
			//then applying the force on the particle
			//For every range that i have, call the GetFroceFromRange(), apply it on the particle that's passed in
			for(var i:int = 0; i < vForceRanges.length; ++i)
			{
				var force:Force = vForceRanges[i].GetForceFromRange();
				particle.physicsinfo.AddForce(force.nTime, force.pDirection, force.nMagnitude);
			}
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for nulling out the force ranges within
				the force range vector as well as nulling out the force range vector
				itself.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		internal function Destroy()
		{
			//Clears ranges and null vector
			for(var i:int = 0; i < vForceRanges.length; ++i)
			{
				vForceRanges[i] = null;
			}
			vForceRanges.length = 0;
			vForceRanges = null;
			
		}
	}
}