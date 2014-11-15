/***************************************************************************************/
/*
	filename   	ParticleInfo.as 
	author		Elie Abi Chahine
	email   	eabichahine@digipen.edu
	date		10/16/2011 
	
	brief:
	

*/        	 
/***************************************************************************************/
package Engine
{
	import flash.utils.getDefinitionByName;
	
	final public class ParticleInfo
	{
		public var sName:String;
		//The actual class; using GetDefinitionByName; class we use when using particles
		public var particleClassReference:Class;
		public var nMass:Number;
		//The range (lower, upper) for particles lifetimes so we can control it
		public var nLowerLifetime:Number;
		public var nUpperLifetime:Number;
		//Random START opacity
		public var nLowerStartOpacity:Number;
		public var nUpperStartOpacity:Number;
		//Random END opacity  //these can be same values and will have the same opacity
		public var nLowerEndOpacity:Number;
		public var nUpperEndOpacity:Number;
		//Random START lower scale 
		public var nLowerStartScaleX:Number;
		public var nLowerStartScaleY:Number;
		//Random START scale upper X
		public var nUpperStartScaleX:Number;
		public var nUpperStartScaleY:Number;
		//Random END scale lower Y
		public var nLowerEndScaleX:Number;
		public var nLowerEndScaleY:Number;
		//Random END scale upper Y
		public var nUpperEndScaleX:Number;
		public var nUpperEndScaleY:Number;
		
		public function ParticleInfo(xmlParticleProperties_:XML)
		{
			//Checks to see if there is an XML to get particle properties from
			if(xmlParticleProperties_ != null)
			{
				sName = xmlParticleProperties_.Name;
				particleClassReference = getDefinitionByName(xmlParticleProperties_.ShapeClass) as Class;
				nMass = Number(xmlParticleProperties_.Mass);
				nLowerLifetime = Number(xmlParticleProperties_.Lifetime.Lower);
				nUpperLifetime = Number(xmlParticleProperties_.Lifetime.Upper);
				nLowerStartOpacity = Number(xmlParticleProperties_.Opacity.Start.Lower);
				nUpperStartOpacity = Number(xmlParticleProperties_.Opacity.Start.Upper);
				nLowerEndOpacity = Number(xmlParticleProperties_.Opacity.End.Lower);
				nUpperEndOpacity = Number(xmlParticleProperties_.Opacity.End.Upper);
				nLowerStartScaleX = Number(xmlParticleProperties_.Scale.Start.LowerX);
				nLowerStartScaleY = Number(xmlParticleProperties_.Scale.Start.LowerY);
				nUpperStartScaleX = Number(xmlParticleProperties_.Scale.Start.UpperX);
				nUpperStartScaleY = Number(xmlParticleProperties_.Scale.Start.UpperY);
				nLowerEndScaleX = Number(xmlParticleProperties_.Scale.End.LowerX);
				nLowerEndScaleY = Number(xmlParticleProperties_.Scale.End.LowerY);
				nUpperEndScaleX = Number(xmlParticleProperties_.Scale.End.UpperX);
				nUpperEndScaleY = Number(xmlParticleProperties_.Scale.End.UpperY);
			}
		}
	}
}