/***************************************************************************************/
/*
	filename   	Particle.as 
	author		Elie Abi Chahine
	email   	eabichahine@digipen.edu
	date		24/05/2011 
	
	brief:
	

*/        	 
/***************************************************************************************/
package Engine
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	final internal class Particle extends GameObject
	{
		private var  particleinfo:ParticleInfo
		private var nLifeTime:Number;
		//Computed according to data in XML
		private var nDeltaOpacity:Number;
		//Computed according to data in XML
		private var pDeltaScale:Point;
		//Flag to be turned on when particle dies; if particle system still alive, it will catch this and
		//resets it before it actually dies (unless particle system actually dies i.e. 2 frames where this
		//flag is true)
		public var bShouldReset:Boolean;
		private var nAge:Number;
	
		public function Particle(displayobject_:DisplayObject, particleinfo_:ParticleInfo, iCollisionType_:int = 0, iID_:int = 14, nAge_:Number )
		{
			super(displayobject_, 0 , 0, iID_, iCollisionType_);
			nAge = nAge_;
			particleinfo = particleinfo_;
			
			//Every time i crate a particle then i have to enable physics and set its mass
			
			//Linear interpolation over lifetime for opacity and scale (1/30 DT)
			//EXAMPLE: Opacities: 0.2 - 0.7 ; Lifetime: 1 second ; DT = 1/30 (thus particle stays 30 frames on screen)
			//EXAMPLE: (1 / 1/30) = 30 ; *** (0.7 - 0.2) / 30 =  0.5/30 ***
			
			
		}

		final override public function Initialize():void
		{
			var endOpacity:Number = HelperFunctions.GetRandom(particleinfo.nLowerEndOpacity, particleinfo.nUpperEndOpacity);
			var startOpacity:Number = HelperFunctions.GetRandom(particleinfo.nLowerStartOpacity, particleinfo.nUpperStartOpacity);
			
			//HERE, compute the nDeltaOpacity and pDeltaScale so that particles don't always have the same values
			//See notes in the constructor. nDeltaOpacity = particleinfo_.endopacity - particleinfo_.startopacity / 30
			//DT is a constant in physicsmanager.DT
			
			nDeltaOpacity = endOpacity - startOpacity;
			
			//Reset particle lifetime from particleinfo here (it will decrement)
			/* STUDENT CODE GOES HERE */
		}
		
		final override public function Update():void
		{ 
			//Scale, Opacity --- Forces
			//Lifetime; if lifetime is 0, zet bShouldReset to true; then bIsDead if bIsReset is still true next frame
			//bIsReset is true, go to the next frame. then next frame, if still true, then die
			//Could use a simple counter?? NO FOOL, LOOK BELOW!!!
			//if(bReset == true)
			//{bDead = true;}
			//This setup allows a frame to pass without using a counter.
			//if(lifetime <= 0)
			//{bRest = true}
			
			if(particleinfo.nLifeTime >= nLifetime)
			{
				bShouldReset = true;
			}
			
			/* STUDENT CODE GOES HERE */
		}
		
		final override public function Destroy():void
		{
			/* STUDENT CODE GOES HERE */
		}
	}
}