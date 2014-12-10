/***************************************************************************************/
/*
	filename   	HeroSP.as 
	author		Elie Abi Chahine/Jason Clark
	email   	eabichahine@digipen.edu/hason.w@digipen.edu
	date		12/09/2014 
	
	brief:
	The HeroSP class creates a hero and deals with its gameplay behavior.
	
*/        	 
/***************************************************************************************/
package GamePlay.Level1
{
	import Engine.*;
	import GamePlay.GamePlayGlobals;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import Engine.PhysicsManager;
	import Engine.PhysicsInfo;
	import flash.geom.Point;
	import GamePlay.MainMenu.MainMenu;
	
	final public class HeroSP extends GameObject
	{
		/* Controls the hero's speed. Used for all four directions */
		public var nJumpMag:Number;
		public var nMoveMag:Number;
		public var nGravMag:Number;
		public var pVel:int;
		
		
		/*******************************************************************************/
		/*
			Description:
				Constructor that creates a hero instance and initializes all its
				properties.
				
			Parameters:
				- None
						 
			Return:
				- None
		*/
		/*******************************************************************************/
		final public function HeroSP()
		{
			super(new Hero(), 0, 0, GamePlayGlobals.GO_HERO, CollisionManager.CO_DYNAMIC | CollisionManager.CO_TILEMAP);
			EnablePhysics();
			nJumpMag = 30000;
			nGravMag = 8000;
			nMoveMag = 30;
			pVel = 10;
		}
		
		final public function Movement():void
		{
			var pDirection:Point = new Point(0,1);
			physicsinfo.AddForce(PhysicsManager.DT, pDirection, nGravMag);
			
			if(InputManager.IsTriggered(Keyboard.UP))
			{
				var pDirectionU:Point = new Point(0,-1);
				physicsinfo.AddForce(PhysicsManager.DT + 0.1, pDirectionU, nJumpMag);
			}
			if(InputManager.IsPressed(Keyboard.RIGHT))
			{
				this.physicsinfo.pVelocityDirection.x = pVel;
			}
			if(InputManager.IsPressed(Keyboard.LEFT))
			{
				this.physicsinfo.pVelocityDirection.x = -pVel;
			}
			
			physicsinfo.nVelocityMagnitude = nMoveMag;
		}
		
		/*******************************************************************************/
		/*
			Description:
				The update function calls the hero's movement.
				
			Parameters:
				- None
						 
			Return:
				- None
		*/
		/*******************************************************************************/
		final override public function Update():void
		{
			physicsinfo.nVelocityMagnitude = 0;
			
			Movement();
		}
		
		/**************************************************************************
		/*
			Description:
				This method will check if any collision with certain tiles in the 
				tile map happened or if the hero collides with an open door in 
				order to switch to level 3.
				If collision with tile ID 1 or 2 happened we will need to snap 
				according to which side we collided (UP and DOWN will snap on the Y
				RIGHT and LEFT will snap on the X).
				
			Parameters:
				- CInfo_: The collision information. It includes the collision type, 
				         collided with object, tile map information...
						 
			Return:
				- None
		*/
		/*************************************************************************/
		final override public function CollisionReaction(CInfo_:CollisionInfo):void
		{
			
			if( CInfo_.iCollisionType == CollisionManager.CO_DYNAMIC )
			{
				if(CInfo_.gameobjectCollidedWith.iType == GamePlayGlobals.GO_DOOR)
				{
					var door:GameObject = ObjectManager.GetObjectByName("Door", ObjectManager.OM_DYNAMICOBJECT);
					if((MovieClip(door.displayobject)).currentFrame == 2)
					{
						GameStateManager.GotoState(new MainMenu());
					}
				}
			}
			else if( CInfo_.iCollisionType == CollisionManager.CO_TILEMAP )
			{
				
				var bSnapOnY:Boolean = false;
				var bSnapOnX:Boolean = false;
				var HotspotsSize:int = CInfo_.gameobject.vHotSpots.length;
				for(var i:int = 0; i < HotspotsSize; ++i)
				{
					
					if(CInfo_.gameobject.vHotSpots[i].iCollidedTilesID == 1 || 
					   CInfo_.gameobject.vHotSpots[i].iCollidedTilesID == 2)
					{
						if(CInfo_.gameobject.vHotSpots[i].iSide == HotSpot.HS_UP ||
						   CInfo_.gameobject.vHotSpots[i].iSide == HotSpot.HS_DOWN)
						{
							bSnapOnY = true;
						}
						else if(CInfo_.gameobject.vHotSpots[i].iSide == HotSpot.HS_RIGHT ||
								CInfo_.gameobject.vHotSpots[i].iSide == HotSpot.HS_LEFT)
						{
							bSnapOnX = true;
						}
					}
					
				}
				
				if(bSnapOnY)
				{
					CInfo_.tilemapinfo.SnapToTile(this, CInfo_.uiSnapToRow, CInfo_.uiSnapToColumn, HotSpot.HS_UP);
				}
				
				if(bSnapOnX)
				{
					CInfo_.tilemapinfo.SnapToTile(this, CInfo_.uiSnapToRow, CInfo_.uiSnapToColumn , HotSpot.HS_LEFT);
				}
			}
		}
	}
}