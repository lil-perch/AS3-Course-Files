package
{
	
	import flash.text.*;
	import flash.display.*;
	
	import src.pages.utils.*;
	
	public class App extends MovieClip
	{
		public var presentSizeH;
		public var presentSizeW;			
		public var currentPageTag;
		
		public function App()
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			currentPageTag = MovieClip(this.parent).currentPageTag;
			hideAll();
		}
		
		public function initApplication(iTitle :String,
										iText :String,
										iMP3 :String,
										mainTitle :String,
										mainText :String,
										imgURL :String,
										imgPlace :String,
										mainMP3 :String,
										feedbackTitle :String,
										feedbackText :String,
										fImgURL :String,
										fImgPlace :String,
										feedbackMP3 :String,
										link :String)
		{
			presentSizeH = MovieClip(this.parent).presentSizeH
			presentSizeW = MovieClip(this.parent).presentSizeW				
			initStage1();			
			
			intro_mc.init(iTitle, iText, iMP3);						
			stage2_mc.init(mainTitle, mainText, imgURL, imgPlace, mainMP3);			
			stage3_mc.init(feedbackTitle, feedbackText, fImgURL, fImgPlace, feedbackMP3, link);
		}
		
		public function hideAll() 
		{
			intro_mc.visible = false;
			black_mc.visible = false;
			stage2_mc.visible = false;
			stage3_mc.visible = false;
		}	
		
		public function initStage1()
		{			
		
			// COLORS			
			Events.setColor(MovieClip(this.parent).currentPageTag.color[0].@button_over,MovieClip(this.parent).currentPageTag.color[0].@button);				
			
			var colors;								
			if (  ("@bg_color1" in MovieClip(this.parent).currentPageTag.color[0]) && ("@bg_color2 " in MovieClip(this.parent).currentPageTag.color[0]))
			{				
				colors = [Number(MovieClip(this.parent).currentPageTag.color[0]. @ bg_color1),Number(MovieClip(this.parent).currentPageTag.color[0]. @ bg_color2)];				
				Colorize.FillRadial(bg_mc,colors);								
			}
		
			intro_mc.x = presentSizeW / 2 - intro_mc.bg_mc.width / 2;
			intro_mc.y = presentSizeH / 2 - intro_mc.bg_mc.height / 2;
			
			stage3_mc.x = presentSizeW / 2 - stage3_mc.width / 2;
			stage3_mc.y = presentSizeH / 2 - stage3_mc.height / 2;
	
			black_mc.width = presentSizeW;
			black_mc.height = presentSizeH;										
			
						
			bg_mc.width = presentSizeW;
			bg_mc.height = presentSizeH;
			bg_mc2.width = presentSizeW;
			bg_mc2.height = presentSizeH;							
			intro_mc.visible = true;
			black_mc.visible = true;
			stage2_mc.visible = false;
			stage3_mc.visible = false;
			
			intro_mc.showWindow();
		}
		
		public function initStage2() 
		{
			trace("INISTT 2")
			intro_mc.visible = false;
			black_mc.visible = false;
			stage2_mc.visible = true;
			stage3_mc.visible = false;		
			stage2_mc.showWindow();
		}
		
		public function initStage3() 
		{
			trace("INT STAGE 3")
			intro_mc.visible = false;
			black_mc.visible = false;
			stage2_mc.visible = false;
			stage3_mc.visible = true;
			
			stage2_mc.hideWindow();
			stage3_mc.showWindow();
		}
	}
	
}