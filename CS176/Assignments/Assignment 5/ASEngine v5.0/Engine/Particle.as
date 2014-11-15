/***************************************************************************************/
/*
	filename   	Particle.as 
	author		Elie Abi Chahine and Jason Clark
	email   	eabichahine@digipen.edu / jason.w@digipen.edu
	date		24/11/2014 
	
	brief: This class is responsible for the particles themselevs. Specifically, it
	initializes  and sets the various variables with values passed in from an XML as
	well as updating those values.	

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
		
		/*******************************************************************************/
		/*
			Description:
				This method is the Constructor. It is responsible for initializing
				all the Particle's variables. It also enables phyiscs for particles.				
			
			Parameters:
				- displayobject_: can be any kind of display object or display container
				- particleinfo_: The object's particle values
				- iCollisionType_: The object's collision type for collsion
				- iID_: the object's ID
				
			Return:
				- None
		*/
		/*******************************************************************************/
		public function Particle(displayobject_:DisplayObject, particleinfo_:ParticleInfo, iCollisionType_:int = 0, iID_:int = 14)
		{
			super(displayobject_, 0 , 0, iID_, iCollisionType_);
			particleinfo = particleinfo_;
			pDeltaScale = new Point();
			EnablePhysics();			
		}
		
		/**************************************************************************
		/*
			Description:
				This method initializes the Particle by creating or 
				initializing the needed variables.
				
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*************************************************************************/
		final override public function Initialize():void
		{
			bIsDead = false;
			bShouldReset = false;
			
			SetPhysicsProperties(particleinfo.nMass, new Point(), 0);
			
			physicsinfo.nVelocityMagnitude = 0;
			physicsinfo.pVelocityDirection.x = 0;
			physicsinfo.pVelocityDirection.y = 0;
			
			physicsinfo.RemoveAllForces();
			
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
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible to update the particle(alpha, scale...).
				This function will most probably be called every frame as long as the
				particle is still alive.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		final override public function Update():void
		{			
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
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible to destroy the particle by removing calling
				the destroy function in GameObject and nulling particleinfo
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		final override public function Destroy():void
		{
			super.Destroy();
			particleinfo = null;
		}
	}
}