/***************************************************************************************/
/*
	filename   	ParticleSystem.as 
	author		Elie Abi Chahine
	email   	eabichahine@digipen.edu
	date		24/05/2011 
	
	brief:
	

*/        	 
/***************************************************************************************/
package Engine
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import Engine.ObjectManager;
	
	final public class ParticleSystem extends GameObject 
	{
		//The info of the particles being spawned
		public var particleinfo:ParticleInfo;
		//basically the limit
		private var uiNumberOfParticles:uint;
		//How long it survives
		private var nLifeTime:Number;
		//References to particles INSIDE object manager (to check to reset)
		private var vParticles:Vector.<Particle>;
		//Either circle or rectangle; to see which one, the XML tells us
		public var emitter:Emitter;
		//How many particlews there are SO FAR (so that we know if we have hit the limit)
		private var uiParticlesCount:uint;
		//Hihgly recmmomend compute HERE ONCE, and then use it many times
		private var nEmissionDelayTimer:Number;
		
		public function ParticleSystem(xmlEmitterProperties_:XML, xmlParticleProperties_:XML, uiNumberOfParticles_:uint, nLifeTime_:Number,
									   displayobjectcontainer_:DisplayObjectContainer = null, nPosX_:Number = 0, nPosY_:Number = 0, 
									   iCollisionType_:int = 1, iID_:int = 13 )
		{
			super(displayobjectcontainer_, nPosX_, nPosY_, iID_, iCollisionType_);
			//Loading particle system properties and creating new Particle info
			uiNumberOfParticles = uiNumberOfParticles_;
			nLifeTime = nLifeTime_;
			particleinfo = new ParticleInfo(xmlParticleProperties_);
			uiParticlesCount = 0;
			vParticles = new Vector.<Particle>;
			
			//Checking to see which type of emitter is being used, then loading the info for that type
			if(xmlEmitterProperties_.Type == "Circle")
			{
				new EmitterCircle(nPosX_, nPosY_, xmlEmitterProperties_.EmissionRate, xmlEmitterProperties_.EmissionDelay,
								  xmlEmitterProperties_.InnerRadius, xmlEmitterProperties_.OuterRadius,
								  xmlEmitterProperties_.InnerAngle, xmlEmitterProperties_.OuterAngle);
			}
			if(xmlEmitterProperties_.Type == "Rectangle")
			{
				new EmitterRectangle(nPosX_, nPosY_, xmlEmitterProperties_.EmissionRate, xmlEmitterProperties_.EmmisionDelay,
									 xmlEmitterProperties_.InnerHalfWidth, xmlEmitterProperties_.OuterHalfWidth,
									 xmlEmitterProperties_.InnerHalfHeight, xmlEmitterProperties_.OuterHalfHeight);
			}
			
			
		}
		
		final override public function Initialize():void
		{
			//Wipe out Vector of partricles (because reset particle system)
			//Cleaning up everything we need to RECEREATE
			//Test reinitializing
			GenerateParticles();
		}
		
		final private function GenerateParticles()
		{
			//Takes delay, etc.. everything
			for(var i:int = 0; i < uiNumberOfParticles; ++i)
			{
				var particle = new Particle(new particleinfo.particleClassReference(), particleinfo);
				vParticles.push(particle);
				ObjectManager.AddObject(particle, particleinfo.sName, ObjectManager.OM_DYNAMICOBJECT);
				uiParticlesCount++;
			}
		}
		
		final private function ResetParticle(iIndex:int)
		{
			//Reseting ONE particle only (iIndex = the particle number to reset)
			
			vParticles[iIndex].Initialize();
		}
		
		final override public function Update():void
		{
			//Making sure it loops through the particles and see if some shoudl be reset.
			//Check boolean, then CALL the FUNCTION to RESET
			for(var i:int = 0; i < vParticles.length; ++i)
			{
				if(vParticles[i].bShouldReset == true)
				{
					ResetParticle(i);
				}
			}
		}
		
		final override public function Uninitialize():void
		{
			for(var i:int = 0; i < vParticles.length; ++i)
			{
				delete vParticles[i];
			}
			vParticles = null;
		}
				
		final override public function Destroy():void
		{
			super.Destroy();
		}
	}

}