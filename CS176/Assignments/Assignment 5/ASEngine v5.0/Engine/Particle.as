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
	import Engine.PhysicsManager;
	
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
	
		public function Particle(displayobject_:DisplayObject, particleinfo_:ParticleInfo, iCollisionType_:int = 0, iID_:int = 14)
		{
			super(displayobject_, 0 , 0, iID_, iCollisionType_);
			particleinfo = particleinfo_;
			
			//Every time i crate a particle then i have to enable physics and set its mass
			
			
		}

		final override public function Initialize():void
		{
			//Getting values for opacity
			var endOpacity:Number = HelperFunctions.GetRandom(particleinfo.nLowerEndOpacity, particleinfo.nUpperEndOpacity);
			var startOpacity:Number = HelperFunctions.GetRandom(particleinfo.nLowerStartOpacity, particleinfo.nUpperStartOpacity);
			
			//Getting values for scale
			var endScaleX:Number = HelperFunctions.GetRandom(particleinfo.nLowerEndScaleX, particleinfo.nUpperEndScaleX);
			var endScaleY:Number = HelperFunctions.GetRandom(particleinfo.nLowerEndScaleY, particleinfo.nUpperEndScaleY);
			var startScaleX:Number = HelperFunctions.GetRandom(particleinfo.nLowerStartScaleX, particleinfo.nUpperStartScaleX);
			var startScaleY:Number = HelperFunctions.GetRandom(particleinfo.nLowerStartScaleY, particleinfo.nUpperStartScaleY);
			
			//Getting value for lifeTime
			var lifeTime:Number = HelperFunctions.GetRandom(particleinfo.nLowerLifetime, particleinfo.nUpperLifetime);
			
			//Updating Opacity and Scale
			nDeltaOpacity = (endOpacity - startOpacity) / PhysicsManager.DT;
			pDeltaScale.x =(endScaleX - startScaleX) / PhysicsManager.DT;
			pDeltaScale.y = (endScaleY - startScaleY) / PhysicsManager.DT;
			
			nLifeTime -= lifeTime;
			
		}
		
		final override public function Update():void
		{ 
			//Scale, Opacity --- Forces
			
			//Checking if the boolean for reset has lasted longer than a frame...
			if(bShouldReset == true)
			{
				//if so, set it's dead boolean to true.
				bIsDead = true;
			}
			
			nDeltaOpacity += nDeltaOpacity;
			pDeltaScale += pDeltaScale;
			nLifeTime -= PhysicsManager.DT;
			
			if(nLifeTime <= 0)
			{
				bShouldReset = true;
			}
			
		}
		
		final override public function Destroy():void
		{
			/* STUDENT CODE GOES HERE */
		}
	}
}