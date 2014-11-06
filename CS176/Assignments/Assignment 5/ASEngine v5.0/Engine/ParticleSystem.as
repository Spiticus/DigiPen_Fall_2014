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
			/* STUDENT CODE GOES HERE */
			//particleinfo loaded, emitter type loaded
		}
		
		final override public function Initialize():void
		{
			//Wipe out Vector of partricles (because reset particle system)
			//Cleaning up everything we need to RECEREATE
			//Test reinitializing
			/* STUDENT CODE GOES HERE */
		}
		
		final private function GenerateParticles()
		{
			//Takes delay, etc.. everything
			/* STUDENT CODE GOES HERE */
		}
		
		final private function ResetParticle(iIndex:int)
		{
			//Reseting ONE particle only (iIndex = the particle number to reset)
			/* STUDENT CODE GOES HERE */
		}
		
		final override public function Update():void
		{
			//Making sure it loops through the particles and see if some shoudl be reset.
			//Check boolean, then CALL the FUNCTION to RESET
			/* STUDENT CODE GOES HERE */
		}
		
		final override public function Uninitialize():void
		{
			/* STUDENT CODE GOES HERE */
		}
				
		final override public function Destroy():void
		{
			super.Destroy();
			/* STUDENT CODE GOES HERE */
		}
	}

}