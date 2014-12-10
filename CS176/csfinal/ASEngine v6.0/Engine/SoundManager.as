/***************************************************************************************/
/*
	filename   	SoundManager.as 
	author		Jason Clark
	email   	jason.w@digipen.edu
	date		12/09/2014
	
	brief:
	The SoundManager class is responsible for handling various sounds and whether
	they should be playing, paused, resumed, or destroyed. It adds sounds into
	a vector, runs through the vector to check various conditions, and if called for,
	removes the sound from the vector.
*/        	 
/***************************************************************************************/
package Engine
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import Engine.Sounds;
	
	public class SoundManager
	{
		static private var vSounds:Vector.<Sounds>;
		static public var sndSound:Sounds;
		static public var ivSoundsLength:int;
		static public var bPaused:Boolean;

		public function SoundManager()
		{
			// constructor code
		}
		
		static internal function Initialize():void
		{
			vSounds = new Vector.<Sounds>;
		}
		
		static public function AddSounds(sndSound_:Sound,
										 bLooping_:Boolean,
										 sName_:String):void
		{
			sndSound = new Sounds(sndSound_, bLooping_, sName_);
			sndSound.Initialize();
			vSounds.push(sndSound);
		}
		
		static public function PausingSound():void
		{
			ivSoundsLength = vSounds.length;
			
			for(var i:int = 0; i < ivSoundsLength; ++i)
			{
				if(vSounds[i].bLooping == true)
				{
					vSounds[i].PauseSound();
				}
			}
		}
		
		static public function ResumingSound(bPaused_:Boolean):void
		{
			ivSoundsLength = vSounds.length;
			bPaused = bPaused_;
			
			for(var i:int = 0; i < ivSoundsLength; ++i)
			{
				if(bPaused != true)
				{
					vSounds[i].ResumeSound();
				}
			}
		}
		
		static public function RemoveSoundByName(sName_:String):void
		{
			ivSoundsLength = vSounds.length;
			
			for(var i:int = 0; i < ivSoundsLength; ++i)
			{
				if(vSounds[i].sName == sName_)
				{
					vSounds[i].Uninitialize();
					vSounds.splice(i, 1);
				}
			}
		}
		
		static public function RemoveSounds():void
		{
			ivSoundsLength = vSounds.length;
			
			for(var i:int = 0; i < ivSoundsLength; ++i)
			{
				vSounds[i].Uninitialize();
				vSounds.splice(i, 1);
			}
		}
		
		static public function Destroy():void
		{
			ivSoundsLength = vSounds.length;
			
			if(ivSoundsLength > 0)
			{
				RemoveSounds();
			}
			vSounds = null;
		}
	}
}