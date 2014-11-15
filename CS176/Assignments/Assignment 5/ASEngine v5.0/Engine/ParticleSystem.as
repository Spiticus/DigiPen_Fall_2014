/***************************************************************************************/
/*
	filename   	ParticleSystem.as 
	author		Elie Abi Chahine and Jason Clark
	email   	eabichahine@digipen.edu / jason.w@digipen.edu
	date		24/11/2014 
	
	brief: This class is responsible for checking which type of emitter is going
	to be used, spawning the particles within the confines of that emitter, updates them,
	reinitializes them when they die, and finally destroys them when the level finishes.
	

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
		private var nAge:Number;
		
		/*******************************************************************************/
		/*
			Description:
				This method is the Constructor. It is responsible for initializing
				all the Particle system's variables and checking which emitter will
				be used.				
			
			Parameters:
				- xmlEmitterProperties_: the emitter's properties taken from an XML
				- xmlParticleProperties_: The particle properties taken from an XML
				- uiNumberOfParticles_: The number of max particles
				- nLifeTime_: the object's set time before it gets reset
				- displayobjectcontainer_: can be any kind of display object or display container
				- nPosX_: The object's x coordinate
				- nPosY_: The object's y coordinate
				- iCollisionType_: the object's collision type
				- iID_: the object's ID
				
			Return:
				- None
		*/
		/*******************************************************************************/
		public function ParticleSystem(xmlEmitterProperties_:XML, xmlParticleProperties_:XML, uiNumberOfParticles_:uint, nLifeTime_:Number,
									   displayobjectcontainer_:DisplayObjectContainer = null, nPosX_:Number = 0, nPosY_:Number = 0, 
									   iCollisionType_:int = 1, iID_:int = 13 )
		{
			super(displayobjectcontainer_, nPosX_, nPosY_, iID_, iCollisionType_);
			//Loading particle system properties and creating new Particle info
			uiNumberOfParticles = uiNumberOfParticles_;
			nLifeTime = nLifeTime_;
			particleinfo = new ParticleInfo(xmlParticleProperties_);
			vParticles = new Vector.<Particle>;
			
			//Checking to see which type of emitter is being used, then loading the info for that type
			if(xmlEmitterProperties_.Type == "Circle")
			{
				emitter = new EmitterCircle(nPosX_, nPosY_, xmlEmitterProperties_.EmissionRate, xmlEmitterProperties_.EmissionDelay,
								  xmlEmitterProperties_.InnerRadius, xmlEmitterProperties_.OuterRadius,
								  xmlEmitterProperties_.InnerAngle, xmlEmitterProperties_.OuterAngle);
			}
			if(xmlEmitterProperties_.Type == "Rectangle")
			{
				emitter = new EmitterRectangle(nPosX_, nPosY_, xmlEmitterProperties_.EmissionRate, xmlEmitterProperties_.EmmisionDelay,
									 xmlEmitterProperties_.InnerHalfWidth, xmlEmitterProperties_.OuterHalfWidth,
									 xmlEmitterProperties_.InnerHalfHeight, xmlEmitterProperties_.OuterHalfHeight);
			}
			
			for(var i:int = 0; i < xmlEmitterProperties_.Forces.Force.length(); ++i)
			{
				emitter.AddForceOnParticle(xmlEmitterProperties_.Forces.Force[i].LowerAngle,
										   xmlEmitterProperties_.Forces.Force[i].UpperAngle,
										   xmlEmitterProperties_.Forces.Force[i].MinMagnitude,
										   xmlEmitterProperties_.Forces.Force[i].MaxMagnitude,
										   xmlEmitterProperties_.Forces.Force[i].MinTime,
										   xmlEmitterProperties_.Forces.Force[i].MaxTime);
			}
			
		}
		
		/**************************************************************************
		/*
			Description:
				This method initializes the Particle system by creating or 
				initializing the needed variables.
				
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*************************************************************************/
		final override public function Initialize():void
		{
			//Wipe out Vector of partricles (because reset particle system)
			//Cleaning up everything we need to RECEREATE
			//Test reinitializing
			nAge = 0;
			uiParticlesCount = 0;
			GenerateParticles();
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for generating the particles in the system
				by adding them to the vParticles vector and using the ObjectManager
				to add them to the game. It also sets the forces and properties on the
				particles.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		final private function GenerateParticles()
		{
			//If the number of current particles is less than the maximum number allowed...
			if(uiParticlesCount < uiNumberOfParticles)
			{
				var nParticles:Number;
				
				//If there is no delay or rate for the particles...
				if(emitter.nEmissionDelay == 0 || emitter.uiEmissionRate == 0)
				{
					//Set the value to spawn them all at once
					nParticles = uiNumberOfParticles;
				}
				//If there is
				else
				{
					//Set the values to spawn the particles according to those emitter values
					nParticles = (PhysicsManager.DT * emitter.uiEmissionRate) / emitter.nEmissionDelay;
					if(uiParticlesCount + nParticles > uiNumberOfParticles)
					{
						nParticles = uiNumberOfParticles - uiParticlesCount;
					}
				}
				
				//Loops through the set number of particles to spawn...
				for(var p:int = 0; p < nParticles; ++p)
				{
					//and then spawns them.
					var particle:Particle = new Particle(new particleinfo.particleClassReference(), particleinfo);
					vParticles.push(particle);
					ObjectManager.AddObject(particle, particleinfo.sName, ObjectManager.OM_DYNAMICOBJECT);
					emitter.SetParticlePosition(particle);
					emitter.SetParticleForces(particle);
					++uiParticlesCount;
				}
			}
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for resetting the particles once their
				nLifeTime has reached a certain age by recalling Initialize on them
				and resetting emitter properties.
			
			Parameters:
				- iIndex: the individual particle needing to be reset
				
			Return:
				- None
		*/
		/*******************************************************************************/
		final private function ResetParticle(iIndex:int)
		{
			//Reseting ONE particle only (iIndex = the particle number to reset)
			vParticles[iIndex].physicsinfo.RemoveAllForces();
			
			vParticles[iIndex].Initialize();
			emitter.SetParticlePosition(vParticles[iIndex]);
			emitter.SetParticleForces(vParticles[iIndex]);
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for updating the particle system.
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
			//Making sure it loops through the particles and see if some shoudl be reset.
			GenerateParticles();
			nAge += PhysicsManager.DT;
			if(nAge >= nLifeTime)
			{
				bIsDead = true;
			}
			for(var i:int = 0; i < vParticles.length; ++i)
			{
				if(vParticles[i].bShouldReset == true)
				{
					ResetParticle(i);
				}
			}
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsible for uninitializing the particle system by
				deleting the paticles themselves.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		final override public function Uninitialize():void
		{
			for(var i:int = 0; i < vParticles.length; ++i)
			{
				delete vParticles[i];
			}
			vParticles.length = 0;
		}
		
		/*******************************************************************************/
		/*
			Description:
				This method is responsiblefor destroying the particle system by calling
				the GameOhject's Destroy function.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		final override public function Destroy():void
		{
			super.Destroy();
		}
	}

}