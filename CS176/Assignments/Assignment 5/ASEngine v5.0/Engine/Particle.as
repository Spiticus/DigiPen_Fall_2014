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
	import Engine.*;
	
	final internal class Particle extends GameObject
	{
		private var particleinfo:ParticleInfo
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
			bIsDead = false;
			bShouldReset = false;
			pDeltaScale = new Point();
			EnablePhysics();
			SetPhysicsProperties(particleinfo.nMass, new Point(), 0);
		}

		final override public function Initialize():void
		{
			displayobject.x = 100;
			displayobject.y = 100;
			
			//Getting value for lifeTime
			nLifeTime = HelperFunctions.GetRandom(particleinfo.nLowerLifetime, particleinfo.nUpperLifetime);
			
			var iNumberOfFrames:int = nLifeTime / PhysicsManager.DT;
			
			//Getting values for opacity
			var endOpacity:Number = HelperFunctions.GetRandom(particleinfo.nLowerEndOpacity, particleinfo.nUpperEndOpacity);
			var startOpacity:Number = HelperFunctions.GetRandom(particleinfo.nLowerStartOpacity, particleinfo.nUpperStartOpacity);
			displayobject.alpha = startOpacity;
			
			//Getting values for scale
			var endScaleX:Number = HelperFunctions.GetRandom(particleinfo.nLowerEndScaleX, particleinfo.nUpperEndScaleX);
			var endScaleY:Number = HelperFunctions.GetRandom(particleinfo.nLowerEndScaleY, particleinfo.nUpperEndScaleY);
			var startScaleX:Number = HelperFunctions.GetRandom(particleinfo.nLowerStartScaleX, particleinfo.nUpperStartScaleX);
			var startScaleY:Number = HelperFunctions.GetRandom(particleinfo.nLowerStartScaleY, particleinfo.nUpperStartScaleY);
			displayobject.scaleX = startScaleX;
			displayobject.scaleY = startScaleY;
			
			//Setting Opacity and Scale
			nDeltaOpacity = (endOpacity - startOpacity) / iNumberOfFrames;
			pDeltaScale.x =(endScaleX - startScaleX) / iNumberOfFrames;
			pDeltaScale.y = (endScaleY - startScaleY) / iNumberOfFrames;
			
			
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
			
			//Updating the Opacity and Scale
			displayobject.alpha += nDeltaOpacity;
			displayobject.scaleX += pDeltaScale.x;
			displayobject.scaleY += pDeltaScale.y;
			nLifeTime -= PhysicsManager.DT;
			
			if(nLifeTime <= 0)
			{
				bShouldReset = true;
			}
			
		}
		
		final override public function Destroy():void
		{
			//super.Destroy();
		}
	}
}