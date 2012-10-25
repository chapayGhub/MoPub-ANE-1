﻿package
{
	import com.sticksports.nativeExtensions.mopub.MoPubBanner;
	import com.sticksports.nativeExtensions.mopub.MoPubEvent;
	import com.sticksports.nativeExtensions.mopub.MoPubSize;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	[SWF(width='320', height='480', frameRate='30', backgroundColor='#000000')]
	
	public class MoPubExtensionTest extends Sprite
	{
		private var direction : int = 1;
		private var shape : Shape;
		private var feedback : TextField;
		
		private var buttonFormat : TextFormat;
		
		private var banner : MoPubBanner;
		
		//iOS
		private var bannerUnitId : String = "agltb3B1Yi1pbmNyDQsSBFNpdGUYsK-hFgw";
		// Android
		//private var bannerUnitId : String = "28e6224444b94a72";
		
		public function MoPubExtensionTest()
		{
			shape = new Shape();
			shape.graphics.beginFill( 0x666666 );
			shape.graphics.drawCircle( 0, 0, 100 );
			shape.graphics.endFill();
			shape.x = 0;
			shape.y = 240;
			addChild( shape );
			
			feedback = new TextField();
			var format : TextFormat = new TextFormat();
			format.font = "_sans";
			format.size = 16;
			format.color = 0xFFFFFF;
			feedback.defaultTextFormat = format;
			feedback.width = 320;
			feedback.height = 260;
			feedback.x = 10;
			feedback.y = 230;
			feedback.multiline = true;
			feedback.wordWrap = true;
			feedback.text = "Hello";
			addChild( feedback );
			
			createButtons();
			
			addEventListener( Event.ENTER_FRAME, animate );
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
		}
		
		private function createButtons() : void
		{
			var tf : TextField = createButton( "createBanner" );
			tf.x = 10;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, createBanner );
			addChild( tf );
			
			tf = createButton( "loadBanner" );
			tf.x = 170;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, loadBanner );
			addChild( tf );
			
			tf = createButton( "showBanner" );
			tf.x = 10;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, showBanner );
			addChild( tf );
			
			tf = createButton( "removeBanner" );
			tf.x = 170;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, removeBanner );
			addChild( tf );
			
			tf = createButton( "releaseBanner" );
			tf.x = 10;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, releaseBanner );
			addChild( tf );
			
			tf = createButton( "getDisplayDensity" );
			tf.x = 10;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, getDisplayDensity );
			addChild( tf );
		}
		
		private function createButton( label : String ) : TextField
		{
			if( !buttonFormat )
			{
				buttonFormat = new TextFormat();
				buttonFormat.font = "_sans";
				buttonFormat.size = 14;
				buttonFormat.bold = true;
				buttonFormat.color = 0xFFFFFF;
				buttonFormat.align = TextFormatAlign.CENTER;
			}
			
			var textField : TextField = new TextField();
			textField.defaultTextFormat = buttonFormat;
			textField.width = 140;
			textField.height = 30;
			textField.text = label;
			textField.backgroundColor = 0xCC0000;
			textField.background = true;
			textField.selectable = false;
			textField.multiline = false;
			textField.wordWrap = false;
			return textField;
		}
		
		private function createBanner( event : MouseEvent ) : void
		{
			feedback.text = "new MoPubBanner( bannerUnitId, MoPubSize.banner );";
			banner = new MoPubBanner( bannerUnitId, MoPubSize.banner );
			trace( "1. banner", banner );
			banner.x = 0;
			banner.y = 300;
			banner.load();
			trace( "2. banner", banner );
		}
		
		private function loadBanner( event : MouseEvent ) : void
		{
			feedback.text = "banner.load();";
			trace( "3. banner", banner );
			setBannerListeners( banner );
			banner.load();
		}
				
		private function showBanner( event : MouseEvent ) : void
		{
			feedback.text = "banner.show();";
			banner.show();
		}
				
		private function removeBanner( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.remove();" );
			banner.remove();
		}
				
		private function releaseBanner( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner = null;" );
			banner = null;
		}
		
		private function getDisplayDensity( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.displayDensity = " + banner.displayDensity );
			banner = null;
		}
		
		private function setBannerListeners( banner : MoPubBanner ) : void
		{
			trace( "4. banner", banner );
			banner.addEventListener( MoPubEvent.LOADED, adLoaded );
			banner.addEventListener( MoPubEvent.LOAD_FAILED, adFailed );
		}
		
		private function adLoaded( event : MoPubEvent ) : void
		{
			feedback.appendText( "\n  MoPubEvent.LOADED" );
		}
		
		private function adFailed( event : MoPubEvent ) : void
		{
			feedback.appendText( "\n  MoPubEvent.LOAD_FAILED" );
		}
				
		private function animate( event : Event ) : void
		{
			shape.x += direction;
			if( shape.x <= 0 )
			{
				direction = 1;
			}
			if( shape.x > 320 )
			{
				direction = -1;
			}
		}
	}
}