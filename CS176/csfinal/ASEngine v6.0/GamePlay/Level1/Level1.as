/***************************************************************************************/
/*
	filename   	Level1.as 
	author		Elie Abi Chahine and Jason Clark
	email   	eabichahine@digipen.edu/jason.w@digipen.edu
	date		12/09/2014 
	
	brief:
	This class contains level 1's gameplay code. Level 1 is a tile based level. First 
	we will load both background and dynamic object tilemaps then we add all the tiles to
	the object manager. Finally, pressing "R" restarts the level, and "M" takes us to the
	main menu.
	
*/        	 
/***************************************************************************************/
package GamePlay.Level1
{
	import Engine.*;
	import flash.ui.Keyboard;
	import GamePlay.MainMenu.MainMenu;
	//import GamePlay.Level3.Level3;
	import GamePlay.GamePlayGlobals;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import Engine.SoundManager;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import GamePlay.Level1.Level1;
	
	public class Level1 extends State
	{
		/* Dummy CoinSP variable in order for xml loading to be possible. */
		private var coin:CoinSP;
		/* Dummy HeroSP variable in order for xml loading to be possible. */
		private var hero:HeroSP;
		/* static integer that will keep track of how many coins we still have */
		static public var iNumberOfCoins:int = 0;
		static public var bPaused:Boolean;
		static public var sndGameSound:Sound;
		
		/*******************************************************************************/
		/*
			Description:
				The load function will load all needed tile map xmls. 
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		override public function Load():void
		{
			XMLManager.LoadXML("GamePlay/Level1/BackgroundData.xml", "backgroundData");
			XMLManager.LoadXML("GamePlay/Level1/SpriteData.xml", "spriteData");
		}

		/*******************************************************************************/
		/*
			Description:
				The create function is called after all the xmls are loaded. Its job is
				to load the tile map information from each xml. Only the background xml
				is added at this point since it will not be added again when we restart
				the level.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		override public function Create():void
		{			
			var xml:XML = XMLManager.GetXML("backgroundData");
			var xmlSprite:XML = XMLManager.GetXML("spriteData");

			ObjectManager.LoadTileMap(xml, ObjectManager.OM_BACKGROUND_TILEMAP);
			ObjectManager.AddTileMapObjects(ObjectManager.OM_BACKGROUND_TILEMAP);
			
			ObjectManager.LoadTileMap(xmlSprite, ObjectManager.OM_DYNAMIC_TILEMAP);
		}
		
		/*******************************************************************************/
		/*
			Description:
				The Initialize function will add the dynamic tile map objects.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		override public function Initialize():void
		{
			ObjectManager.AddTileMapObjects(ObjectManager.OM_DYNAMIC_TILEMAP);
			
			var door:GameObject = ObjectManager.GetObjectByName("Door", ObjectManager.OM_DYNAMICOBJECT);
			door.iType = GamePlayGlobals.GO_DOOR;
			(MovieClip(door.displayobject)).stop();
			
			bPaused = false;
			
			sndGameSound = new Sound(new URLRequest("Sounds/SpaceFighterLoop.mp3"));
			SoundManager.AddSounds(sndGameSound, true, "GameLoop");
			
		}
		
		/*******************************************************************************/
		/*
			Description:
				The update function handles the user's choice. The user can restart the 
				level by pressing "R" or go back to the main menu by pressing "M". If
				all coins are picked up, the level is over and the game goes back to the
				main menu.
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		override public function Update():void
		{
			if(InputManager.IsTriggered(Keyboard.R))
			{
				GameStateManager.RestartState();
				SoundManager.RemoveSounds();
			}
			
			if(InputManager.IsTriggered(Keyboard.M))
			{
				GameStateManager.GotoState(new MainMenu());
				SoundManager.RemoveSounds();
			}
			if(InputManager.IsTriggered(Keyboard.P))
			{
				if(bPaused == false)
				{
					bPaused = true;
					SoundManager.PausingSound();
					var sndPauseSound:Sound = new Sound(new URLRequest("Sounds/FunkGameLoop.mp3"));
					SoundManager.AddSounds(sndPauseSound, true, "PauseMusic");
					
				}
				else if(bPaused == true)
				{
					bPaused = false;
					SoundManager.RemoveSoundByName("PauseMusic");
					SoundManager.ResumingSound(bPaused);
				}
			}
			/*if(bPaused == true)
			{
				SoundManager.PausingSound();
				var sndPauseSound:Sound = new Sound(new URLRequest("Sounds/FunkGameLoop.mp3"));
				SoundManager.AddSounds(sndPauseSound, true, "PauseMusic");
			}
			if(bPaused == false)
			{
				if(sndPauseSound != null)
				{
					SoundManager.RemoveSoundByName("PauseMusic");
					SoundManager.ResumingSound();
				}
				else
				{
					return;
				}
			}
			*/
			if(iNumberOfCoins == 0)
			{
				var door:GameObject = ObjectManager.GetObjectByName("Door", ObjectManager.OM_DYNAMICOBJECT);
				(MovieClip(door.displayobject)).gotoAndStop(2);
			}
		}

		/*******************************************************************************/
		/*
			Description:
				The uninitialize function is responsible to clean up objects that were 
				created in the initialize function. 
			
			Parameters:
				- None
				
			Return:
				- None
		*/
		/*******************************************************************************/
		override public function Uninitialize():void
		{
			ObjectManager.RemoveAllObjectsByName("Coin", ObjectManager.OM_DYNAMICOBJECT);
			ObjectManager.RemoveAllObjectsByName("Hero", ObjectManager.OM_DYNAMICOBJECT);
			ObjectManager.RemoveAllObjectsByName("Door", ObjectManager.OM_DYNAMICOBJECT);
		}
	}
}