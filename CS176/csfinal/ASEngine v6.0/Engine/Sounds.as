/***************************************************************************************/
/*
	filename   	Sounds.as 
	author		Jason Clark
	email   	jason.w@digipen.edu
	date		12/09/2014
	
	brief:
	The Sounds class is the base class for all sounds played. The class plays, pauses,
	and resumes sounds according to the engine user. It will also destroy sounds.
*/        	 
/***************************************************************************************/

package Engine
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class Sounds
	{
		//Sounds variables
		public var sndSound : Sound;
		public var bLooping : Boolean;
		public var sName : String;
		
		//Sound channel variables
		public var iPause : int;
		public var scSoundChannel : SoundChannel;
		
		

		public function Sounds(sndSound_:Sound, bLooping_:Boolean, sName_:String)
		{
			sndSound = sndSound_;
			bLooping = bLooping_;
			sName = sName_;
		}
		
		public function Initialize():void
		{
			scSoundChannel = sndSound.play();
			scSoundChannel.addEventListener(Event.SOUND_COMPLETE, SoundComplete);
		}
		
		public function SoundComplete():void
		{
			if(bLooping != true)
			{
				Uninitialize();
			}
			else
			{
				scSoundChannel = sndSound.play();
			}
		}
		
		public function PauseSound():void
		{
			iPause = scSoundChannel.position;
			scSoundChannel.stop();
		}
		
		public function ResumeSound():void
		{
			scSoundChannel = sndSound.play(iPause);
		}
		
		public function Uninitialize():void
		{
			scSoundChannel.stop();
			Destroy();
		}
		
		public function Destroy():void
		{
			sndSound = null;
			scSoundChannel = null;
		}
	}
}