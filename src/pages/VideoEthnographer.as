﻿package src.pages
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import fl.controls.*;
	import fl.motion.Source;
	import fl.video.*;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.media.*;
	import flash.net.*;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.utils.Timer;
	//import flash.media.SoundMixer;  
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import src.com.Buttons;
	import src.pages.DynamicPageAPI;

	public class VideoEthnographer extends DynamicPageAPI
	{
		public var testButton:MovieClip;
		public var projectorBack:MovieClip;
		public var bottomBar:MovieClip;
		
		//Text Field Variables
		public var drName:TextField;
		public var textPageName:TextField;
		public var nameLabel:TextField;
		public var titleLabel:TextField;
		public var remarksLabel:TextField;
		public var contactLabel:TextField;
		public var langAreaText:TextField;
		public var nameText:TextField;
		public var titleText:TextField;
		public var remarksText:TextField;
		public var contactText:TextField;
		
		//Variables for buttons
		public var drButton1:MovieClip;
		public var drButton2:MovieClip;
		public var drButton3:MovieClip;
		public var drButton4:MovieClip;
		public var drButton5:MovieClip;
		public var drButton6:MovieClip;
		
		//Links Video
		public var fader:MovieClip;
		public var linksVideo:MovieClip;
		public var linksImage:MovieClip;
		public var linksSWF:MovieClip;
		
		//Lang variable this is to be able to tell which content your on so lang can pull it in. 
		public var pers1Lang:Boolean;
		public var pers2Lang:Boolean;
		public var pers3Lang:Boolean;
		public var pers4Lang:Boolean;
		public var pers5Lang:Boolean;
		public var pers6Lang:Boolean;
		
		//Adding Tab Backs
		public var tab2BackMC:tab2Back = new tab2Back;
		public var tab3BackMC:tab3back = new tab3back;
		public var tab4BackMC:tab4Back = new tab4Back;
		public var tab6BackMC:tab6Back = new tab6Back;
		
		//Add Media Tabs
		public var tab2Media:tab2MediaMC = new tab2MediaMC;
		public var tab3Media:tab3MediaMC = new tab3MediaMC;
		public var tab4Media:tab4MediaMC = new tab4MediaMC;
		//public var tab6Media:tab6MediaMC = new tab6MediaMC;
		
		//String for URLS
		public var hyperLink1Content:String;
		public var hyperLink2Content:String;
		public var hyperLink3Content:String;
		public var hyperLink4Content:String;
		public var hyperLink5Content:String;
		public var hyperLink6Content:String;
		public var hyperLink7Content:String;
		public var hyperLink8Content:String;
		public var hyperLink9Content:String;
		public var hyperLink10Content:String;
		public var hyperLink11Content:String;
		public var hyperLink12Content:String;
		
		//Strings for Docs
		public var docLink1Content:String;
		public var docLink2Content:String;
		public var docLink3Content:String;
		public var docLink4Content:String;
		public var docLink5Content:String;
		public var docLink6Content:String;
		
		//Strings for links to videos
		public var mediaLink1Content:String;
		public var mediaLink2Content:String;
		public var mediaLink3Content:String;
		public var mediaLink4Content:String;
		public var mediaLink5Content:String;
		public var mediaLink6Content:String;
		
		//String for media video or audio
		public var audioOrVideo:String;
		public var audioOrVideo2:String;
		public var audioOrVideo3:String;
		public var audioOrVideo4:String;
		public var audioOrVideo5:String;
		public var audioOrVideo6:String;
		
		/*public var soundClip:Sound = new Sound();
		public var sndChannel:SoundChannel = new SoundChannel();*/
		
		//Sound Variables
		public var soundFile1:Sound;
		public var sndChannel1:SoundChannel;
		public var soundFile2:Sound;
		public var sndChannel2:SoundChannel;
		public var soundFile3:Sound;
		public var sndChannel3:SoundChannel;
		public var soundFile4:Sound;
		public var sndChannel4:SoundChannel;
		public var soundFile5:Sound;
		public var sndChannel5:SoundChannel;
		public var soundFile6:Sound;
		public var sndChannel6:SoundChannel;
		
		//Video Variables
		public var videoLinksVid = new FLVPlayback();
		
		//Which perspective
		public var pers:String;
		public var pers2:String;
		public var pers3:String;
		public var pers4:String;
		public var pers5:String;
		public var pers6:String;
		
		//Hyper link locations
		//Adding Pers 1 Content Variables
		public var pers1Hyper1:String;
		public var pers1Hyper2:String;
		public var pers1Hyper3:String;
		public var pers1Hyper4:String;
		public var pers1Hyper5:String;
		public var pers1Hyper6:String;
		public var pers1Hyper7:String;
		public var pers1Hyper8:String;
		public var pers1Hyper9:String;
		public var pers1Hyper10:String;
		public var pers1Hyper11:String;
		public var pers1Hyper12:String;
		
		//Adding Pers 2 Content Variables
		public var pers2Hyper1:String;
		public var pers2Hyper2:String;
		public var pers2Hyper3:String;
		public var pers2Hyper4:String;
		public var pers2Hyper5:String;
		public var pers2Hyper6:String;
		public var pers2Hyper7:String;
		public var pers2Hyper8:String;
		public var pers2Hyper9:String;
		public var pers2Hyper10:String;
		public var pers2Hyper11:String;
		public var pers2Hyper12:String;
		
		//Adding Pers 3 Content Variables
		public var pers3Hyper1:String;
		public var pers3Hyper2:String;
		public var pers3Hyper3:String;
		public var pers3Hyper4:String;
		public var pers3Hyper5:String;
		public var pers3Hyper6:String;
		public var pers3Hyper7:String;
		public var pers3Hyper8:String;
		public var pers3Hyper9:String;
		public var pers3Hyper10:String;
		public var pers3Hyper11:String;
		public var pers3Hyper12:String;
		
		//Adding Pers 4 Content Variables
		public var pers4Hyper1:String;
		public var pers4Hyper2:String;
		public var pers4Hyper3:String;
		public var pers4Hyper4:String;
		public var pers4Hyper5:String;
		public var pers4Hyper6:String;
		public var pers4Hyper7:String;
		public var pers4Hyper8:String;
		public var pers4Hyper9:String;
		public var pers4Hyper10:String;
		public var pers4Hyper11:String;
		public var pers4Hyper12:String;
		
		//Adding Pers 5 Content Variables
		public var pers5Hyper1:String;
		public var pers5Hyper2:String;
		public var pers5Hyper3:String;
		public var pers5Hyper4:String;
		public var pers5Hyper5:String;
		public var pers5Hyper6:String;
		public var pers5Hyper7:String;
		public var pers5Hyper8:String;
		public var pers5Hyper9:String;
		public var pers5Hyper10:String;
		public var pers5Hyper11:String;
		public var pers5Hyper12:String;
		
		//Adding Pers 6 Content Variables
		public var pers6Hyper1:String;
		public var pers6Hyper2:String;
		public var pers6Hyper3:String;
		public var pers6Hyper4:String;
		public var pers6Hyper5:String;
		public var pers6Hyper6:String;
		public var pers6Hyper7:String;
		public var pers6Hyper8:String;
		public var pers6Hyper9:String;
		public var pers6Hyper10:String;
		public var pers6Hyper11:String;
		public var pers6Hyper12:String;
		
		//Adding Pers 1 Title Links 
		public var pers1Hyper1Title:String;
		public var pers1Hyper2Title:String;
		public var pers1Hyper3Title:String;
		public var pers1Hyper4Title:String;
		public var pers1Hyper5Title:String;
		public var pers1Hyper6Title:String;
		public var pers1Hyper7Title:String;
		public var pers1Hyper8Title:String;
		public var pers1Hyper9Title:String;
		public var pers1Hyper10Title:String;
		public var pers1Hyper11Title:String;
		public var pers1Hyper12Title:String;
		
		//Adding Pers 2 Title Links 
		public var pers2Hyper1Title:String;
		public var pers2Hyper2Title:String;
		public var pers2Hyper3Title:String;
		public var pers2Hyper4Title:String;
		public var pers2Hyper5Title:String;
		public var pers2Hyper6Title:String;
		public var pers2Hyper7Title:String;
		public var pers2Hyper8Title:String;
		public var pers2Hyper9Title:String;
		public var pers2Hyper10Title:String;
		public var pers2Hyper11Title:String;
		public var pers2Hyper12Title:String;
		
		//Adding Pers 3 Title Links 
		public var pers3Hyper1Title:String;
		public var pers3Hyper2Title:String;
		public var pers3Hyper3Title:String;
		public var pers3Hyper4Title:String;
		public var pers3Hyper5Title:String;
		public var pers3Hyper6Title:String;
		public var pers3Hyper7Title:String;
		public var pers3Hyper8Title:String;
		public var pers3Hyper9Title:String;
		public var pers3Hyper10Title:String;
		public var pers3Hyper11Title:String;
		public var pers3Hyper12Title:String;
		
		//Adding Pers 4 Title Links 
		public var pers4Hyper1Title:String;
		public var pers4Hyper2Title:String;
		public var pers4Hyper3Title:String;
		public var pers4Hyper4Title:String;
		public var pers4Hyper5Title:String;
		public var pers4Hyper6Title:String;
		public var pers4Hyper7Title:String;
		public var pers4Hyper8Title:String;
		public var pers4Hyper9Title:String;
		public var pers4Hyper10Title:String;
		public var pers4Hyper11Title:String;
		public var pers4Hyper12Title:String;
		
		//Adding Pers 5 Title Links 
		public var pers5Hyper1Title:String;
		public var pers5Hyper2Title:String;
		public var pers5Hyper3Title:String;
		public var pers5Hyper4Title:String;
		public var pers5Hyper5Title:String;
		public var pers5Hyper6Title:String;
		public var pers5Hyper7Title:String;
		public var pers5Hyper8Title:String;
		public var pers5Hyper9Title:String;
		public var pers5Hyper10Title:String;
		public var pers5Hyper11Title:String;
		public var pers5Hyper12Title:String;
		
		//Adding Pers 6 Title Links 
		public var pers6Hyper1Title:String;
		public var pers6Hyper2Title:String;
		public var pers6Hyper3Title:String;
		public var pers6Hyper4Title:String;
		public var pers6Hyper5Title:String;
		public var pers6Hyper6Title:String;
		public var pers6Hyper7Title:String;
		public var pers6Hyper8Title:String;
		public var pers6Hyper9Title:String;
		public var pers6Hyper10Title:String;
		public var pers6Hyper11Title:String;
		public var pers6Hyper12Title:String;
		
		//Adding Pers 1 Descr 
		public var pers1Hyper1Desc:String;
		public var pers1Hyper2Desc:String;
		public var pers1Hyper3Desc:String;
		public var pers1Hyper4Desc:String;
		public var pers1Hyper5Desc:String;
		public var pers1Hyper6Desc:String;
		public var pers1Hyper7Desc:String;
		public var pers1Hyper8Desc:String;
		public var pers1Hyper9Desc:String;
		public var pers1Hyper10Desc:String;
		public var pers1Hyper11Desc:String;
		public var pers1Hyper12Desc:String;
		
		//Adding Pers 2 Descr 
		public var pers2Hyper1Desc:String;
		public var pers2Hyper2Desc:String;
		public var pers2Hyper3Desc:String;
		public var pers2Hyper4Desc:String;
		public var pers2Hyper5Desc:String;
		public var pers2Hyper6Desc:String;
		public var pers2Hyper7Desc:String;
		public var pers2Hyper8Desc:String;
		public var pers2Hyper9Desc:String;
		public var pers2Hyper10Desc:String;
		public var pers2Hyper11Desc:String;
		public var pers2Hyper12Desc:String;
		
		//Adding Pers 3 Descr 
		public var pers3Hyper1Desc:String;
		public var pers3Hyper2Desc:String;
		public var pers3Hyper3Desc:String;
		public var pers3Hyper4Desc:String;
		public var pers3Hyper5Desc:String;
		public var pers3Hyper6Desc:String;
		public var pers3Hyper7Desc:String;
		public var pers3Hyper8Desc:String;
		public var pers3Hyper9Desc:String;
		public var pers3Hyper10Desc:String;
		public var pers3Hyper11Desc:String;
		public var pers3Hyper12Desc:String;
		
		//Adding Pers 4 Descr 
		public var pers4Hyper1Desc:String;
		public var pers4Hyper2Desc:String;
		public var pers4Hyper3Desc:String;
		public var pers4Hyper4Desc:String;
		public var pers4Hyper5Desc:String;
		public var pers4Hyper6Desc:String;
		public var pers4Hyper7Desc:String;
		public var pers4Hyper8Desc:String;
		public var pers4Hyper9Desc:String;
		public var pers4Hyper10Desc:String;
		public var pers4Hyper11Desc:String;
		public var pers4Hyper12Desc:String;
		
		//Adding Pers 5 Descr 
		public var pers5Hyper1Desc:String;
		public var pers5Hyper2Desc:String;
		public var pers5Hyper3Desc:String;
		public var pers5Hyper4Desc:String;
		public var pers5Hyper5Desc:String;
		public var pers5Hyper6Desc:String;
		public var pers5Hyper7Desc:String;
		public var pers5Hyper8Desc:String;
		public var pers5Hyper9Desc:String;
		public var pers5Hyper10Desc:String;
		public var pers5Hyper11Desc:String;
		public var pers5Hyper12Desc:String;
		
		//Adding Pers 6 Descr 
		public var pers6Hyper1Desc:String;
		public var pers6Hyper2Desc:String;
		public var pers6Hyper3Desc:String;
		public var pers6Hyper4Desc:String;
		public var pers6Hyper5Desc:String;
		public var pers6Hyper6Desc:String;
		public var pers6Hyper7Desc:String;
		public var pers6Hyper8Desc:String;
		public var pers6Hyper9Desc:String;
		public var pers6Hyper10Desc:String;
		public var pers6Hyper11Desc:String;
		public var pers6Hyper12Desc:String;
		
		//Adding Doc Location
		public var pers1Doc1:String;
		public var pers1Doc2:String;
		public var pers1Doc3:String;
		public var pers1Doc4:String;
		public var pers1Doc5:String;
		public var pers1Doc6:String;
		
		public var pers2Doc1:String;
		public var pers2Doc2:String;
		public var pers2Doc3:String;
		public var pers2Doc4:String;
		public var pers2Doc5:String;
		public var pers2Doc6:String;
		
		public var pers3Doc1:String;
		public var pers3Doc2:String;
		public var pers3Doc3:String;
		public var pers3Doc4:String;
		public var pers3Doc5:String;
		public var pers3Doc6:String;
		
		public var pers4Doc1:String;
		public var pers4Doc2:String;
		public var pers4Doc3:String;
		public var pers4Doc4:String;
		public var pers4Doc5:String;
		public var pers4Doc6:String;
		
		public var pers5Doc1:String;
		public var pers5Doc2:String;
		public var pers5Doc3:String;
		public var pers5Doc4:String;
		public var pers5Doc5:String;
		public var pers5Doc6:String;
		
		public var pers6Doc1:String;
		public var pers6Doc2:String;
		public var pers6Doc3:String;
		public var pers6Doc4:String;
		public var pers6Doc5:String;
		public var pers6Doc6:String;
		
		//Settings for Doc Title
		
		public var pers1Doc1Title:String;
		public var pers1Doc2Title:String;
		public var pers1Doc3Title:String;
		public var pers1Doc4Title:String;
		public var pers1Doc5Title:String;
		public var pers1Doc6Title:String;
		
		public var pers2Doc1Title:String;
		public var pers2Doc2Title:String;
		public var pers2Doc3Title:String;
		public var pers2Doc4Title:String;
		public var pers2Doc5Title:String;
		public var pers2Doc6Title:String;

		public var pers3Doc1Title:String;
		public var pers3Doc2Title:String;
		public var pers3Doc3Title:String;
		public var pers3Doc4Title:String;
		public var pers3Doc5Title:String;
		public var pers3Doc6Title:String;

		public var pers4Doc1Title:String;
		public var pers4Doc2Title:String;
		public var pers4Doc3Title:String;
		public var pers4Doc4Title:String;
		public var pers4Doc5Title:String;
		public var pers4Doc6Title:String;
		
		public var pers5Doc1Title:String;
		public var pers5Doc2Title:String;
		public var pers5Doc3Title:String;
		public var pers5Doc4Title:String;
		public var pers5Doc5Title:String;
		public var pers5Doc6Title:String;
		
		public var pers6Doc1Title:String;
		public var pers6Doc2Title:String;
		public var pers6Doc3Title:String;
		public var pers6Doc4Title:String;
		public var pers6Doc5Title:String;
		public var pers6Doc6Title:String;
		
		//Variables for doc descrptions
		public var pers1Doc1Desc:String;
		public var pers1Doc2Desc:String;
		public var pers1Doc3Desc:String;
		public var pers1Doc4Desc:String;
		public var pers1Doc5Desc:String;
		public var pers1Doc6Desc:String;
		
		public var pers2Doc1Desc:String;
		public var pers2Doc2Desc:String;
		public var pers2Doc3Desc:String;
		public var pers2Doc4Desc:String;
		public var pers2Doc5Desc:String;
		public var pers2Doc6Desc:String;
		
		public var pers3Doc1Desc:String;
		public var pers3Doc2Desc:String;
		public var pers3Doc3Desc:String;
		public var pers3Doc4Desc:String;
		public var pers3Doc5Desc:String;
		public var pers3Doc6Desc:String;
		
		public var pers4Doc1Desc:String;
		public var pers4Doc2Desc:String;
		public var pers4Doc3Desc:String;
		public var pers4Doc4Desc:String;
		public var pers4Doc5Desc:String;
		public var pers4Doc6Desc:String;
		
		public var pers5Doc1Desc:String;
		public var pers5Doc2Desc:String;
		public var pers5Doc3Desc:String;
		public var pers5Doc4Desc:String;
		public var pers5Doc5Desc:String;
		public var pers5Doc6Desc:String;
		
		public var pers6Doc1Desc:String;
		public var pers6Doc2Desc:String;
		public var pers6Doc3Desc:String;
		public var pers6Doc4Desc:String;
		public var pers6Doc5Desc:String;
		public var pers6Doc6Desc:String;
		
		//Settings for Media Content
		public var pers1Media1:String;
		public var pers1Media2:String;
		public var pers1Media3:String;
		public var pers1Media4:String;
		public var pers1Media5:String;
		public var pers1Media6:String;
		
		public var pers2Media1:String;
		public var pers2Media2:String;
		public var pers2Media3:String;
		public var pers2Media4:String;
		public var pers2Media5:String;
		public var pers2Media6:String;
		
		public var pers3Media1:String;
		public var pers3Media2:String;
		public var pers3Media3:String;
		public var pers3Media4:String;
		public var pers3Media5:String;
		public var pers3Media6:String;
		
		public var pers4Media1:String;
		public var pers4Media2:String;
		public var pers4Media3:String;
		public var pers4Media4:String;
		public var pers4Media5:String;
		public var pers4Media6:String;
		
		public var pers5Media1:String;
		public var pers5Media2:String;
		public var pers5Media3:String;
		public var pers5Media4:String;
		public var pers5Media5:String;
		public var pers5Media6:String;
		
		public var pers6Media1:String;
		public var pers6Media2:String;
		public var pers6Media3:String;
		public var pers6Media4:String;
		public var pers6Media5:String;
		public var pers6Media6:String;
		
		//Settings for Media Title
		public var pers1Media1Title:String;
		public var pers1Media2Title:String;
		public var pers1Media3Title:String;
		public var pers1Media4Title:String;
		public var pers1Media5Title:String;
		public var pers1Media6Title:String;
		
		public var pers2Media1Title:String;
		public var pers2Media2Title:String;
		public var pers2Media3Title:String;
		public var pers2Media4Title:String;
		public var pers2Media5Title:String;
		public var pers2Media6Title:String;
		
		public var pers3Media1Title:String;
		public var pers3Media2Title:String;
		public var pers3Media3Title:String;
		public var pers3Media4Title:String;
		public var pers3Media5Title:String;
		public var pers3Media6Title:String;
		
		public var pers5Media1Title:String;
		public var pers5Media2Title:String;
		public var pers5Media3Title:String;
		public var pers5Media4Title:String;
		public var pers5Media5Title:String;
		public var pers5Media6Title:String;
		
		public var pers4Media1Title:String;
		public var pers4Media2Title:String;
		public var pers4Media3Title:String;
		public var pers4Media4Title:String;
		public var pers4Media5Title:String;
		public var pers4Media6Title:String;
		
		public var pers6Media1Title:String;
		public var pers6Media2Title:String;
		public var pers6Media3Title:String;
		public var pers6Media4Title:String;
		public var pers6Media5Title:String;
		public var pers6Media6Title:String;
		
		//Settings for media description
		public var pers1Media1Desc:String;
		public var pers1Media2Desc:String;
		public var pers1Media3Desc:String;
		public var pers1Media4Desc:String;
		public var pers1Media5Desc:String;
		public var pers1Media6Desc:String;
		
		public var pers2Media1Desc:String;
		public var pers2Media2Desc:String;
		public var pers2Media3Desc:String;
		public var pers2Media4Desc:String;
		public var pers2Media5Desc:String;
		public var pers2Media6Desc:String;
		
		public var pers3Media1Desc:String;
		public var pers3Media2Desc:String;
		public var pers3Media3Desc:String;
		public var pers3Media4Desc:String;
		public var pers3Media5Desc:String;
		public var pers3Media6Desc:String;
		
		public var pers4Media1Desc:String;
		public var pers4Media2Desc:String;
		public var pers4Media3Desc:String;
		public var pers4Media4Desc:String;
		public var pers4Media5Desc:String;
		public var pers4Media6Desc:String;
		
		public var pers5Media1Desc:String;
		public var pers5Media2Desc:String;
		public var pers5Media3Desc:String;
		public var pers5Media4Desc:String;
		public var pers5Media5Desc:String;
		public var pers5Media6Desc:String;
		
		public var pers6Media1Desc:String;
		public var pers6Media2Desc:String;
		public var pers6Media3Desc:String;
		public var pers6Media4Desc:String;
		public var pers6Media5Desc:String;
		public var pers6Media6Desc:String;
		
		public var vid:MovieClip;
		
		public var timerCount:Timer;
		
		public var tallytime:Number;
		public var percNeeded:Number;
		public var perToGoTo:Number;
		public var tallyCurrentTime:Number;
		
		public var timerAgainCount:Timer;
		
		//Audio Variable
		public var isAudioPlaying1:Boolean = false;
		public var isAudioPlaying2:Boolean = false;
		public var isAudioPlaying3:Boolean = false;
		public var isAudioPlaying4:Boolean = false;
		public var isAudioPlaying5:Boolean = false;
		public var isAudioPlaying6:Boolean = false;
		
		//Adding scroll bar element
		var lang1ScrollBar:UIScrollBar = new UIScrollBar();
		var lang2ScrollBar:UIScrollBar = new UIScrollBar();
		var lang3ScrollBar:UIScrollBar = new UIScrollBar();
		var lang4ScrollBar:UIScrollBar = new UIScrollBar();
		var lang5ScrollBar:UIScrollBar = new UIScrollBar();
		var lang6ScrollBar:UIScrollBar = new UIScrollBar();
		
		//hyperLink1Content = currentPageTag.perspectives.perspective1.hyperLink1.@linkLocation;
		
		//public var tab2:MovieClip;
		
		//Scroll in and our var
		public var scrollInOut:Boolean = true;
		
		//Stage size height and width
		private var _sizeH:Number;
		private var _sizeW:Number;
		
		//Video Connection Variables
		public var mainVid:FLVPlayback = new FLVPlayback();
		//public var persVid:FLVPlayback = new FLVPlayback();
		public var persPlay:Boolean;
		
		public var updatedTime:Number;
		
		public function VideoEthnographer()
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, stopAllVideos);
		}//End constructor
		
		override public function loadPage():void
		{
			SoundMixer.stopAll();
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			
			//Establish Page Title Name
			textPageName.text = currentPageTag.@title;
			
			// Establish Doctors Names
			drButton1.drName.htmlText = "<b>" + currentPageTag.perspectives.perspective1.@name + "</b>";
			drButton2.drName.htmlText = "<b>" + currentPageTag.perspectives.perspective2.@name + "</b>";
			drButton3.drName.htmlText = "<b>" + currentPageTag.perspectives.perspective3.@name + "</b>";
			drButton4.drName.htmlText = "<b>" + currentPageTag.perspectives.perspective4.@name + "</b>";
			drButton5.drName.htmlText = "<b>" + currentPageTag.perspectives.perspective5.@name + "</b>";
			drButton6.drName.htmlText = "<b>" + currentPageTag.perspectives.perspective6.@name + "</b>";
			
			if (currentPageTag.perspectives.perspective1.@name == currentPageTag.perspectives.perspective1.@nonexsistant || currentPageTag.perspectives.perspective1.@name + "" == ""){
				drButton1.visible = false;
			}
			if (currentPageTag.perspectives.perspective2.@name == currentPageTag.perspectives.perspective2.@nonexsistant || currentPageTag.perspectives.perspective2.@name + "" == ""){
				drButton2.visible = false;
			}
			if (currentPageTag.perspectives.perspective3.@name == currentPageTag.perspectives.perspective3.@nonexsistant || currentPageTag.perspectives.perspective3.@name + "" == ""){
				drButton3.visible = false;
			}
			if (currentPageTag.perspectives.perspective4.@name == currentPageTag.perspectives.perspective4.@nonexsistant || currentPageTag.perspectives.perspective4.@name + "" == ""){
				drButton4.visible = false;
			}
			if (currentPageTag.perspectives.perspective5.@name == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective5.@name + "" == ""){
				drButton5.visible = false;
			}
			if (currentPageTag.perspectives.perspective6.@name == currentPageTag.perspectives.perspective6.@nonexsistant || currentPageTag.perspectives.perspective6.@name + "" == ""){
				drButton6.visible = false;
			}
			
			// Load mainVideo
			loadIntialVideo();
			
			
		}// End loadPage
		
		public function stopAllVideos (e:Event):void{
			
			//linksVideo.videoLinksVid.stop();
			
			projectorBack.persVid.stop();
			
		}
		
		override public function get videoPage():Boolean
		{
			return true;
		}
		
		override public function get mediaPlayer():*
		{
			return vid.testVid;
		}
		
		public function loadIntialVideo (e:Event = null):void{
			// Hide Fader
			fader.visible = false
			linksVideo.visible = false
			//Setting Source of Video
			//mainVid.source = currentPageTag.@firstVid;
			
			vid.testVid.source = currentPageTag.@firstVid;
			
			// Setting dimensions of video
			//vid.width = currentPageTag.@mainVidWidth;
			//vid..height = currentPageTag.@mainVidHeight;
			
			// Centering main video in center of the stage
			vid.x = settingsModel.settings.presentSizeW /2 - vid.width /2;
			vid.y = settingsModel.settings.presentSizeH /2 - vid.height /2 + bottomBar.x + 10;
			//addChildAt(mainVid, 0);
			
			//Add Button Event listeners
			drButton1.addEventListener(MouseEvent.MOUSE_DOWN, scrollDownProjector);
			drButton2.addEventListener(MouseEvent.MOUSE_DOWN, scrollDownProjector);
			drButton3.addEventListener(MouseEvent.MOUSE_DOWN, scrollDownProjector);
			drButton4.addEventListener(MouseEvent.MOUSE_DOWN, scrollDownProjector);
			drButton5.addEventListener(MouseEvent.MOUSE_DOWN, scrollDownProjector);
			drButton6.addEventListener(MouseEvent.MOUSE_DOWN, scrollDownProjector);
			
			//Add Button Mouse Overs
			drButton1.addEventListener(MouseEvent.MOUSE_OVER, buttonOverEffect);
			drButton2.addEventListener(MouseEvent.MOUSE_OVER, buttonOverEffect);
			drButton3.addEventListener(MouseEvent.MOUSE_OVER, buttonOverEffect);
			drButton4.addEventListener(MouseEvent.MOUSE_OVER, buttonOverEffect);
			drButton5.addEventListener(MouseEvent.MOUSE_OVER, buttonOverEffect);
			drButton6.addEventListener(MouseEvent.MOUSE_OVER, buttonOverEffect);
			
			//Add Button Mouse Outs
			drButton1.addEventListener(MouseEvent.MOUSE_OUT, buttonOutEffect);
			drButton2.addEventListener(MouseEvent.MOUSE_OUT, buttonOutEffect);
			drButton3.addEventListener(MouseEvent.MOUSE_OUT, buttonOutEffect);
			drButton4.addEventListener(MouseEvent.MOUSE_OUT, buttonOutEffect);
			drButton5.addEventListener(MouseEvent.MOUSE_OUT, buttonOutEffect);
			drButton6.addEventListener(MouseEvent.MOUSE_OUT, buttonOutEffect);
			
			//Add Button Mode on all Dr Buttons
			drButton1.buttonMode = true;
			drButton2.buttonMode = true;
			drButton3.buttonMode = true;
			drButton4.buttonMode = true;
			drButton5.buttonMode = true;
			drButton6.buttonMode = true;
			
			//Add tabs
			projectorBack.langArea.addChildAt(tab2BackMC, 0);
			projectorBack.langArea.addChildAt(tab3BackMC, 0);
			projectorBack.langArea.addChildAt(tab4BackMC, 0);
			projectorBack.langArea.addChildAt(tab6BackMC, 0);
			
			//Add tab event listeners
			projectorBack.tab1.addEventListener(MouseEvent.MOUSE_DOWN, showLang);
			projectorBack.tab2.addEventListener(MouseEvent.MOUSE_DOWN, showLang);
			projectorBack.tab3.addEventListener(MouseEvent.MOUSE_DOWN, showLang);
			projectorBack.tab4.addEventListener(MouseEvent.MOUSE_DOWN, showLang);
			projectorBack.tab6.addEventListener(MouseEvent.MOUSE_DOWN, showLang);
		
		}// End loadIntialVideo
		
		//Mouse Over and Out for Doc
		public function buttonOverEffect(e:MouseEvent = null):void{
			if (e.currentTarget==drButton1){
				TweenMax.to(drButton1, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:.6}});
			} else if (e.currentTarget==drButton2){
				TweenMax.to(drButton2, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:.6}});
			} else if (e.currentTarget==drButton3){
				TweenMax.to(drButton3, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:.6}});
			} else if (e.currentTarget==drButton4){
				TweenMax.to(drButton4, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:.6}});
			} else if (e.currentTarget==drButton5){
				TweenMax.to(drButton5, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:.6}});
			} else if (e.currentTarget==drButton6){
				TweenMax.to(drButton6, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:.6}});
			}// end if statment
		}// End buttonOverEffect
		public function buttonOutEffect(e:MouseEvent = null):void{
			if (e.currentTarget==drButton1){
				TweenMax.to(drButton1, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:0}});
			} else if (e.currentTarget==drButton2){
				TweenMax.to(drButton2, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:0}});
			} else if (e.currentTarget==drButton3){
				TweenMax.to(drButton3, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:0}});
			} else if (e.currentTarget==drButton4){
				TweenMax.to(drButton4, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:0}});
			} else if (e.currentTarget==drButton5){
				TweenMax.to(drButton5, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:0}});
			} else if (e.currentTarget==drButton6){
				TweenMax.to(drButton6, .5, {colorMatrixFilter:{colorize:0xffffcc, amount:0}});
			}// end if statment
		}// End buttonOutEffect

		public function scrollDownProjector(e:MouseEvent = null):void {
			
			trace("SCROLL DOWN "+e.currentTarget.name);
			
			
			
			/********************* CUSTOMIZED ***********************************/
			
			//Hide media button if no content there.  Old way
			/*
			pers1Hyper1Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink1.@hyperTitle + "</b>";
			projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
			*/
						
			
			// New way to hide the Media Button					
			var index = e.currentTarget.name.split("drButton")[1]
			trace("index "+index)
			projectorBack.infoArea.mediaLinks.visible = (currentPageTag.perspectives["perspective"+index].@show_link == "true")?true:false;
			/********************* CUSTOMIZED ***********************************/
			
			
			
			//Hide main controls
			courseModel.mediaControlVisible = false;
			
			//Remove main vid and stop
			addChild(vid);
			vid.testVid.stop();
			removeChild(vid);
			
			//Show down on show links
			projectorBack.infoArea.transcriptBTN.gotoAndStop("over");
			projectorBack.infoArea.mediaLinks.gotoAndStop("up");
			
			//Set Tabs
			projectorBack.infoArea.setChildIndex(projectorBack.infoArea.transcriptBTN, 5);
			projectorBack.infoArea.setChildIndex(projectorBack.infoArea.mediaLinks, 4);
			//projectorBack.infoArea.transcriptBTN.mouse
			
			// Links Area
			projectorBack.linksArea.visible = false
			
			//Making movieclips act like buttons
			projectorBack.infoArea.mediaLinks.buttonMode = true;
			projectorBack.infoArea.transcriptBTN.buttonMode = true;
			
			//Dynamic Text Fields Labels
			projectorBack.infoArea.nameLabel.htmlText = "<b>" + currentPageTag.@nameLabel + "</b>";
			projectorBack.infoArea.titleLabel.htmlText = "<b>" + currentPageTag.@titleLabel + "</b>";
			projectorBack.infoArea.remarksLabel.htmlText = "<b>" + currentPageTag.@remarksLabel + "</b>";
			projectorBack.infoArea.contactLabel.htmlText = "<b>" + currentPageTag.@contactLabel + "</b>";
			
			//Add Tab Titles
			projectorBack.langArea.langTitle1.text = currentPageTag.perspectives.perspective1.@lang1;
			tab2BackMC.langTitle2.text = currentPageTag.perspectives.perspective1.@lang2;
			tab3BackMC.langTitle3.text = currentPageTag.perspectives.perspective1.@lang3;
			tab4BackMC.langTitle4.text = currentPageTag.perspectives.perspective1.@lang4;
			tab6BackMC.langTitle6.text = currentPageTag.perspectives.perspective1.@lang5;
			
			//Add Close btn listener
			bottomBar.closeProjBTN.addEventListener(MouseEvent.MOUSE_DOWN, scrollBackIn);
			
			//Remove media FLV Component
			linksVideo.videoLinksVid.visible = false;
			
			//Scroll in content
			if(scrollInOut){
				
				//Establish if statements for which button was clicked
				if(e.currentTarget==drButton1){
					//Setting pers for media
					pers = "perspective1";
					
					//Changing this to indent the button
					drButton1.gotoAndStop(2);
					drButton2.gotoAndStop(1);
					drButton3.gotoAndStop(1);
					drButton4.gotoAndStop(1);
					drButton5.gotoAndStop(1);
					drButton6.gotoAndStop(1);
					
					//Set Transcript Visible
					projectorBack.langArea.visible = true;
					projectorBack.linksArea.visible = false
					
					//Info text fields content
					projectorBack.infoArea.nameText.text = currentPageTag.perspectives.perspective1.@name;
					projectorBack.infoArea.titleText.text = currentPageTag.perspectives.perspective1.@caption;
					projectorBack.infoArea.remarksText.text = currentPageTag.perspectives.perspective1.@remarks;
					projectorBack.infoArea.contactText.text = currentPageTag.perspectives.perspective1.@contact;
					
					//Language Text Fields
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective1.language1;
					
					//Scroll Bar X and Y Values
					lang1ScrollBar.x = projectorBack.langArea.langAreaText.x + projectorBack.langArea.langAreaText.width + 3;
					lang1ScrollBar.y = projectorBack.langArea.langAreaText.y + 5;
					
					lang1ScrollBar.height = projectorBack.langArea.langAreaText.height;
					lang1ScrollBar.scrollTarget = projectorBack.langArea.langAreaText;
					projectorBack.langArea.addChild(lang1ScrollBar);
					
					lang1ScrollBar.update();
					
					//Establish the path
					projectorBack.persVid.source = currentPageTag.perspectives.perspective1.@persVid;
					
					//Establish which lang we are on. 
					pers1Lang = true;
					pers2Lang = false;
					pers3Lang = false;
					pers4Lang = false;
					pers5Lang = false;
					pers6Lang = false;
					
					//Change Tab Titles
					projectorBack.langArea.langTitle1.text = currentPageTag.perspectives.perspective1.@lang1;
					tab2BackMC.langTitle2.text = currentPageTag.perspectives.perspective1.@lang2;
					tab3BackMC.langTitle3.text = currentPageTag.perspectives.perspective1.@lang3;
					tab4BackMC.langTitle4.text = currentPageTag.perspectives.perspective1.@lang4;
					tab6BackMC.langTitle6.text = currentPageTag.perspectives.perspective1.@lang5;
					
					if (currentPageTag.perspectives.perspective1.@lang1 == currentPageTag.perspectives.perspective1.@nonexsistant || currentPageTag.perspectives.perspective1.@lang1 == ""){
						
					} else {
						
					}
					if (currentPageTag.perspectives.perspective1.@lang2 == currentPageTag.perspectives.perspective2.@nonexsistant || currentPageTag.perspectives.perspective1.@lang2 == ""){
						tab2BackMC.visible = false;
					} else {
						tab2BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective1.@lang3 == currentPageTag.perspectives.perspective3.@nonexsistant || currentPageTag.perspectives.perspective1.@lang3 == ""){
						tab3BackMC.visible = false;
					} else {
						tab3BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective1.@lang4 == currentPageTag.perspectives.perspective4.@nonexsistant || currentPageTag.perspectives.perspective1.@lang4 == ""){
						tab4BackMC.visible = false;
					} else {
						tab4BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective1.@lang5 == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective1.@lang5 == ""){
						tab6BackMC.visible = false;
					} else {
						tab6BackMC.visible = true;
					}
					
					
				} else if (e.currentTarget==drButton2){
					//Setting pers for media
					pers = "perspective2";
					
					//Changing this to indent the button
					drButton1.gotoAndStop(1);
					drButton2.gotoAndStop(2);
					drButton3.gotoAndStop(1);
					drButton4.gotoAndStop(1);
					drButton5.gotoAndStop(1);
					drButton6.gotoAndStop(1);
					
					//Set Transcript Visible
					projectorBack.langArea.visible = true;
					projectorBack.linksArea.visible = false
					
					//Info text fields content
					projectorBack.infoArea.nameText.text = currentPageTag.perspectives.perspective2.@name;
					projectorBack.infoArea.titleText.text = currentPageTag.perspectives.perspective2.@caption;
					projectorBack.infoArea.remarksText.text = currentPageTag.perspectives.perspective2.@remarks;
					projectorBack.infoArea.contactText.text = currentPageTag.perspectives.perspective2.@contact;
					
					//Language Text Fields
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective2.language1;
					
					//Establish the path
					projectorBack.persVid.source = currentPageTag.perspectives.perspective2.@persVid;
					
					//Update Scroll bar
					lang1ScrollBar.update();
					
					//Establish which lang we are on. 
					pers1Lang = false;
					pers2Lang = true;
					pers3Lang = false;
					pers4Lang = false;
					pers5Lang = false;
					pers6Lang = false;
					
					//Change Tab Titles
					projectorBack.langArea.langTitle1.text = currentPageTag.perspectives.perspective2.@lang1;
					tab2BackMC.langTitle2.text = currentPageTag.perspectives.perspective2.@lang2;
					tab3BackMC.langTitle3.text = currentPageTag.perspectives.perspective2.@lang3;
					tab4BackMC.langTitle4.text = currentPageTag.perspectives.perspective2.@lang4;
					tab6BackMC.langTitle6.text = currentPageTag.perspectives.perspective2.@lang5;
					
					if (currentPageTag.perspectives.perspective2.@lang1 == currentPageTag.perspectives.perspective1.@nonexsistant || currentPageTag.perspectives.perspective2.@lang1 == ""){
						
					}
					if (currentPageTag.perspectives.perspective2.@lang2 == currentPageTag.perspectives.perspective2.@nonexsistant || currentPageTag.perspectives.perspective2.@lang2 == ""){
						tab2BackMC.visible = false;
					} else {
						tab2BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective2.@lang3 == currentPageTag.perspectives.perspective3.@nonexsistant || currentPageTag.perspectives.perspective2.@lang3 == ""){
						tab3BackMC.visible = false;
					} else {
						tab3BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective2.@lang4 == currentPageTag.perspectives.perspective4.@nonexsistant || currentPageTag.perspectives.perspective2.@lang4 == ""){
						tab4BackMC.visible = false;
					} else {
						tab4BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective2.@lang5 == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective2.@lang5 == ""){
						tab6BackMC.visible = false;
					} else {
						tab6BackMC.visible = true;
					}
					
					
				} else if (e.currentTarget==drButton3){
					//Setting pers for media
					pers = "perspective3";
					
					//Changing this to indent the button
					drButton1.gotoAndStop(1);
					drButton2.gotoAndStop(1);
					drButton3.gotoAndStop(2);
					drButton4.gotoAndStop(1);
					drButton5.gotoAndStop(1);
					drButton6.gotoAndStop(1);
					
					//Set Transcript Visible
					projectorBack.langArea.visible = true;
					projectorBack.linksArea.visible = false
					
					//Info text fields content
					projectorBack.infoArea.nameText.text = currentPageTag.perspectives.perspective3.@name;
					projectorBack.infoArea.titleText.text = currentPageTag.perspectives.perspective3.@caption;
					projectorBack.infoArea.remarksText.text = currentPageTag.perspectives.perspective3.@remarks;
					projectorBack.infoArea.contactText.text = currentPageTag.perspectives.perspective3.@contact;
					
					//Language Text Fields
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective3.language1;
					
					//Establish the path
					projectorBack.persVid.source = currentPageTag.perspectives.perspective3.@persVid;
					
					//Update Scroll bar
					lang1ScrollBar.update();
					
					//Establish which lang we are on. 
					pers1Lang = false;
					pers2Lang = false;
					pers3Lang = true;
					pers4Lang = false;
					pers5Lang = false;
					pers6Lang = false;
					
					//Change Tab Titles
					projectorBack.langArea.langTitle1.text = currentPageTag.perspectives.perspective3.@lang1;
					tab2BackMC.langTitle2.text = currentPageTag.perspectives.perspective3.@lang2;
					tab3BackMC.langTitle3.text = currentPageTag.perspectives.perspective3.@lang3;
					tab4BackMC.langTitle4.text = currentPageTag.perspectives.perspective3.@lang4;
					tab6BackMC.langTitle6.text = currentPageTag.perspectives.perspective3.@lang5;
					
					if (currentPageTag.perspectives.perspective3.@lang1 == currentPageTag.perspectives.perspective1.@nonexsistant || currentPageTag.perspectives.perspective3.@lang1 == ""){
						
					}
					if (currentPageTag.perspectives.perspective3.@lang2 == currentPageTag.perspectives.perspective2.@nonexsistant || currentPageTag.perspectives.perspective3.@lang2 == ""){
						tab2BackMC.visible = false;
					} else {
						tab2BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective3.@lang3 == currentPageTag.perspectives.perspective3.@nonexsistant || currentPageTag.perspectives.perspective3.@lang3 == ""){
						tab3BackMC.visible = false;
					} else {
						tab3BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective3.@lang4 == currentPageTag.perspectives.perspective4.@nonexsistant || currentPageTag.perspectives.perspective3.@lang4 == ""){
						tab4BackMC.visible = false;
					} else {
						tab4BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective3.@lang5 == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective3.@lang5 == ""){
						tab6BackMC.visible = false;
					} else {
						tab6BackMC.visible = true;
					}
					
					
				} else if (e.currentTarget==drButton4){
					//Setting pers for media
					pers = "perspective4";
					
					//Changing this to indent the button
					drButton1.gotoAndStop(1);
					drButton2.gotoAndStop(1);
					drButton3.gotoAndStop(1);
					drButton4.gotoAndStop(2);
					drButton5.gotoAndStop(1);
					drButton6.gotoAndStop(1);
					
					//Set Transcript Visible
					projectorBack.langArea.visible = true;
					projectorBack.linksArea.visible = false
					
					//Info text fields content
					projectorBack.infoArea.nameText.text = currentPageTag.perspectives.perspective4.@name;
					projectorBack.infoArea.titleText.text = currentPageTag.perspectives.perspective4.@caption;
					projectorBack.infoArea.remarksText.text = currentPageTag.perspectives.perspective4.@remarks;
					projectorBack.infoArea.contactText.text = currentPageTag.perspectives.perspective4.@contact;
					
					//Language Text Fields
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective4.language1;
					
					//Establish the path
					projectorBack.persVid.source = currentPageTag.perspectives.perspective4.@persVid;
					
					//Update Scroll bar
					lang1ScrollBar.update();
					
					//Establish which lang we are on. 
					pers1Lang = false;
					pers2Lang = false;
					pers3Lang = false;
					pers4Lang = true;
					pers5Lang = false;
					pers6Lang = false;
					
					//Change Tab Titles
					projectorBack.langArea.langTitle1.text = currentPageTag.perspectives.perspective4.@lang1;
					tab2BackMC.langTitle2.text = currentPageTag.perspectives.perspective4.@lang2;
					tab3BackMC.langTitle3.text = currentPageTag.perspectives.perspective4.@lang3;
					tab4BackMC.langTitle4.text = currentPageTag.perspectives.perspective4.@lang4;
					tab6BackMC.langTitle6.text = currentPageTag.perspectives.perspective4.@lang5;
					
					if (currentPageTag.perspectives.perspective4.@lang1 == currentPageTag.perspectives.perspective1.@nonexsistant || currentPageTag.perspectives.perspective4.@lang1 == ""){
						
					}
					if (currentPageTag.perspectives.perspective4.@lang2 == currentPageTag.perspectives.perspective2.@nonexsistant || currentPageTag.perspectives.perspective4.@lang2 == ""){
						tab2BackMC.visible = false;
					} else {
						tab2BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective4.@lang3 == currentPageTag.perspectives.perspective3.@nonexsistant || currentPageTag.perspectives.perspective4.@lang3 == ""){
						tab3BackMC.visible = false;
					} else {
						tab3BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective4.@lang4 == currentPageTag.perspectives.perspective4.@nonexsistant || currentPageTag.perspectives.perspective4.@lang4 == ""){
						tab4BackMC.visible = false;
					} else {
						tab4BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective4.@lang5 == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective4.@lang5 == ""){
						tab6BackMC.visible = false;
					} else {
						tab6BackMC.visible = true;
					}
					
				} else if (e.currentTarget==drButton5){
					//Setting pers for media
					pers = "perspective5";
					
					//Changing this to indent the button
					drButton1.gotoAndStop(1);
					drButton2.gotoAndStop(1);
					drButton3.gotoAndStop(1);
					drButton4.gotoAndStop(1);
					drButton5.gotoAndStop(2);
					drButton6.gotoAndStop(1);
					
					//Set Transcript Visible
					projectorBack.langArea.visible = true;
					projectorBack.linksArea.visible = false
					
					//Info text fields content
					projectorBack.infoArea.nameText.text = currentPageTag.perspectives.perspective5.@name;
					projectorBack.infoArea.titleText.text = currentPageTag.perspectives.perspective5.@caption;
					projectorBack.infoArea.remarksText.text = currentPageTag.perspectives.perspective5.@remarks;
					projectorBack.infoArea.contactText.text = currentPageTag.perspectives.perspective5.@contact;
					
					//Language Text Fields
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective5.language1;
					
					//Establish the path
					projectorBack.persVid.source = currentPageTag.perspectives.perspective5.@persVid;
					
					//Update Scroll bar
					lang1ScrollBar.update();
					
					//Establish which lang we are on. 
					pers1Lang = false;
					pers2Lang = false;
					pers3Lang = false;
					pers4Lang = false;
					pers5Lang = true;
					pers6Lang = false;
					
					//Change Tab Titles
					projectorBack.langArea.langTitle1.text = currentPageTag.perspectives.perspective5.@lang1;
					tab2BackMC.langTitle2.text = currentPageTag.perspectives.perspective5.@lang2;
					tab3BackMC.langTitle3.text = currentPageTag.perspectives.perspective5.@lang3;
					tab4BackMC.langTitle4.text = currentPageTag.perspectives.perspective5.@lang4;
					tab6BackMC.langTitle6.text = currentPageTag.perspectives.perspective5.@lang5;
					
					if (currentPageTag.perspectives.perspective5.@lang1 == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective5.@lang1 == ""){
						
					}
					if (currentPageTag.perspectives.perspective5.@lang2 == currentPageTag.perspectives.perspective2.@nonexsistant || currentPageTag.perspectives.perspective5.@lang2 == ""){
						tab2BackMC.visible = false;
					} else {
						tab2BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective5.@lang3 == currentPageTag.perspectives.perspective3.@nonexsistant || currentPageTag.perspectives.perspective5.@lang3 == ""){
						tab3BackMC.visible = false;
					} else {
						tab3BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective5.@lang4 == currentPageTag.perspectives.perspective4.@nonexsistant || currentPageTag.perspectives.perspective5.@lang4 == ""){
						tab4BackMC.visible = false;
					} else {
						tab4BackMC.visible = true;
					}
					if (currentPageTag.perspectives.perspective5.@lang5 == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective5.@lang5 == ""){
						tab6BackMC.visible = false;
					} else {
						tab6BackMC.visible = true;
					}
					
					
				} else if (e.currentTarget==drButton6){
					//Setting pers for media
					pers = "perspective6";
					
					//Changing this to indent the button
					drButton1.gotoAndStop(1);
					drButton2.gotoAndStop(1);
					drButton3.gotoAndStop(1);
					drButton4.gotoAndStop(1);
					drButton5.gotoAndStop(1);
					drButton6.gotoAndStop(2);
					
					//Set Transcript Visible
					projectorBack.langArea.visible = true;
					projectorBack.linksArea.visible = false
					
					//Info text fields content
					projectorBack.infoArea.nameText.text = currentPageTag.perspectives.perspective6.@name;
					projectorBack.infoArea.titleText.text = currentPageTag.perspectives.perspective6.@caption;
					projectorBack.infoArea.remarksText.text = currentPageTag.perspectives.perspective6.@remarks;
					projectorBack.infoArea.contactText.text = currentPageTag.perspectives.perspective6.@contact;
					
					//Language Text Fields
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective6.language1;
					
					//Establish the path
					projectorBack.persVid.source = currentPageTag.perspectives.perspective6.@persVid;
					
					//Update Scroll bar
					lang1ScrollBar.update();
					
					//Establish which lang we are on. 
					pers1Lang = false;
					pers2Lang = false;
					pers3Lang = false;
					pers4Lang = false;
					pers5Lang = false;
					pers6Lang = true;
					
					//Change Tab Titles
					projectorBack.langArea.langTitle1.text = currentPageTag.perspectives.perspective6.@lang1;
					tab2BackMC.langTitle2.text = currentPageTag.perspectives.perspective6.@lang2;
					tab3BackMC.langTitle3.text = currentPageTag.perspectives.perspective6.@lang3;
					tab4BackMC.langTitle4.text = currentPageTag.perspectives.perspective6.@lang4;
					tab6BackMC.langTitle6.text = currentPageTag.perspectives.perspective6.@lang5;
					
					if (currentPageTag.perspectives.perspective6.@lang1 == currentPageTag.perspectives.perspective1.@nonexsistant || currentPageTag.perspectives.perspective6.@lang1 == ""){
						
					}
					if (currentPageTag.perspectives.perspective6.@lang2 == currentPageTag.perspectives.perspective2.@nonexsistant || currentPageTag.perspectives.perspective6.@lang2 == ""){
						tab2BackMC.visible = false;
					}
					if (currentPageTag.perspectives.perspective6.@lang3 == currentPageTag.perspectives.perspective3.@nonexsistant || currentPageTag.perspectives.perspective6.@lang3 == ""){
						tab3BackMC.visible = false;
					}
					if (currentPageTag.perspectives.perspective6.@lang4 == currentPageTag.perspectives.perspective4.@nonexsistant || currentPageTag.perspectives.perspective6.@lang4 == ""){
						tab4BackMC.visible = false;
					}
					if (currentPageTag.perspectives.perspective6.@lang5 == currentPageTag.perspectives.perspective5.@nonexsistant || currentPageTag.perspectives.perspective6.@lang5 == ""){
						tab6BackMC.visible = false;
					}
					
				}
				
				//Tween in Projecter
				TweenLite.to(bottomBar, 1, {y:539, ease:Sine.easeIn});
				TweenLite.to(projectorBack, 1, {y:30, ease:Sine.easeIn});
				
				//Start persVidPlay
				projectorBack.persVid.play();
				
				//Set pause true means pause is showing that it is playing
				projectorBack.persPlay = true;
				
				//Add Event listerners to mediaLinks & transcript
				projectorBack.infoArea.mediaLinks.addEventListener(MouseEvent.MOUSE_DOWN, showLinks);

			} 
			
		}// End scrollDownProjector
		
		public function scrollBackIn (e:MouseEvent):void{
			//Changing this to indent the button
			drButton1.gotoAndStop(1);
			drButton2.gotoAndStop(1);
			drButton3.gotoAndStop(1);
			drButton4.gotoAndStop(1);
			drButton5.gotoAndStop(1);
			drButton6.gotoAndStop(1);
			
			// Show main controls
			courseModel.mediaControlVisible = true;

			//Tween in Projecter
			TweenLite.to(bottomBar, 1, {y:50, ease:Sine.easeIn});
			TweenLite.to(projectorBack, 1, {y:-446, ease:Sine.easeIn});
			
			//Set persPlay video to stop
			projectorBack.persVid.stop();
			
			//Start replay of mainVid
			addChild(vid);
			setChildIndex(vid, 0);
			vid.testVid.source = currentPageTag.@firstVid;
			vid.testVid.play();
			
			//Setting Scroll out back to true
			scrollInOut = true;
		}// End scrollBackIn
		
		//Add Tabs and switch tabs
		
		public function addTabs (e:Event = null):void{
			projectorBack.linksArea.addChildAt(tab2Media, 0);
			projectorBack.linksArea.addChildAt(tab3Media, 0);
			projectorBack.linksArea.addChildAt(tab4Media, 0);
			//projectorBack.linksArea.addChildAt(tab6Media, 0);
		}//End addTabs
		
		// Show links
		public function showLinks (e:MouseEvent):void{
			//Hyper link locations
			//Adding Pers 1 Content Variables
			pers1Hyper1 = currentPageTag.perspectives.perspective1.hyperLink1.@linkLocation;
			pers1Hyper2 = currentPageTag.perspectives.perspective1.hyperLink2.@linkLocation;
			pers1Hyper3 = currentPageTag.perspectives.perspective1.hyperLink3.@linkLocation;
			pers1Hyper4 = currentPageTag.perspectives.perspective1.hyperLink4.@linkLocation;
			pers1Hyper5 = currentPageTag.perspectives.perspective1.hyperLink5.@linkLocation;
			pers1Hyper6 = currentPageTag.perspectives.perspective1.hyperLink6.@linkLocation;
			pers1Hyper7 = currentPageTag.perspectives.perspective1.hyperLink7.@linkLocation;
			pers1Hyper8 = currentPageTag.perspectives.perspective1.hyperLink8.@linkLocation;
			pers1Hyper9 = currentPageTag.perspectives.perspective1.hyperLink9.@linkLocation;
			pers1Hyper10 = currentPageTag.perspectives.perspective1.hyperLink10.@linkLocation;
			pers1Hyper11 = currentPageTag.perspectives.perspective1.hyperLink11.@linkLocation;
			pers1Hyper12 = currentPageTag.perspectives.perspective1.hyperLink12.@linkLocation;
			
			//Adding Pers 2 Content Variables
			pers2Hyper1 = currentPageTag.perspectives.perspective2.hyperLink1.@linkLocation;
			pers2Hyper2 = currentPageTag.perspectives.perspective2.hyperLink2.@linkLocation;
			pers2Hyper3 = currentPageTag.perspectives.perspective2.hyperLink3.@linkLocation;
			pers2Hyper4 = currentPageTag.perspectives.perspective2.hyperLink4.@linkLocation;
			pers2Hyper5 = currentPageTag.perspectives.perspective2.hyperLink5.@linkLocation;
			pers2Hyper6 = currentPageTag.perspectives.perspective2.hyperLink6.@linkLocation;
			pers2Hyper7 = currentPageTag.perspectives.perspective2.hyperLink7.@linkLocation;
			pers2Hyper8 = currentPageTag.perspectives.perspective2.hyperLink8.@linkLocation;
			pers2Hyper9 = currentPageTag.perspectives.perspective2.hyperLink9.@linkLocation;
			pers2Hyper10 = currentPageTag.perspectives.perspective2.hyperLink10.@linkLocation;
			pers2Hyper11 = currentPageTag.perspectives.perspective2.hyperLink11.@linkLocation;
			pers2Hyper12 = currentPageTag.perspectives.perspective2.hyperLink12.@linkLocation;
			
			//Adding Pers 3 Content Variables
			pers3Hyper1 = currentPageTag.perspectives.perspective3.hyperLink1.@linkLocation;
			pers3Hyper2 = currentPageTag.perspectives.perspective3.hyperLink2.@linkLocation;
			pers3Hyper3 = currentPageTag.perspectives.perspective3.hyperLink3.@linkLocation;
			pers3Hyper4 = currentPageTag.perspectives.perspective3.hyperLink4.@linkLocation;
			pers3Hyper5 = currentPageTag.perspectives.perspective3.hyperLink5.@linkLocation;
			pers3Hyper6 = currentPageTag.perspectives.perspective3.hyperLink6.@linkLocation;
			pers3Hyper7 = currentPageTag.perspectives.perspective3.hyperLink7.@linkLocation;
			pers3Hyper8 = currentPageTag.perspectives.perspective3.hyperLink8.@linkLocation;
			pers3Hyper9 = currentPageTag.perspectives.perspective3.hyperLink9.@linkLocation;
			pers3Hyper10 = currentPageTag.perspectives.perspective3.hyperLink10.@linkLocation;
			pers3Hyper11 = currentPageTag.perspectives.perspective3.hyperLink11.@linkLocation;
			pers3Hyper12 = currentPageTag.perspectives.perspective3.hyperLink12.@linkLocation;
			
			//Adding Pers 4 Content Variables
			pers4Hyper1 = currentPageTag.perspectives.perspective4.hyperLink1.@linkLocation;
			pers4Hyper2 = currentPageTag.perspectives.perspective4.hyperLink2.@linkLocation;
			pers4Hyper3 = currentPageTag.perspectives.perspective4.hyperLink3.@linkLocation;
			pers4Hyper4 = currentPageTag.perspectives.perspective4.hyperLink4.@linkLocation;
			pers4Hyper5 = currentPageTag.perspectives.perspective4.hyperLink5.@linkLocation;
			pers4Hyper6 = currentPageTag.perspectives.perspective4.hyperLink6.@linkLocation;
			pers4Hyper7 = currentPageTag.perspectives.perspective4.hyperLink7.@linkLocation;
			pers4Hyper8 = currentPageTag.perspectives.perspective4.hyperLink8.@linkLocation;
			pers4Hyper9 = currentPageTag.perspectives.perspective4.hyperLink9.@linkLocation;
			pers4Hyper10 = currentPageTag.perspectives.perspective4.hyperLink10.@linkLocation;
			pers4Hyper11 = currentPageTag.perspectives.perspective4.hyperLink11.@linkLocation;
			pers4Hyper12 = currentPageTag.perspectives.perspective4.hyperLink12.@linkLocation;
			
			//Adding Pers 5 Content Variables
			pers5Hyper1 = currentPageTag.perspectives.perspective5.hyperLink1.@linkLocation;
			pers5Hyper2 = currentPageTag.perspectives.perspective5.hyperLink2.@linkLocation;
			pers5Hyper3 = currentPageTag.perspectives.perspective5.hyperLink3.@linkLocation;
			pers5Hyper4 = currentPageTag.perspectives.perspective5.hyperLink4.@linkLocation;
			pers5Hyper5 = currentPageTag.perspectives.perspective5.hyperLink5.@linkLocation;
			pers5Hyper6 = currentPageTag.perspectives.perspective5.hyperLink6.@linkLocation;
			pers5Hyper7 = currentPageTag.perspectives.perspective5.hyperLink7.@linkLocation;
			pers5Hyper8 = currentPageTag.perspectives.perspective5.hyperLink8.@linkLocation;
			pers5Hyper9 = currentPageTag.perspectives.perspective5.hyperLink9.@linkLocation;
			pers5Hyper10 = currentPageTag.perspectives.perspective5.hyperLink10.@linkLocation;
			pers5Hyper11 = currentPageTag.perspectives.perspective5.hyperLink11.@linkLocation;
			pers5Hyper12 = currentPageTag.perspectives.perspective5.hyperLink12.@linkLocation;
			
			//Adding Pers 6 Content Variables
			pers6Hyper1 = currentPageTag.perspectives.perspective6.hyperLink1.@linkLocation;
			pers6Hyper2 = currentPageTag.perspectives.perspective6.hyperLink2.@linkLocation;
			pers6Hyper3 = currentPageTag.perspectives.perspective6.hyperLink3.@linkLocation;
			pers6Hyper4 = currentPageTag.perspectives.perspective6.hyperLink4.@linkLocation;
			pers6Hyper5 = currentPageTag.perspectives.perspective6.hyperLink5.@linkLocation;
			pers6Hyper6 = currentPageTag.perspectives.perspective6.hyperLink6.@linkLocation;
			pers6Hyper7 = currentPageTag.perspectives.perspective6.hyperLink7.@linkLocation;
			pers6Hyper8 = currentPageTag.perspectives.perspective6.hyperLink8.@linkLocation;
			pers6Hyper9 = currentPageTag.perspectives.perspective6.hyperLink9.@linkLocation;
			pers6Hyper10 = currentPageTag.perspectives.perspective6.hyperLink10.@linkLocation;
			pers6Hyper11 = currentPageTag.perspectives.perspective6.hyperLink11.@linkLocation;
			pers6Hyper12 = currentPageTag.perspectives.perspective6.hyperLink12.@linkLocation;
			
			//Adding Pers 1 Title Contents
			pers1Hyper1Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink1.@hyperTitle + "</b>";
			pers1Hyper2Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink2.@hyperTitle + "</b>";
			pers1Hyper3Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink3.@hyperTitle + "</b>";
			pers1Hyper4Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink4.@hyperTitle + "</b>";
			pers1Hyper5Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink5.@hyperTitle + "</b>";
			pers1Hyper6Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink6.@hyperTitle + "</b>";
			pers1Hyper7Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink7.@hyperTitle + "</b>";
			pers1Hyper8Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink8.@hyperTitle + "</b>";
			pers1Hyper9Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink9.@hyperTitle + "</b>";
			pers1Hyper10Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink10.@hyperTitle + "</b>";
			pers1Hyper11Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink11.@hyperTitle + "</b>";
			pers1Hyper12Title = "<b>" + currentPageTag.perspectives.perspective1.hyperLink12.@hyperTitle + "</b>";
			
			//Adding Pers 2 Title Contents
			pers2Hyper1Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink1.@hyperTitle + "</b>";
			pers2Hyper2Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink2.@hyperTitle + "</b>";
			pers2Hyper3Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink3.@hyperTitle + "</b>";
			pers2Hyper4Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink4.@hyperTitle + "</b>";
			pers2Hyper5Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink5.@hyperTitle + "</b>";
			pers2Hyper6Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink6.@hyperTitle + "</b>";
			pers2Hyper7Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink7.@hyperTitle + "</b>";
			pers2Hyper8Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink8.@hyperTitle + "</b>";
			pers2Hyper9Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink9.@hyperTitle + "</b>";
			pers2Hyper10Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink10.@hyperTitle + "</b>";
			pers2Hyper11Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink11.@hyperTitle + "</b>";
			pers2Hyper12Title = "<b>" + currentPageTag.perspectives.perspective2.hyperLink12.@hyperTitle + "</b>";
			
			//Adding Pers 1 Title Contents
			pers3Hyper1Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink1.@hyperTitle + "</b>";
			pers3Hyper2Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink2.@hyperTitle + "</b>";
			pers3Hyper3Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink3.@hyperTitle + "</b>";
			pers3Hyper4Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink4.@hyperTitle + "</b>";
			pers3Hyper5Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink5.@hyperTitle + "</b>";
			pers3Hyper6Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink6.@hyperTitle + "</b>";
			pers3Hyper7Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink7.@hyperTitle + "</b>";
			pers3Hyper8Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink8.@hyperTitle + "</b>";
			pers3Hyper9Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink9.@hyperTitle + "</b>";
			pers3Hyper10Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink10.@hyperTitle + "</b>";
			pers3Hyper11Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink11.@hyperTitle + "</b>";
			pers3Hyper12Title = "<b>" + currentPageTag.perspectives.perspective3.hyperLink12.@hyperTitle + "</b>";
			
			//Adding Pers 4 Title Contents
			pers4Hyper1Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink1.@hyperTitle + "</b>";
			pers4Hyper2Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink2.@hyperTitle + "</b>";
			pers4Hyper3Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink3.@hyperTitle + "</b>";
			pers4Hyper4Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink4.@hyperTitle + "</b>";
			pers4Hyper5Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink5.@hyperTitle + "</b>";
			pers4Hyper6Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink6.@hyperTitle + "</b>";
			pers4Hyper7Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink7.@hyperTitle + "</b>";
			pers4Hyper8Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink8.@hyperTitle + "</b>";
			pers4Hyper9Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink9.@hyperTitle + "</b>";
			pers4Hyper10Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink10.@hyperTitle + "</b>";
			pers4Hyper11Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink11.@hyperTitle + "</b>";
			pers4Hyper12Title = "<b>" + currentPageTag.perspectives.perspective4.hyperLink12.@hyperTitle + "</b>";
			
			//Adding Pers 5 Title Contents
			pers5Hyper1Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink1.@hyperTitle + "</b>";
			pers5Hyper2Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink2.@hyperTitle + "</b>";
			pers5Hyper3Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink3.@hyperTitle + "</b>";
			pers5Hyper4Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink4.@hyperTitle + "</b>";
			pers5Hyper5Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink5.@hyperTitle + "</b>";
			pers5Hyper6Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink6.@hyperTitle + "</b>";
			pers5Hyper7Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink7.@hyperTitle + "</b>";
			pers5Hyper8Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink8.@hyperTitle + "</b>";
			pers5Hyper9Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink9.@hyperTitle + "</b>";
			pers5Hyper10Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink10.@hyperTitle + "</b>";
			pers5Hyper11Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink11.@hyperTitle + "</b>";
			pers5Hyper12Title = "<b>" + currentPageTag.perspectives.perspective5.hyperLink12.@hyperTitle + "</b>";
			
			//Adding Pers 1 Title Contents
			pers6Hyper1Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink1.@hyperTitle + "</b>";
			pers6Hyper2Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink2.@hyperTitle + "</b>";
			pers6Hyper3Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink3.@hyperTitle + "</b>";
			pers6Hyper4Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink4.@hyperTitle + "</b>";
			pers6Hyper5Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink5.@hyperTitle + "</b>";
			pers6Hyper6Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink6.@hyperTitle + "</b>";
			pers6Hyper7Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink7.@hyperTitle + "</b>";
			pers6Hyper8Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink8.@hyperTitle + "</b>";
			pers6Hyper9Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink9.@hyperTitle + "</b>";
			pers6Hyper10Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink10.@hyperTitle + "</b>";
			pers6Hyper11Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink11.@hyperTitle + "</b>";
			pers6Hyper12Title = "<b>" + currentPageTag.perspectives.perspective6.hyperLink12.@hyperTitle + "</b>";
			
			
			// Buttons not visible if title not there for pers 
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
			
			// projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
			
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers1Hyper2Title != "<b></b>" && pers1Hyper2Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers1Hyper3Title != "<b></b>" && pers1Hyper3Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers1Hyper4Title != "<b></b>" && pers1Hyper4Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers1Hyper5Title != "<b></b>" && pers1Hyper5Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers1Hyper6Title != "<b></b>" && pers1Hyper6Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers1Hyper7Title != "<b></b>" && pers1Hyper7Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers1Hyper8Title != "<b></b>" && pers1Hyper8Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers1Hyper9Title != "<b></b>" && pers1Hyper9Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers1Hyper10Title != "<b></b>" && pers1Hyper10Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers1Hyper11Title != "<b></b>" && pers1Hyper11Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers1Hyper12Title != "<b></b>" && pers1Hyper12Title != null);
			
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers2Hyper1Title != "<b></b>" && pers2Hyper1Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers2Hyper2Title != "<b></b>" && pers2Hyper2Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers2Hyper3Title != "<b></b>" && pers2Hyper3Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers2Hyper4Title != "<b></b>" && pers2Hyper4Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers2Hyper5Title != "<b></b>" && pers2Hyper5Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers2Hyper6Title != "<b></b>" && pers2Hyper6Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers2Hyper7Title != "<b></b>" && pers2Hyper7Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers2Hyper8Title != "<b></b>" && pers2Hyper8Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers2Hyper9Title != "<b></b>" && pers2Hyper9Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers2Hyper10Title != "<b></b>" && pers2Hyper10Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers2Hyper11Title != "<b></b>" && pers2Hyper11Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers2Hyper12Title != "<b></b>" && pers2Hyper12Title != null);
			
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers3Hyper1Title != "<b></b>" && pers3Hyper1Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers3Hyper2Title != "<b></b>" && pers3Hyper2Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers3Hyper3Title != "<b></b>" && pers3Hyper3Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers3Hyper4Title != "<b></b>" && pers3Hyper4Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers3Hyper5Title != "<b></b>" && pers3Hyper5Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers3Hyper6Title != "<b></b>" && pers3Hyper6Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers3Hyper7Title != "<b></b>" && pers3Hyper7Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers3Hyper8Title != "<b></b>" && pers3Hyper8Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers3Hyper9Title != "<b></b>" && pers3Hyper9Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers3Hyper10Title != "<b></b>" && pers3Hyper10Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers3Hyper11Title != "<b></b>" && pers3Hyper11Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers3Hyper12Title != "<b></b>" && pers3Hyper12Title != null);
			
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers4Hyper1Title != "<b></b>" && pers4Hyper1Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers4Hyper2Title != "<b></b>" && pers4Hyper2Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers4Hyper3Title != "<b></b>" && pers4Hyper3Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers4Hyper4Title != "<b></b>" && pers4Hyper4Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers4Hyper5Title != "<b></b>" && pers4Hyper5Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers4Hyper6Title != "<b></b>" && pers4Hyper6Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers4Hyper7Title != "<b></b>" && pers4Hyper7Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers4Hyper8Title != "<b></b>" && pers4Hyper8Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers4Hyper9Title != "<b></b>" && pers4Hyper9Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers4Hyper10Title != "<b></b>" && pers4Hyper10Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers4Hyper11Title != "<b></b>" && pers4Hyper11Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers4Hyper12Title != "<b></b>" && pers4Hyper12Title != null);
			
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers5Hyper1Title != "<b></b>" && pers5Hyper1Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers5Hyper2Title != "<b></b>" && pers5Hyper2Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers5Hyper3Title != "<b></b>" && pers5Hyper3Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers5Hyper4Title != "<b></b>" && pers5Hyper4Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers5Hyper5Title != "<b></b>" && pers5Hyper5Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers5Hyper6Title != "<b></b>" && pers5Hyper6Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers5Hyper7Title != "<b></b>" && pers5Hyper7Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers5Hyper8Title != "<b></b>" && pers5Hyper8Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers5Hyper9Title != "<b></b>" && pers5Hyper9Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers5Hyper10Title != "<b></b>" && pers5Hyper10Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers5Hyper11Title != "<b></b>" && pers5Hyper11Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers5Hyper12Title != "<b></b>" && pers5Hyper12Title != null);
			
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers6Hyper1Title != "<b></b>" && pers6Hyper1Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers6Hyper2Title != "<b></b>" && pers6Hyper2Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers6Hyper3Title != "<b></b>" && pers6Hyper3Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers6Hyper4Title != "<b></b>" && pers6Hyper4Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers6Hyper5Title != "<b></b>" && pers6Hyper5Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers6Hyper6Title != "<b></b>" && pers6Hyper6Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers6Hyper7Title != "<b></b>" && pers6Hyper7Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers6Hyper8Title != "<b></b>" && pers6Hyper8Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers6Hyper9Title != "<b></b>" && pers6Hyper9Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers6Hyper10Title != "<b></b>" && pers6Hyper10Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers6Hyper11Title != "<b></b>" && pers6Hyper11Title != null);
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers6Hyper12Title != "<b></b>" && pers6Hyper12Title != null);
			
			
			//Adding Pers 1 Descr Contents
			pers1Hyper1Desc = currentPageTag.perspectives.perspective1.hyperLink1;
			pers1Hyper2Desc = currentPageTag.perspectives.perspective1.hyperLink2;
			pers1Hyper3Desc = currentPageTag.perspectives.perspective1.hyperLink3;
			pers1Hyper4Desc = currentPageTag.perspectives.perspective1.hyperLink4;
			pers1Hyper5Desc = currentPageTag.perspectives.perspective1.hyperLink5;
			pers1Hyper6Desc = currentPageTag.perspectives.perspective1.hyperLink6;
			pers1Hyper7Desc = currentPageTag.perspectives.perspective1.hyperLink7;
			pers1Hyper8Desc = currentPageTag.perspectives.perspective1.hyperLink8;
			pers1Hyper9Desc = currentPageTag.perspectives.perspective1.hyperLink9;
			pers1Hyper10Desc = currentPageTag.perspectives.perspective1.hyperLink10;
			pers1Hyper11Desc = currentPageTag.perspectives.perspective1.hyperLink11;
			pers1Hyper12Desc = currentPageTag.perspectives.perspective1.hyperLink12;
			
			//Adding Pers 2 Descr Contents
			pers2Hyper1Desc = currentPageTag.perspectives.perspective2.hyperLink1;
			pers2Hyper2Desc = currentPageTag.perspectives.perspective2.hyperLink2;
			pers2Hyper3Desc = currentPageTag.perspectives.perspective2.hyperLink3;
			pers2Hyper4Desc = currentPageTag.perspectives.perspective2.hyperLink4;
			pers2Hyper5Desc = currentPageTag.perspectives.perspective2.hyperLink5;
			pers2Hyper6Desc = currentPageTag.perspectives.perspective2.hyperLink6;
			pers2Hyper7Desc = currentPageTag.perspectives.perspective2.hyperLink7;
			pers2Hyper8Desc = currentPageTag.perspectives.perspective2.hyperLink8;
			pers2Hyper9Desc = currentPageTag.perspectives.perspective2.hyperLink9;
			pers2Hyper10Desc = currentPageTag.perspectives.perspective2.hyperLink10;
			pers2Hyper11Desc = currentPageTag.perspectives.perspective2.hyperLink11;
			pers2Hyper12Desc = currentPageTag.perspectives.perspective2.hyperLink12;
			
			//Adding Pers 3 Descr Contents
			pers3Hyper1Desc = currentPageTag.perspectives.perspective3.hyperLink1;
			pers3Hyper2Desc = currentPageTag.perspectives.perspective3.hyperLink2;
			pers3Hyper3Desc = currentPageTag.perspectives.perspective3.hyperLink3;
			pers3Hyper4Desc = currentPageTag.perspectives.perspective3.hyperLink4;
			pers3Hyper5Desc = currentPageTag.perspectives.perspective3.hyperLink5;
			pers3Hyper6Desc = currentPageTag.perspectives.perspective3.hyperLink6;
			pers3Hyper7Desc = currentPageTag.perspectives.perspective3.hyperLink7;
			pers3Hyper8Desc = currentPageTag.perspectives.perspective3.hyperLink8;
			pers3Hyper9Desc = currentPageTag.perspectives.perspective3.hyperLink9;
			pers3Hyper10Desc = currentPageTag.perspectives.perspective3.hyperLink10;
			pers3Hyper11Desc = currentPageTag.perspectives.perspective3.hyperLink11;
			pers3Hyper12Desc = currentPageTag.perspectives.perspective3.hyperLink12;
			
			//Adding Pers 4 Descr Contents
			pers4Hyper1Desc = currentPageTag.perspectives.perspective4.hyperLink1;
			pers4Hyper2Desc = currentPageTag.perspectives.perspective4.hyperLink2;
			pers4Hyper3Desc = currentPageTag.perspectives.perspective4.hyperLink3;
			pers4Hyper4Desc = currentPageTag.perspectives.perspective4.hyperLink4;
			pers4Hyper5Desc = currentPageTag.perspectives.perspective4.hyperLink5;
			pers4Hyper6Desc = currentPageTag.perspectives.perspective4.hyperLink6;
			pers4Hyper7Desc = currentPageTag.perspectives.perspective4.hyperLink7;
			pers4Hyper8Desc = currentPageTag.perspectives.perspective4.hyperLink8;
			pers4Hyper9Desc = currentPageTag.perspectives.perspective4.hyperLink9;
			pers4Hyper10Desc = currentPageTag.perspectives.perspective4.hyperLink10;
			pers4Hyper11Desc = currentPageTag.perspectives.perspective4.hyperLink11;
			pers4Hyper12Desc = currentPageTag.perspectives.perspective4.hyperLink12;
			
			//Adding Pers 5 Descr Contents
			pers5Hyper1Desc = currentPageTag.perspectives.perspective5.hyperLink1;
			pers5Hyper2Desc = currentPageTag.perspectives.perspective5.hyperLink2;
			pers5Hyper3Desc = currentPageTag.perspectives.perspective5.hyperLink3;
			pers5Hyper4Desc = currentPageTag.perspectives.perspective5.hyperLink4;
			pers5Hyper5Desc = currentPageTag.perspectives.perspective5.hyperLink5;
			pers5Hyper6Desc = currentPageTag.perspectives.perspective5.hyperLink6;
			pers5Hyper7Desc = currentPageTag.perspectives.perspective5.hyperLink7;
			pers5Hyper8Desc = currentPageTag.perspectives.perspective5.hyperLink8;
			pers5Hyper9Desc = currentPageTag.perspectives.perspective5.hyperLink9;
			pers5Hyper10Desc = currentPageTag.perspectives.perspective5.hyperLink10;
			pers5Hyper11Desc = currentPageTag.perspectives.perspective5.hyperLink11;
			pers5Hyper12Desc = currentPageTag.perspectives.perspective5.hyperLink12;
			
			//Adding Pers 6 Descr Contents
			pers6Hyper1Desc = currentPageTag.perspectives.perspective6.hyperLink1;
			pers6Hyper2Desc = currentPageTag.perspectives.perspective6.hyperLink2;
			pers6Hyper3Desc = currentPageTag.perspectives.perspective6.hyperLink3;
			pers6Hyper4Desc = currentPageTag.perspectives.perspective6.hyperLink4;
			pers6Hyper5Desc = currentPageTag.perspectives.perspective6.hyperLink5;
			pers6Hyper6Desc = currentPageTag.perspectives.perspective6.hyperLink6;
			pers6Hyper7Desc = currentPageTag.perspectives.perspective6.hyperLink7;
			pers6Hyper8Desc = currentPageTag.perspectives.perspective6.hyperLink8;
			pers6Hyper9Desc = currentPageTag.perspectives.perspective6.hyperLink9;
			pers6Hyper10Desc = currentPageTag.perspectives.perspective6.hyperLink10;
			pers6Hyper11Desc = currentPageTag.perspectives.perspective6.hyperLink11;
			pers6Hyper12Desc = currentPageTag.perspectives.perspective6.hyperLink12;
			
			//Show down on show links
			projectorBack.infoArea.mediaLinks.gotoAndStop("over");
			projectorBack.infoArea.transcriptBTN.gotoAndStop("up");
			//Make link area visible
			projectorBack.linksArea.visible = true
			// Make Lang Area not visible
			projectorBack.langArea.visible = false;
			//Add Event listener to show langArea again
			projectorBack.infoArea.transcriptBTN.addEventListener(MouseEvent.MOUSE_DOWN, showLangArea);
			
			//Add tabs
			addTabs();
			
			//Add function to scroll up and down and bar
			projectorBack.linksArea.downHyper.addEventListener(MouseEvent.MOUSE_DOWN, scrollHypersDown);
			projectorBack.linksArea.downHyper.buttonMode = true;
			projectorBack.linksArea.upHyper.addEventListener(MouseEvent.MOUSE_DOWN, scrollHypersUp);
			projectorBack.linksArea.upHyper.buttonMode = true;
			projectorBack.linksArea.upHyper.gotoAndStop(2);
			
			//Show up and down buttons
			projectorBack.linksArea.downHyper.visible = true;
			projectorBack.linksArea.upHyper.visible = true;
			
			// Add event listeners
			projectorBack.linksArea.tab1.addEventListener(MouseEvent.MOUSE_DOWN, linkTabClick);
			projectorBack.linksArea.tab2.addEventListener(MouseEvent.MOUSE_DOWN, linkTabClick);
			projectorBack.linksArea.tab3.addEventListener(MouseEvent.MOUSE_DOWN, linkTabClick);
			projectorBack.linksArea.tab4.addEventListener(MouseEvent.MOUSE_DOWN, linkTabClick);
			//projectorBack.linksArea.tab6.addEventListener(MouseEvent.MOUSE_DOWN, linkTabClick);
			
			//Setting tab index
			projectorBack.infoArea.setChildIndex(projectorBack.infoArea.transcriptBTN, 4);
			projectorBack.infoArea.setChildIndex(projectorBack.infoArea.mediaLinks, 5);
			
			//Set Links Tab Names
			projectorBack.linksArea.hyperTab.htmlText = "<b>" + currentPageTag.@hyperLinkTab + "</b>";
			tab2Media.docsTab.htmlText = "<b>" + currentPageTag.@docsLinkTab + "</b>";
			tab3Media.mediaTab.htmlText = "<b>" + currentPageTag.@meidaLinksTab + "</b>";
			
			//Establish Hyperlink locations
			if(pers == "perspective1"){
				hyperLink1Content = pers1Hyper1;
				hyperLink2Content = pers1Hyper2;
				hyperLink3Content = pers1Hyper3;
				hyperLink4Content = pers1Hyper4;
				hyperLink5Content = pers1Hyper5;
				hyperLink6Content = pers1Hyper6;
				hyperLink7Content = pers1Hyper7;
				hyperLink8Content = pers1Hyper8;
				hyperLink9Content = pers1Hyper9;
				hyperLink10Content = pers1Hyper10;
				hyperLink11Content = pers1Hyper11;
				hyperLink12Content = pers1Hyper12;
			} else if (pers == "perspective2"){
				hyperLink1Content = pers2Hyper1;
				hyperLink2Content = pers2Hyper2;
				hyperLink3Content = pers2Hyper3;
				hyperLink4Content = pers2Hyper4;
				hyperLink5Content = pers2Hyper5;
				hyperLink6Content = pers2Hyper6;
				hyperLink7Content = pers2Hyper7;
				hyperLink8Content = pers2Hyper8;
				hyperLink9Content = pers2Hyper9;
				hyperLink10Content = pers2Hyper10;
				hyperLink11Content = pers2Hyper11;
				hyperLink12Content = pers2Hyper12;
			} else if (pers == "perspective3"){
				hyperLink1Content = pers3Hyper1;
				hyperLink2Content = pers3Hyper2;
				hyperLink3Content = pers3Hyper3;
				hyperLink4Content = pers3Hyper4;
				hyperLink5Content = pers3Hyper5;
				hyperLink6Content = pers3Hyper6;
				hyperLink7Content = pers3Hyper7;
				hyperLink8Content = pers3Hyper8;
				hyperLink9Content = pers3Hyper9;
				hyperLink10Content = pers3Hyper10;
				hyperLink11Content = pers3Hyper11;
				hyperLink12Content = pers3Hyper12;
			} else if (pers == "perspective4"){
				hyperLink1Content = pers4Hyper1;
				hyperLink2Content = pers4Hyper2;
				hyperLink3Content = pers4Hyper3;
				hyperLink4Content = pers4Hyper4;
				hyperLink5Content = pers4Hyper5;
				hyperLink6Content = pers4Hyper6;
				hyperLink7Content = pers4Hyper7;
				hyperLink8Content = pers4Hyper8;
				hyperLink9Content = pers4Hyper9;
				hyperLink10Content = pers4Hyper10;
				hyperLink11Content = pers4Hyper11;
				hyperLink12Content = pers4Hyper12;
			} else if (pers == "perspective5"){
				hyperLink1Content = pers5Hyper1;
				hyperLink2Content = pers5Hyper2;
				hyperLink3Content = pers5Hyper3;
				hyperLink4Content = pers5Hyper4;
				hyperLink5Content = pers5Hyper5;
				hyperLink6Content = pers5Hyper6;
				hyperLink7Content = pers5Hyper7;
				hyperLink8Content = pers5Hyper8;
				hyperLink9Content = pers5Hyper9;
				hyperLink10Content = pers5Hyper10;
				hyperLink11Content = pers5Hyper11;
				hyperLink12Content = pers5Hyper12;
			} else if (pers == "perspective6"){
				hyperLink1Content = pers6Hyper1;
				hyperLink2Content = pers6Hyper2;
				hyperLink3Content = pers6Hyper3;
				hyperLink4Content = pers6Hyper4;
				hyperLink5Content = pers6Hyper5;
				hyperLink6Content = pers6Hyper6;
				hyperLink7Content = pers6Hyper7;
				hyperLink8Content = pers6Hyper8;
				hyperLink9Content = pers6Hyper9;
				hyperLink10Content = pers6Hyper10;
				hyperLink11Content = pers6Hyper11;
				hyperLink12Content = pers6Hyper12;
			}
			
			///Establish Hyperlink titles
			if(pers == "perspective1"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers1Hyper1Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers1Hyper2Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers1Hyper3Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers1Hyper4Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers1Hyper5Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers1Hyper6Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers1Hyper7Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers1Hyper8Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers1Hyper9Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers1Hyper10Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers1Hyper11Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers1Hyper12Title;
				// Buttons not visible if title not there for pers 
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				//projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers1Hyper2Title != "<b></b>" && pers1Hyper2Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers1Hyper3Title != "<b></b>" && pers1Hyper3Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers1Hyper4Title != "<b></b>" && pers1Hyper4Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers1Hyper5Title != "<b></b>" && pers1Hyper5Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers1Hyper6Title != "<b></b>" && pers1Hyper6Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers1Hyper7Title != "<b></b>" && pers1Hyper7Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers1Hyper8Title != "<b></b>" && pers1Hyper8Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers1Hyper9Title != "<b></b>" && pers1Hyper9Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers1Hyper10Title != "<b></b>" && pers1Hyper10Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers1Hyper11Title != "<b></b>" && pers1Hyper11Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers1Hyper12Title != "<b></b>" && pers1Hyper12Title != null);
			} else if(pers == "perspective2"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers2Hyper1Title;
				//projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers2Hyper2Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers2Hyper3Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers2Hyper4Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers2Hyper5Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers2Hyper6Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers2Hyper7Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers2Hyper8Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers2Hyper9Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers2Hyper10Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers2Hyper11Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers2Hyper12Title;
				// Buttons not visible if title not there for pers 
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers2Hyper1Title != "<b></b>" && pers2Hyper1Title != null);
				//projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers2Hyper2Title != "<b></b>" && pers2Hyper2Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers2Hyper3Title != "<b></b>" && pers2Hyper3Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers2Hyper4Title != "<b></b>" && pers2Hyper4Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers2Hyper5Title != "<b></b>" && pers2Hyper5Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers2Hyper6Title != "<b></b>" && pers2Hyper6Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers2Hyper7Title != "<b></b>" && pers2Hyper7Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers2Hyper8Title != "<b></b>" && pers2Hyper8Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers2Hyper9Title != "<b></b>" && pers2Hyper9Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers2Hyper10Title != "<b></b>" && pers2Hyper10Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers2Hyper11Title != "<b></b>" && pers2Hyper11Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers2Hyper12Title != "<b></b>" && pers2Hyper12Title != null);
			} else if (pers == "perspective3"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers3Hyper1Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers3Hyper2Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers3Hyper3Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers3Hyper4Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers3Hyper5Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers3Hyper6Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers3Hyper7Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers3Hyper8Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers3Hyper9Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers3Hyper10Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers3Hyper11Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers3Hyper12Title;
				// Buttons not visible if title not there for pers 
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers3Hyper1Title != "<b></b>" && pers3Hyper1Title != null);
				//projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers3Hyper2Title != "<b></b>" && pers3Hyper2Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers3Hyper3Title != "<b></b>" && pers3Hyper3Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers3Hyper4Title != "<b></b>" && pers3Hyper4Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers3Hyper5Title != "<b></b>" && pers3Hyper5Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers3Hyper6Title != "<b></b>" && pers3Hyper6Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers3Hyper7Title != "<b></b>" && pers3Hyper7Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers3Hyper8Title != "<b></b>" && pers3Hyper8Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers3Hyper9Title != "<b></b>" && pers3Hyper9Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers3Hyper10Title != "<b></b>" && pers3Hyper10Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers3Hyper11Title != "<b></b>" && pers3Hyper11Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers3Hyper12Title != "<b></b>" && pers3Hyper12Title != null);
			} else if (pers == "perspective4"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers4Hyper1Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers4Hyper2Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers4Hyper3Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers4Hyper4Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers4Hyper5Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers4Hyper6Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers4Hyper7Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers4Hyper8Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers4Hyper9Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers4Hyper10Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers4Hyper11Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers4Hyper12Title;
				// Buttons not visible if title not there for pers 
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers4Hyper1Title != "<b></b>" && pers4Hyper1Title != null);
				//projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers4Hyper2Title != "<b></b>" && pers4Hyper2Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers4Hyper3Title != "<b></b>" && pers4Hyper3Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers4Hyper4Title != "<b></b>" && pers4Hyper4Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers4Hyper5Title != "<b></b>" && pers4Hyper5Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers4Hyper6Title != "<b></b>" && pers4Hyper6Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers4Hyper7Title != "<b></b>" && pers4Hyper7Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers4Hyper8Title != "<b></b>" && pers4Hyper8Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers4Hyper9Title != "<b></b>" && pers4Hyper9Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers4Hyper10Title != "<b></b>" && pers4Hyper10Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers4Hyper11Title != "<b></b>" && pers4Hyper11Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers4Hyper12Title != "<b></b>" && pers4Hyper12Title != null);
			} else if (pers == "perspective5"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers5Hyper1Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers5Hyper2Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers5Hyper3Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers5Hyper4Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers5Hyper5Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers5Hyper6Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers5Hyper7Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers5Hyper8Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers5Hyper9Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers5Hyper10Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers5Hyper11Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers5Hyper12Title;
				// Buttons not visible if title not there for pers 
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers5Hyper1Title != "<b></b>" && pers5Hyper1Title != null);
				//projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers5Hyper2Title != "<b></b>" && pers5Hyper2Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers5Hyper3Title != "<b></b>" && pers5Hyper3Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers5Hyper4Title != "<b></b>" && pers5Hyper4Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers5Hyper5Title != "<b></b>" && pers5Hyper5Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers5Hyper6Title != "<b></b>" && pers5Hyper6Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers5Hyper7Title != "<b></b>" && pers5Hyper7Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers5Hyper8Title != "<b></b>" && pers5Hyper8Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers5Hyper9Title != "<b></b>" && pers5Hyper9Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers5Hyper10Title != "<b></b>" && pers5Hyper10Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers5Hyper11Title != "<b></b>" && pers5Hyper11Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers5Hyper12Title != "<b></b>" && pers5Hyper12Title != null);
			} else if (pers == "perspective6"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers6Hyper1Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers6Hyper2Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers6Hyper3Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers6Hyper4Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers6Hyper5Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers6Hyper6Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers6Hyper7Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers6Hyper8Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers6Hyper9Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers6Hyper10Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers6Hyper11Title;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers6Hyper12Title;
				// Buttons not visible if title not there for pers 
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers6Hyper1Title != "<b></b>" && pers6Hyper1Title != null);
				//projectorBack.infoArea.mediaLinks.visible = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers6Hyper2Title != "<b></b>" && pers6Hyper2Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers6Hyper3Title != "<b></b>" && pers6Hyper3Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers6Hyper4Title != "<b></b>" && pers6Hyper4Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers6Hyper5Title != "<b></b>" && pers6Hyper5Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers6Hyper6Title != "<b></b>" && pers6Hyper6Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers6Hyper7Title != "<b></b>" && pers6Hyper7Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers6Hyper8Title != "<b></b>" && pers6Hyper8Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers6Hyper9Title != "<b></b>" && pers6Hyper9Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers6Hyper10Title != "<b></b>" && pers6Hyper10Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers6Hyper11Title != "<b></b>" && pers6Hyper11Title != null);
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers6Hyper12Title != "<b></b>" && pers6Hyper12Title != null);
			}
			
			//Adding descriptions
			if(pers == "perspective1"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers1Hyper1Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers1Hyper2Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers1Hyper3Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers1Hyper4Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers1Hyper5Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers1Hyper6Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers1Hyper7Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers1Hyper8Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers1Hyper9Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers1Hyper10Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers1Hyper11Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers1Hyper12Desc;
			} else if (pers == "perspective2"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers2Hyper1Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers2Hyper2Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers2Hyper3Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers2Hyper4Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers2Hyper5Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers2Hyper6Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers2Hyper7Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers2Hyper8Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers2Hyper9Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers2Hyper10Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers2Hyper11Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers2Hyper12Desc;
			} else if (pers == "perspective3"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers3Hyper1Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers3Hyper2Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers3Hyper3Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers3Hyper4Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers3Hyper5Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers3Hyper6Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers3Hyper7Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers3Hyper8Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers3Hyper9Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers3Hyper10Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers3Hyper11Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers3Hyper12Desc;
			} else if (pers == "perspective4"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers4Hyper1Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers4Hyper2Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers4Hyper3Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers4Hyper4Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers4Hyper5Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers4Hyper6Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers4Hyper7Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers4Hyper8Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers4Hyper9Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers4Hyper10Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers4Hyper11Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers4Hyper12Desc;
			} else if (pers == "perspective5"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers5Hyper1Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers5Hyper2Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers5Hyper3Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers5Hyper4Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers5Hyper5Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers5Hyper6Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers5Hyper7Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers5Hyper8Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers5Hyper9Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers5Hyper10Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers5Hyper11Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers5Hyper12Desc;
			} else if (pers == "perspective6"){
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers6Hyper1Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers6Hyper2Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers6Hyper3Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers6Hyper4Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers6Hyper5Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers6Hyper6Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers6Hyper7Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers6Hyper8Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers6Hyper9Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers6Hyper10Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers6Hyper11Desc;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers6Hyper12Desc;
			}
			
			//tab2Media Setting Buttons to Mouse Enabled
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.invisiBTN.buttonMode = true;
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.invisiBTN.buttonMode = true;
			
			//Setting tab indexs for Hyperlinks area
			projectorBack.linksArea.setChildIndex(tab2Media, 0);
			projectorBack.linksArea.setChildIndex(tab3Media, 0);
			projectorBack.linksArea.setChildIndex(tab4Media, 0);
			projectorBack.linksArea.setChildIndex(projectorBack.linksArea.allHypers, 9);
			//projectorBack.linksArea.setChildIndex(projectorBack.linksArea.downHyper, 10);
			//projectorBack.linksArea.setChildIndex(tab6Media, 0);
			
			//Adding event listeners to buttons
			projectorBack.linksArea.allHypers.connectedHypers.hyper1.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper1);
			projectorBack.linksArea.allHypers.connectedHypers.hyper2.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper2);
			projectorBack.linksArea.allHypers.connectedHypers.hyper3.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper3);
			projectorBack.linksArea.allHypers.connectedHypers.hyper4.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper4);
			projectorBack.linksArea.allHypers.connectedHypers.hyper5.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper5);
			projectorBack.linksArea.allHypers.connectedHypers.hyper6.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper6);
			projectorBack.linksArea.allHypers.connectedHypers.hyper7.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper7);
			projectorBack.linksArea.allHypers.connectedHypers.hyper8.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper8);
			projectorBack.linksArea.allHypers.connectedHypers.hyper9.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper9);
			projectorBack.linksArea.allHypers.connectedHypers.hyper10.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper10);
			projectorBack.linksArea.allHypers.connectedHypers.hyper11.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper11);
			projectorBack.linksArea.allHypers.connectedHypers.hyper12.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper12);
			
			//HidePlaying
			tab3Media.media1.playingAudio.visible = false;
			tab3Media.media2.playingAudio.visible = false;
			tab3Media.media3.playingAudio.visible = false;
			tab3Media.media4.playingAudio.visible = false;
			tab3Media.media5.playingAudio.visible = false;
			tab3Media.media6.playingAudio.visible = false;
				
			//Hyper link functions
			function goToHyper1(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink1Content);
				navigateToURL (request, "_blank");	
			}// End goToHyper1
			function goToHyper2(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink2Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper1
			function goToHyper3(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink3Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper1
			function goToHyper4(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink4Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper1
			function goToHyper5(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink5Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper1
			function goToHyper6(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink6Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper6
			function goToHyper7(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink7Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper7
			function goToHyper8(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink8Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper8
			function goToHyper9(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink9Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper9
			function goToHyper10(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink10Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper10
			function goToHyper11(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink11Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper11
			function goToHyper12(e:MouseEvent):void{
				var request:URLRequest = new URLRequest(hyperLink12Content);
				navigateToURL (request, "_blank");		
			}// End goToHyper12
			
		}// End show links
		
		public function scrollHypersDown(e:MouseEvent):void{
			TweenLite.to(projectorBack.linksArea.allHypers.connectedHypers, 1, {y:-159});
			projectorBack.linksArea.upHyper.gotoAndStop(1);
			projectorBack.linksArea.downHyper.gotoAndStop(2);
		}// End scrollHypersDown
		public function scrollHypersUp(e:MouseEvent):void{
			TweenLite.to(projectorBack.linksArea.allHypers.connectedHypers, 1, {y:0});
			projectorBack.linksArea.upHyper.gotoAndStop(2);
			projectorBack.linksArea.downHyper.gotoAndStop(1);
		}// End scrollHypersUp
		
		//Add functions to tab clicks
		public function linkTabClick(e:MouseEvent = null):void{
			//Establish Pers 1 Doc Path
			pers1Doc1 = currentPageTag.perspectives.perspective1.docLink1.@linkPath;
			pers1Doc2 = currentPageTag.perspectives.perspective1.docLink2.@linkPath;
			pers1Doc3 = currentPageTag.perspectives.perspective1.docLink3.@linkPath;
			pers1Doc4 = currentPageTag.perspectives.perspective1.docLink4.@linkPath;
			pers1Doc5 = currentPageTag.perspectives.perspective1.docLink5.@linkPath;
			pers1Doc6 = currentPageTag.perspectives.perspective1.docLink6.@linkPath;
			
			//Establish Pers 2 Doc Path
			pers2Doc1 = currentPageTag.perspectives.perspective2.docLink1.@linkPath;
			pers2Doc2 = currentPageTag.perspectives.perspective2.docLink2.@linkPath;
			pers2Doc3 = currentPageTag.perspectives.perspective2.docLink3.@linkPath;
			pers2Doc4 = currentPageTag.perspectives.perspective2.docLink4.@linkPath;
			pers2Doc5 = currentPageTag.perspectives.perspective2.docLink5.@linkPath;
			pers2Doc6 = currentPageTag.perspectives.perspective2.docLink6.@linkPath;
			
			//Establish Pers 3 Doc Path
			pers3Doc1 = currentPageTag.perspectives.perspective3.docLink1.@linkPath;
			pers3Doc2 = currentPageTag.perspectives.perspective3.docLink2.@linkPath;
			pers3Doc3 = currentPageTag.perspectives.perspective3.docLink3.@linkPath;
			pers3Doc4 = currentPageTag.perspectives.perspective3.docLink4.@linkPath;
			pers3Doc5 = currentPageTag.perspectives.perspective3.docLink5.@linkPath;
			pers3Doc6 = currentPageTag.perspectives.perspective3.docLink6.@linkPath;
			
			//Establish Pers 4 Doc Path
			pers4Doc1 = currentPageTag.perspectives.perspective4.docLink1.@linkPath;
			pers4Doc2 = currentPageTag.perspectives.perspective4.docLink2.@linkPath;
			pers4Doc3 = currentPageTag.perspectives.perspective4.docLink3.@linkPath;
			pers4Doc4 = currentPageTag.perspectives.perspective4.docLink4.@linkPath;
			pers4Doc5 = currentPageTag.perspectives.perspective4.docLink5.@linkPath;
			pers4Doc6 = currentPageTag.perspectives.perspective4.docLink6.@linkPath;
			
			//Establish Pers 5 Doc Path
			pers5Doc1 = currentPageTag.perspectives.perspective5.docLink1.@linkPath;
			pers5Doc2 = currentPageTag.perspectives.perspective5.docLink2.@linkPath;
			pers5Doc3 = currentPageTag.perspectives.perspective5.docLink3.@linkPath;
			pers5Doc4 = currentPageTag.perspectives.perspective5.docLink4.@linkPath;
			pers5Doc5 = currentPageTag.perspectives.perspective5.docLink5.@linkPath;
			pers5Doc6 = currentPageTag.perspectives.perspective5.docLink6.@linkPath;
			
			//Establish Pers 6 Doc Path
			pers6Doc1 = currentPageTag.perspectives.perspective6.docLink1.@linkPath;
			pers6Doc2 = currentPageTag.perspectives.perspective6.docLink2.@linkPath;
			pers6Doc3 = currentPageTag.perspectives.perspective6.docLink3.@linkPath;
			pers6Doc4 = currentPageTag.perspectives.perspective6.docLink4.@linkPath;
			pers6Doc5 = currentPageTag.perspectives.perspective6.docLink5.@linkPath;
			pers6Doc6 = currentPageTag.perspectives.perspective6.docLink6.@linkPath;
			
			//Establish link to content locations
			if (pers == "perspective1"){
				docLink1Content = pers1Doc1;
				docLink2Content = pers1Doc2;
				docLink3Content = pers1Doc3;
				docLink4Content = pers1Doc4;
				docLink5Content = pers1Doc5;
				docLink6Content = pers1Doc6;
			} else if (pers == "perspective2"){
				docLink1Content = pers2Doc1;
				docLink2Content = pers2Doc2;
				docLink3Content = pers2Doc3;
				docLink4Content = pers2Doc4;
				docLink5Content = pers2Doc5;
				docLink6Content = pers2Doc6;
			} else if (pers == "perspective3"){
				docLink1Content = pers3Doc1;
				docLink2Content = pers3Doc2;
				docLink3Content = pers3Doc3;
				docLink4Content = pers3Doc4;
				docLink5Content = pers3Doc5;
				docLink6Content = pers3Doc6;
			} else if (pers == "perspective4"){
				docLink1Content = pers4Doc1;
				docLink2Content = pers4Doc2;
				docLink3Content = pers4Doc3;
				docLink4Content = pers4Doc4;
				docLink5Content = pers4Doc5;
				docLink6Content = pers4Doc6;
			} else if (pers == "perspective5"){
				docLink1Content = pers5Doc1;
				docLink2Content = pers5Doc2;
				docLink3Content = pers5Doc3;
				docLink4Content = pers5Doc4;
				docLink5Content = pers5Doc5;
				docLink6Content = pers5Doc6;
			} else if (pers == "perspective6"){
				docLink1Content = pers6Doc1;
				docLink2Content = pers6Doc2;
				docLink3Content = pers6Doc3;
				docLink4Content = pers6Doc4;
				docLink5Content = pers6Doc5;
				docLink6Content = pers6Doc6;
			}
			
			//Setting content path for media
			pers1Media1 = currentPageTag.perspectives.perspective1.mediaLink1.@linkPath;
			pers1Media2 = currentPageTag.perspectives.perspective1.mediaLink2.@linkPath;
			pers1Media3 = currentPageTag.perspectives.perspective1.mediaLink3.@linkPath;
			pers1Media4 = currentPageTag.perspectives.perspective1.mediaLink4.@linkPath;
			pers1Media5 = currentPageTag.perspectives.perspective1.mediaLink5.@linkPath;
			pers1Media6 = currentPageTag.perspectives.perspective1.mediaLink6.@linkPath;
			
			pers2Media1 = currentPageTag.perspectives.perspective2.mediaLink1.@linkPath;
			pers2Media2 = currentPageTag.perspectives.perspective2.mediaLink2.@linkPath;
			pers2Media3 = currentPageTag.perspectives.perspective2.mediaLink3.@linkPath;
			pers2Media4 = currentPageTag.perspectives.perspective2.mediaLink4.@linkPath;
			pers2Media5 = currentPageTag.perspectives.perspective2.mediaLink5.@linkPath;
			pers2Media6 = currentPageTag.perspectives.perspective2.mediaLink6.@linkPath;
			
			pers3Media1 = currentPageTag.perspectives.perspective3.mediaLink1.@linkPath;
			pers3Media2 = currentPageTag.perspectives.perspective3.mediaLink2.@linkPath;
			pers3Media3 = currentPageTag.perspectives.perspective3.mediaLink3.@linkPath;
			pers3Media4 = currentPageTag.perspectives.perspective3.mediaLink4.@linkPath;
			pers3Media5 = currentPageTag.perspectives.perspective3.mediaLink5.@linkPath;
			pers3Media6 = currentPageTag.perspectives.perspective3.mediaLink6.@linkPath;
			
			pers4Media1 = currentPageTag.perspectives.perspective4.mediaLink1.@linkPath;
			pers4Media2 = currentPageTag.perspectives.perspective4.mediaLink2.@linkPath;
			pers4Media3 = currentPageTag.perspectives.perspective4.mediaLink3.@linkPath;
			pers4Media4 = currentPageTag.perspectives.perspective4.mediaLink4.@linkPath;
			pers4Media5 = currentPageTag.perspectives.perspective4.mediaLink5.@linkPath;
			pers4Media6 = currentPageTag.perspectives.perspective4.mediaLink6.@linkPath;
			
			pers5Media1 = currentPageTag.perspectives.perspective5.mediaLink1.@linkPath;
			pers5Media2 = currentPageTag.perspectives.perspective5.mediaLink2.@linkPath;
			pers5Media3 = currentPageTag.perspectives.perspective5.mediaLink3.@linkPath;
			pers5Media4 = currentPageTag.perspectives.perspective5.mediaLink4.@linkPath;
			pers5Media5 = currentPageTag.perspectives.perspective5.mediaLink5.@linkPath;
			pers5Media6 = currentPageTag.perspectives.perspective5.mediaLink6.@linkPath;
			
			pers6Media1 = currentPageTag.perspectives.perspective6.mediaLink1.@linkPath;
			pers6Media2 = currentPageTag.perspectives.perspective6.mediaLink2.@linkPath;
			pers6Media3 = currentPageTag.perspectives.perspective6.mediaLink3.@linkPath;
			pers6Media4 = currentPageTag.perspectives.perspective6.mediaLink4.@linkPath;
			pers6Media5 = currentPageTag.perspectives.perspective6.mediaLink5.@linkPath;
			pers6Media6 = currentPageTag.perspectives.perspective6.mediaLink6.@linkPath;
			
			//Establish path to videos for links for videos
			if (pers == "perspective1"){
				mediaLink1Content = pers1Media1;
				mediaLink2Content = pers1Media2;
				mediaLink3Content = pers1Media3;
				mediaLink4Content = pers1Media4;
				mediaLink5Content = pers1Media5;
				mediaLink6Content = pers1Media6;
			} else if (pers == "perspective2"){
				mediaLink1Content = pers2Media1;
				mediaLink2Content = pers2Media2;
				mediaLink3Content = pers2Media3;
				mediaLink4Content = pers2Media4;
				mediaLink5Content = pers2Media5;
				mediaLink6Content = pers2Media6;
			} else if (pers == "perspective3"){
				mediaLink1Content = pers3Media1;
				mediaLink2Content = pers3Media2;
				mediaLink3Content = pers3Media3;
				mediaLink4Content = pers3Media4;
				mediaLink5Content = pers3Media5;
				mediaLink6Content = pers3Media6;
			} else if (pers == "perspective4"){
				mediaLink1Content = pers4Media1;
				mediaLink2Content = pers4Media2;
				mediaLink3Content = pers4Media3;
				mediaLink4Content = pers4Media4;
				mediaLink5Content = pers4Media5;
				mediaLink6Content = pers4Media6;
			} else if (pers == "perspective5"){
				mediaLink1Content = pers5Media1;
				mediaLink2Content = pers5Media2;
				mediaLink3Content = pers5Media3;
				mediaLink4Content = pers5Media4;
				mediaLink5Content = pers5Media5;
				mediaLink6Content = pers5Media6;
			} else if (pers == "perspective6"){
				mediaLink1Content = pers6Media1;
				mediaLink2Content = pers6Media2;
				mediaLink3Content = pers6Media3;
				mediaLink4Content = pers6Media4;
				mediaLink5Content = pers6Media5;
				mediaLink6Content = pers6Media6;
			}
			
			
			//Audio or Video
			audioOrVideo = currentPageTag.perspectives.perspective1.mediaLink1.@typeOfMedia;
			audioOrVideo2 = currentPageTag.perspectives.perspective1.mediaLink2.@typeOfMedia;
			audioOrVideo3 = currentPageTag.perspectives.perspective1.mediaLink3.@typeOfMedia;
			audioOrVideo4 = currentPageTag.perspectives.perspective1.mediaLink4.@typeOfMedia;
			audioOrVideo5 = currentPageTag.perspectives.perspective1.mediaLink5.@typeOfMedia;
			audioOrVideo6 = currentPageTag.perspectives.perspective1.mediaLink5.@typeOfMedia;
			
			//Put this in the if statnments for media
			//mediaLink1Content.indexOf(".swf") > -1
				
			//Image Variables
			var imageRequest1:URLRequest = new URLRequest(mediaLink1Content);
			var imageLoader1:Loader = new Loader;
			var imageRequest2:URLRequest = new URLRequest(mediaLink2Content);
			var imageLoader2:Loader = new Loader;
			var imageRequest3:URLRequest = new URLRequest(mediaLink3Content);
			var imageLoader3:Loader = new Loader;
			var imageRequest4:URLRequest = new URLRequest(mediaLink4Content);
			var imageLoader4:Loader = new Loader;
			var imageRequest5:URLRequest = new URLRequest(mediaLink5Content);
			var imageLoader5:Loader = new Loader;
			var imageRequest6:URLRequest = new URLRequest(mediaLink6Content);
			var imageLoader6:Loader = new Loader;
			
			if(e.currentTarget==projectorBack.linksArea.tab1){
				if (sndChannel1) {
					sndChannel1.stop();
				}
				if (sndChannel2) {
					sndChannel2.stop();
				}
				if (sndChannel3) {
					sndChannel3.stop();
				}
				if (sndChannel4) {
					sndChannel4.stop();
				}
				if (sndChannel5) {
					sndChannel5.stop();
				}
				if (sndChannel6) {
					sndChannel6.stop();
				}
				
				//Set Links Tab Names
				projectorBack.linksArea.hyperTab.htmlText = "<b>" + currentPageTag.@hyperLinkTab + "</b>";
				tab2Media.docsTab.htmlText = "<b>" + currentPageTag.@docsLinkTab + "</b>";
				tab3Media.mediaTab.htmlText = "<b>" + currentPageTag.@meidaLinksTab + "</b>";
			
				//Establish Hyperlink locations
				if(pers == "perspective1"){
					hyperLink1Content = pers1Hyper1;
					hyperLink2Content = pers1Hyper2;
					hyperLink3Content = pers1Hyper3;
					hyperLink4Content = pers1Hyper4;
					hyperLink5Content = pers1Hyper5;
					hyperLink6Content = pers1Hyper6;
					hyperLink7Content = pers1Hyper7;
					hyperLink8Content = pers1Hyper8;
					hyperLink9Content = pers1Hyper9;
					hyperLink10Content = pers1Hyper10;
					hyperLink11Content = pers1Hyper11;
					hyperLink12Content = pers1Hyper12;
				} else if (pers == "perspective2"){
					hyperLink1Content = pers2Hyper1;
					hyperLink2Content = pers2Hyper2;
					hyperLink3Content = pers2Hyper3;
					hyperLink4Content = pers2Hyper4;
					hyperLink5Content = pers2Hyper5;
					hyperLink6Content = pers2Hyper6;
					hyperLink7Content = pers2Hyper7;
					hyperLink8Content = pers2Hyper8;
					hyperLink9Content = pers2Hyper9;
					hyperLink10Content = pers2Hyper10;
					hyperLink11Content = pers2Hyper11;
					hyperLink12Content = pers2Hyper12;
				} else if (pers == "perspective3"){
					hyperLink1Content = pers3Hyper1;
					hyperLink2Content = pers3Hyper2;
					hyperLink3Content = pers3Hyper3;
					hyperLink4Content = pers3Hyper4;
					hyperLink5Content = pers3Hyper5;
					hyperLink6Content = pers3Hyper6;
					hyperLink7Content = pers3Hyper7;
					hyperLink8Content = pers3Hyper8;
					hyperLink9Content = pers3Hyper9;
					hyperLink10Content = pers3Hyper10;
					hyperLink11Content = pers3Hyper11;
					hyperLink12Content = pers3Hyper12;
				} else if (pers == "perspective4"){
					hyperLink1Content = pers4Hyper1;
					hyperLink2Content = pers4Hyper2;
					hyperLink3Content = pers4Hyper3;
					hyperLink4Content = pers4Hyper4;
					hyperLink5Content = pers4Hyper5;
					hyperLink6Content = pers4Hyper6;
					hyperLink7Content = pers4Hyper7;
					hyperLink8Content = pers4Hyper8;
					hyperLink9Content = pers4Hyper9;
					hyperLink10Content = pers4Hyper10;
					hyperLink11Content = pers4Hyper11;
					hyperLink12Content = pers4Hyper12;
				} else if (pers == "perspective5"){
					hyperLink1Content = pers5Hyper1;
					hyperLink2Content = pers5Hyper2;
					hyperLink3Content = pers5Hyper3;
					hyperLink4Content = pers5Hyper4;
					hyperLink5Content = pers5Hyper5;
					hyperLink6Content = pers5Hyper6;
					hyperLink7Content = pers5Hyper7;
					hyperLink8Content = pers5Hyper8;
					hyperLink9Content = pers5Hyper9;
					hyperLink10Content = pers5Hyper10;
					hyperLink11Content = pers5Hyper11;
					hyperLink12Content = pers5Hyper12;
				} else if (pers == "perspective6"){
					hyperLink1Content = pers6Hyper1;
					hyperLink2Content = pers6Hyper2;
					hyperLink3Content = pers6Hyper3;
					hyperLink4Content = pers6Hyper4;
					hyperLink5Content = pers6Hyper5;
					hyperLink6Content = pers6Hyper6;
					hyperLink7Content = pers6Hyper7;
					hyperLink8Content = pers6Hyper8;
					hyperLink9Content = pers6Hyper9;
					hyperLink10Content = pers6Hyper10;
					hyperLink11Content = pers6Hyper11;
					hyperLink12Content = pers6Hyper12;
				}
				//tab2Media Setting Buttons to Mouse Enabled
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.invisiBTN.buttonMode = true;
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.invisiBTN.buttonMode = true;
				
				//Show up and down buttons
				projectorBack.linksArea.downHyper.visible = true;
				projectorBack.linksArea.upHyper.visible = true;
			
				///Establish Hyperlink titles
				if(pers == "perspective1"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers1Hyper1Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers1Hyper2Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers1Hyper3Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers1Hyper4Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers1Hyper5Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers1Hyper6Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers1Hyper7Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers1Hyper8Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers1Hyper9Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers1Hyper10Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers1Hyper11Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers1Hyper12Title;
					// Buttons not visible if title not there for pers 
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers1Hyper1Title != "<b></b>" && pers1Hyper1Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers1Hyper2Title != "<b></b>" && pers1Hyper2Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers1Hyper3Title != "<b></b>" && pers1Hyper3Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers1Hyper4Title != "<b></b>" && pers1Hyper4Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers1Hyper5Title != "<b></b>" && pers1Hyper5Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers1Hyper6Title != "<b></b>" && pers1Hyper6Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers1Hyper7Title != "<b></b>" && pers1Hyper7Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers1Hyper8Title != "<b></b>" && pers1Hyper8Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers1Hyper9Title != "<b></b>" && pers1Hyper9Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers1Hyper10Title != "<b></b>" && pers1Hyper10Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers1Hyper11Title != "<b></b>" && pers1Hyper11Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers1Hyper12Title != "<b></b>" && pers1Hyper12Title != null);
				} else if(pers == "perspective2"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers2Hyper1Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers2Hyper2Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers2Hyper3Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers2Hyper4Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers2Hyper5Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers2Hyper6Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers2Hyper7Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers2Hyper8Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers2Hyper9Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers2Hyper10Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers2Hyper11Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers2Hyper12Title;
					// Buttons not visible if title not there for pers 
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers2Hyper1Title != "<b></b>" && pers2Hyper1Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers2Hyper2Title != "<b></b>" && pers2Hyper2Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers2Hyper3Title != "<b></b>" && pers2Hyper3Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers2Hyper4Title != "<b></b>" && pers2Hyper4Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers2Hyper5Title != "<b></b>" && pers2Hyper5Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers2Hyper6Title != "<b></b>" && pers2Hyper6Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers2Hyper7Title != "<b></b>" && pers2Hyper7Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers2Hyper8Title != "<b></b>" && pers2Hyper8Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers2Hyper9Title != "<b></b>" && pers2Hyper9Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers2Hyper10Title != "<b></b>" && pers2Hyper10Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers2Hyper11Title != "<b></b>" && pers2Hyper11Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers2Hyper12Title != "<b></b>" && pers2Hyper12Title != null);
				} else if (pers == "perspective3"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers3Hyper1Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers3Hyper2Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers3Hyper3Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers3Hyper4Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers3Hyper5Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers3Hyper6Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers3Hyper7Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers3Hyper8Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers3Hyper9Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers3Hyper10Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers3Hyper11Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers3Hyper12Title;
					// Buttons not visible if title not there for pers 
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers3Hyper1Title != "<b></b>" && pers3Hyper1Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers3Hyper2Title != "<b></b>" && pers3Hyper2Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers3Hyper3Title != "<b></b>" && pers3Hyper3Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers3Hyper4Title != "<b></b>" && pers3Hyper4Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers3Hyper5Title != "<b></b>" && pers3Hyper5Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers3Hyper6Title != "<b></b>" && pers3Hyper6Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers3Hyper7Title != "<b></b>" && pers3Hyper7Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers3Hyper8Title != "<b></b>" && pers3Hyper8Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers3Hyper9Title != "<b></b>" && pers3Hyper9Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers3Hyper10Title != "<b></b>" && pers3Hyper10Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers3Hyper11Title != "<b></b>" && pers3Hyper11Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers3Hyper12Title != "<b></b>" && pers3Hyper12Title != null);
				} else if (pers == "perspective4"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers4Hyper1Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers4Hyper2Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers4Hyper3Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers4Hyper4Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers4Hyper5Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers4Hyper6Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers4Hyper7Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers4Hyper8Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers4Hyper9Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers4Hyper10Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers4Hyper11Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers4Hyper12Title;
					// Buttons not visible if title not there for pers 
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers4Hyper1Title != "<b></b>" && pers4Hyper1Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers4Hyper2Title != "<b></b>" && pers4Hyper2Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers4Hyper3Title != "<b></b>" && pers4Hyper3Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers4Hyper4Title != "<b></b>" && pers4Hyper4Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers4Hyper5Title != "<b></b>" && pers4Hyper5Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers4Hyper6Title != "<b></b>" && pers4Hyper6Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers4Hyper7Title != "<b></b>" && pers4Hyper7Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers4Hyper8Title != "<b></b>" && pers4Hyper8Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers4Hyper9Title != "<b></b>" && pers4Hyper9Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers4Hyper10Title != "<b></b>" && pers4Hyper10Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers4Hyper11Title != "<b></b>" && pers4Hyper11Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers4Hyper12Title != "<b></b>" && pers4Hyper12Title != null);
				} else if (pers == "perspective5"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers5Hyper1Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers5Hyper2Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers5Hyper3Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers5Hyper4Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers5Hyper5Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers5Hyper6Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers5Hyper7Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers5Hyper8Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers5Hyper9Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers5Hyper10Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers5Hyper11Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers5Hyper12Title;
					// Buttons not visible if title not there for pers 
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers5Hyper1Title != "<b></b>" && pers5Hyper1Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers5Hyper2Title != "<b></b>" && pers5Hyper2Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers5Hyper3Title != "<b></b>" && pers5Hyper3Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers5Hyper4Title != "<b></b>" && pers5Hyper4Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers5Hyper5Title != "<b></b>" && pers5Hyper5Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers5Hyper6Title != "<b></b>" && pers5Hyper6Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers5Hyper7Title != "<b></b>" && pers5Hyper7Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers5Hyper8Title != "<b></b>" && pers5Hyper8Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers5Hyper9Title != "<b></b>" && pers5Hyper9Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers5Hyper10Title != "<b></b>" && pers5Hyper10Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers5Hyper11Title != "<b></b>" && pers5Hyper11Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers5Hyper12Title != "<b></b>" && pers5Hyper12Title != null);
				} else if (pers == "perspective6"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperTitle.htmlText = pers6Hyper1Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperTitle.htmlText = pers6Hyper2Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperTitle.htmlText = pers6Hyper3Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperTitle.htmlText = pers6Hyper4Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperTitle.htmlText = pers6Hyper5Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperTitle.htmlText = pers6Hyper6Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperTitle.htmlText = pers6Hyper7Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperTitle.htmlText = pers6Hyper8Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperTitle.htmlText = pers6Hyper9Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperTitle.htmlText = pers6Hyper10Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperTitle.htmlText = pers6Hyper11Title;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperTitle.htmlText = pers6Hyper12Title;
					// Buttons not visible if title not there for pers 
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.visible  = (pers6Hyper1Title != "<b></b>" && pers6Hyper1Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.visible  = (pers6Hyper2Title != "<b></b>" && pers6Hyper2Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.visible  = (pers6Hyper3Title != "<b></b>" && pers6Hyper3Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.visible  = (pers6Hyper4Title != "<b></b>" && pers6Hyper4Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.visible  = (pers6Hyper5Title != "<b></b>" && pers6Hyper5Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.visible  = (pers6Hyper6Title != "<b></b>" && pers6Hyper6Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.visible  = (pers6Hyper7Title != "<b></b>" && pers6Hyper7Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.visible  = (pers6Hyper8Title != "<b></b>" && pers6Hyper8Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.visible  = (pers6Hyper9Title != "<b></b>" && pers6Hyper9Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.visible  = (pers6Hyper10Title != "<b></b>" && pers6Hyper10Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.visible  = (pers6Hyper11Title != "<b></b>" && pers6Hyper11Title != null);
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.visible  = (pers6Hyper12Title != "<b></b>" && pers6Hyper12Title != null);
				}
				
				
				//Adding descriotions
				if(pers == "perspective1"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers1Hyper1Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers1Hyper2Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers1Hyper3Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers1Hyper4Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers1Hyper5Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers1Hyper6Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers1Hyper7Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers1Hyper8Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers1Hyper9Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers1Hyper10Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers1Hyper11Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers1Hyper12Desc;
				} else if (pers == "perspective2"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers2Hyper1Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers2Hyper2Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers2Hyper3Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers2Hyper4Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers2Hyper5Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers2Hyper6Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers2Hyper7Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers2Hyper8Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers2Hyper9Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers2Hyper10Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers2Hyper11Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers2Hyper12Desc;
				} else if (pers == "perspective3"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers3Hyper1Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers3Hyper2Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers3Hyper3Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers3Hyper4Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers3Hyper5Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers3Hyper6Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers3Hyper7Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers3Hyper8Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers3Hyper9Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers3Hyper10Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers3Hyper11Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers3Hyper12Desc;
				} else if (pers == "perspective4"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers4Hyper1Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers4Hyper2Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers4Hyper3Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers4Hyper4Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers4Hyper5Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers4Hyper6Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers4Hyper7Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers4Hyper8Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers4Hyper9Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers4Hyper10Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers4Hyper11Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers4Hyper12Desc;
				} else if (pers == "perspective5"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers5Hyper1Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers5Hyper2Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers5Hyper3Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers5Hyper4Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers5Hyper5Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers5Hyper6Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers5Hyper7Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers5Hyper8Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers5Hyper9Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers5Hyper10Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers5Hyper11Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers5Hyper12Desc;
				} else if (pers == "perspective6"){
					projectorBack.linksArea.allHypers.connectedHypers.hyper1.hyperDesc.htmlText = pers6Hyper1Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper2.hyperDesc.htmlText = pers6Hyper2Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper3.hyperDesc.htmlText = pers6Hyper3Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper4.hyperDesc.htmlText = pers6Hyper4Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper5.hyperDesc.htmlText = pers6Hyper5Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper6.hyperDesc.htmlText = pers6Hyper6Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper7.hyperDesc.htmlText = pers6Hyper7Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper8.hyperDesc.htmlText = pers6Hyper8Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper9.hyperDesc.htmlText = pers6Hyper9Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper10.hyperDesc.htmlText = pers6Hyper10Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper11.hyperDesc.htmlText = pers6Hyper11Desc;
					projectorBack.linksArea.allHypers.connectedHypers.hyper12.hyperDesc.htmlText = pers6Hyper12Desc;
				}
				
				//Setting tab indexs for Hyperlinks area
				projectorBack.linksArea.setChildIndex(tab2Media, 0);
				projectorBack.linksArea.setChildIndex(tab3Media, 0);
				projectorBack.linksArea.setChildIndex(tab4Media, 0);
				projectorBack.linksArea.setChildIndex(projectorBack.linksArea.allHypers, 9);
				//projectorBack.linksArea.setChildIndex(tab6Media, 0);
				//Adding event listeners to buttons
				projectorBack.linksArea.allHypers.connectedHypers.hyper1.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper1);
				projectorBack.linksArea.allHypers.connectedHypers.hyper2.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper2);
				projectorBack.linksArea.allHypers.connectedHypers.hyper3.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper3);
				projectorBack.linksArea.allHypers.connectedHypers.hyper4.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper4);
				projectorBack.linksArea.allHypers.connectedHypers.hyper5.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper5);
				projectorBack.linksArea.allHypers.connectedHypers.hyper6.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper6);
				projectorBack.linksArea.allHypers.connectedHypers.hyper7.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper7);
				projectorBack.linksArea.allHypers.connectedHypers.hyper8.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper8);
				projectorBack.linksArea.allHypers.connectedHypers.hyper9.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper9);
				projectorBack.linksArea.allHypers.connectedHypers.hyper10.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper10);
				projectorBack.linksArea.allHypers.connectedHypers.hyper11.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper11);
				projectorBack.linksArea.allHypers.connectedHypers.hyper12.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToHyper12);
				
				//Hyper link functions
				function goToHyper1(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink1Content);
					navigateToURL (request, "_blank");	
				}// End goToHyper1
				function goToHyper2(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink2Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper1
				function goToHyper3(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink3Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper1
				function goToHyper4(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink4Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper1
				function goToHyper5(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink5Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper1
				function goToHyper6(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink6Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper6
				function goToHyper7(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink7Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper7
				function goToHyper8(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink8Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper8
				function goToHyper9(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink9Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper9
				function goToHyper10(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink10Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper10
				function goToHyper11(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink11Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper11
				function goToHyper12(e:MouseEvent):void{
					var request:URLRequest = new URLRequest(hyperLink12Content);
					navigateToURL (request, "_blank");		
				}// End goToHyper12
				
				
			} else if (e.currentTarget==projectorBack.linksArea.tab2){
				if (sndChannel1) {
					sndChannel1.stop();
				}
				if (sndChannel2) {
					sndChannel2.stop();
				}
				if (sndChannel3) {
					sndChannel3.stop();
				}
				if (sndChannel4) {
					sndChannel4.stop();
				}
				if (sndChannel5) {
					sndChannel5.stop();
				}
				if (sndChannel6) {
					sndChannel6.stop();
				}
				
				//tab2Media Setting Buttons to Mouse Enabled
				tab2Media.docs1.invisiBTN.buttonMode = true;
				tab2Media.docs2.invisiBTN.buttonMode = true;
				tab2Media.docs3.invisiBTN.buttonMode = true;
				tab2Media.docs4.invisiBTN.buttonMode = true;
				tab2Media.docs5.invisiBTN.buttonMode = true;
				tab2Media.docs6.invisiBTN.buttonMode = true;
				
				//Add Event Listeners
				tab2Media.docs1.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToDoc1);
				tab2Media.docs2.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToDoc2);
				tab2Media.docs3.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToDoc3);
				tab2Media.docs4.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToDoc4);
				tab2Media.docs5.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToDoc5);
				tab2Media.docs6.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, goToDoc6);
				
				//hide up and down buttons
				projectorBack.linksArea.downHyper.visible = false;
				projectorBack.linksArea.upHyper.visible = false;
				
				//Set Links Tab Names
				projectorBack.linksArea.hyperTab.htmlText = "<b>" + currentPageTag.@hyperLinkTab + "</b>";
				tab2Media.docsTab.htmlText = "<b>" + currentPageTag.@docsLinkTab + "</b>";
				tab3Media.mediaTab.htmlText = "<b>" + currentPageTag.@meidaLinksTab + "</b>";
				
				// Settings for doc titles content
				pers1Doc1Title = "<b>" + currentPageTag.perspectives.perspective1.docLink1.@docTitle + "</b>";
				pers1Doc2Title = "<b>" + currentPageTag.perspectives.perspective1.docLink2.@docTitle + "</b>";
				pers1Doc3Title = "<b>" + currentPageTag.perspectives.perspective1.docLink3.@docTitle + "</b>";
				pers1Doc4Title = "<b>" + currentPageTag.perspectives.perspective1.docLink4.@docTitle + "</b>";
				pers1Doc5Title = "<b>" + currentPageTag.perspectives.perspective1.docLink5.@docTitle + "</b>";
				pers1Doc6Title = "<b>" + currentPageTag.perspectives.perspective1.docLink6.@docTitle + "</b>";
				
				pers2Doc1Title = "<b>" + currentPageTag.perspectives.perspective2.docLink1.@docTitle + "</b>";
				pers2Doc2Title = "<b>" + currentPageTag.perspectives.perspective2.docLink2.@docTitle + "</b>";
				pers2Doc3Title = "<b>" + currentPageTag.perspectives.perspective2.docLink3.@docTitle + "</b>";
				pers2Doc4Title = "<b>" + currentPageTag.perspectives.perspective2.docLink4.@docTitle + "</b>";
				pers2Doc5Title = "<b>" + currentPageTag.perspectives.perspective2.docLink5.@docTitle + "</b>";
				pers2Doc6Title = "<b>" + currentPageTag.perspectives.perspective2.docLink6.@docTitle + "</b>";
				
				pers3Doc1Title = "<b>" + currentPageTag.perspectives.perspective3.docLink1.@docTitle + "</b>";
				pers3Doc2Title = "<b>" + currentPageTag.perspectives.perspective3.docLink2.@docTitle + "</b>";
				pers3Doc3Title = "<b>" + currentPageTag.perspectives.perspective3.docLink3.@docTitle + "</b>";
				pers3Doc4Title = "<b>" + currentPageTag.perspectives.perspective3.docLink4.@docTitle + "</b>";
				pers3Doc5Title = "<b>" + currentPageTag.perspectives.perspective3.docLink5.@docTitle + "</b>";
				pers3Doc6Title = "<b>" + currentPageTag.perspectives.perspective3.docLink6.@docTitle + "</b>";
				
				pers4Doc1Title = "<b>" + currentPageTag.perspectives.perspective4.docLink1.@docTitle + "</b>";
				pers4Doc2Title = "<b>" + currentPageTag.perspectives.perspective4.docLink2.@docTitle + "</b>";
				pers4Doc3Title = "<b>" + currentPageTag.perspectives.perspective4.docLink3.@docTitle + "</b>";
				pers4Doc4Title = "<b>" + currentPageTag.perspectives.perspective4.docLink4.@docTitle + "</b>";
				pers4Doc5Title = "<b>" + currentPageTag.perspectives.perspective4.docLink5.@docTitle + "</b>";
				pers4Doc6Title = "<b>" + currentPageTag.perspectives.perspective4.docLink6.@docTitle + "</b>";
				
				pers5Doc1Title = "<b>" + currentPageTag.perspectives.perspective5.docLink1.@docTitle + "</b>";
				pers5Doc2Title = "<b>" + currentPageTag.perspectives.perspective5.docLink2.@docTitle + "</b>";
				pers5Doc3Title = "<b>" + currentPageTag.perspectives.perspective5.docLink3.@docTitle + "</b>";
				pers5Doc4Title = "<b>" + currentPageTag.perspectives.perspective5.docLink4.@docTitle + "</b>";
				pers5Doc5Title = "<b>" + currentPageTag.perspectives.perspective5.docLink5.@docTitle + "</b>";
				pers5Doc6Title = "<b>" + currentPageTag.perspectives.perspective5.docLink6.@docTitle + "</b>";
				
				pers6Doc1Title = "<b>" + currentPageTag.perspectives.perspective6.docLink1.@docTitle + "</b>";
				pers6Doc2Title = "<b>" + currentPageTag.perspectives.perspective6.docLink2.@docTitle + "</b>";
				pers6Doc3Title = "<b>" + currentPageTag.perspectives.perspective6.docLink3.@docTitle + "</b>";
				pers6Doc4Title = "<b>" + currentPageTag.perspectives.perspective6.docLink4.@docTitle + "</b>";
				pers6Doc5Title = "<b>" + currentPageTag.perspectives.perspective6.docLink5.@docTitle + "</b>";
				pers6Doc6Title = "<b>" + currentPageTag.perspectives.perspective6.docLink6.@docTitle + "</b>";
				
				//Setting titles for docs area
				if(pers == "perspective1"){
					tab2Media.docs1.docTitle.htmlText = pers1Doc1Title;
					tab2Media.docs2.docTitle.htmlText = pers1Doc2Title;
					tab2Media.docs3.docTitle.htmlText = pers1Doc3Title;
					tab2Media.docs4.docTitle.htmlText = pers1Doc4Title;
					tab2Media.docs5.docTitle.htmlText = pers1Doc5Title;
					tab2Media.docs6.docTitle.htmlText = pers1Doc6Title;
					// If no title do not show
					tab2Media.docs1.visible  = (pers1Doc1Title != "<b></b>" && pers1Doc1Title != null);
					tab2Media.docs2.visible  = (pers1Doc2Title != "<b></b>" && pers1Doc2Title != null);
					tab2Media.docs3.visible  = (pers1Doc3Title != "<b></b>" && pers1Doc3Title != null);
					tab2Media.docs4.visible  = (pers1Doc4Title != "<b></b>" && pers1Doc4Title != null);
					tab2Media.docs5.visible  = (pers1Doc5Title != "<b></b>" && pers1Doc5Title != null);
					tab2Media.docs6.visible  = (pers1Doc6Title != "<b></b>" && pers1Doc6Title != null);
				} else if (pers == "perspective2"){
					tab2Media.docs1.docTitle.htmlText = pers2Doc1Title;
					tab2Media.docs2.docTitle.htmlText = pers2Doc2Title;
					tab2Media.docs3.docTitle.htmlText = pers2Doc3Title;
					tab2Media.docs4.docTitle.htmlText = pers2Doc4Title;
					tab2Media.docs5.docTitle.htmlText = pers2Doc5Title;
					tab2Media.docs6.docTitle.htmlText = pers2Doc6Title;
					// If no title do not show
					tab2Media.docs1.visible  = (pers2Doc1Title != "<b></b>" && pers2Doc1Title != null);
					tab2Media.docs2.visible  = (pers2Doc2Title != "<b></b>" && pers2Doc2Title != null);
					tab2Media.docs3.visible  = (pers2Doc3Title != "<b></b>" && pers2Doc3Title != null);
					tab2Media.docs4.visible  = (pers2Doc4Title != "<b></b>" && pers2Doc4Title != null);
					tab2Media.docs5.visible  = (pers2Doc5Title != "<b></b>" && pers2Doc5Title != null);
					tab2Media.docs6.visible  = (pers2Doc6Title != "<b></b>" && pers2Doc6Title != null);
				} else if (pers == "perspective3"){
					tab2Media.docs1.docTitle.htmlText = pers3Doc1Title;
					tab2Media.docs2.docTitle.htmlText = pers3Doc2Title;
					tab2Media.docs3.docTitle.htmlText = pers3Doc3Title;
					tab2Media.docs4.docTitle.htmlText = pers3Doc4Title;
					tab2Media.docs5.docTitle.htmlText = pers3Doc5Title;
					tab2Media.docs6.docTitle.htmlText = pers3Doc6Title;
					// If no title do not show
					tab2Media.docs1.visible  = (pers3Doc1Title != "<b></b>" && pers3Doc1Title != null);
					tab2Media.docs2.visible  = (pers3Doc2Title != "<b></b>" && pers3Doc2Title != null);
					tab2Media.docs3.visible  = (pers3Doc3Title != "<b></b>" && pers3Doc3Title != null);
					tab2Media.docs4.visible  = (pers3Doc4Title != "<b></b>" && pers3Doc4Title != null);
					tab2Media.docs5.visible  = (pers3Doc5Title != "<b></b>" && pers3Doc5Title != null);
					tab2Media.docs6.visible  = (pers3Doc6Title != "<b></b>" && pers3Doc6Title != null);
				} else if (pers == "perspective4"){
					tab2Media.docs1.docTitle.htmlText = pers4Doc1Title;
					tab2Media.docs2.docTitle.htmlText = pers4Doc2Title;
					tab2Media.docs3.docTitle.htmlText = pers4Doc3Title;
					tab2Media.docs4.docTitle.htmlText = pers4Doc4Title;
					tab2Media.docs5.docTitle.htmlText = pers4Doc5Title;
					tab2Media.docs6.docTitle.htmlText = pers4Doc6Title;
					// If no title do not show
					tab2Media.docs1.visible  = (pers4Doc1Title != "<b></b>" && pers4Doc1Title != null);
					tab2Media.docs2.visible  = (pers4Doc2Title != "<b></b>" && pers4Doc2Title != null);
					tab2Media.docs3.visible  = (pers4Doc3Title != "<b></b>" && pers4Doc3Title != null);
					tab2Media.docs4.visible  = (pers4Doc4Title != "<b></b>" && pers4Doc4Title != null);
					tab2Media.docs5.visible  = (pers4Doc5Title != "<b></b>" && pers4Doc5Title != null);
					tab2Media.docs6.visible  = (pers4Doc6Title != "<b></b>" && pers4Doc6Title != null);
				} else if (pers == "perspective5"){
					tab2Media.docs1.docTitle.htmlText = pers5Doc1Title;
					tab2Media.docs2.docTitle.htmlText = pers5Doc2Title;
					tab2Media.docs3.docTitle.htmlText = pers5Doc3Title;
					tab2Media.docs4.docTitle.htmlText = pers5Doc4Title;
					tab2Media.docs5.docTitle.htmlText = pers5Doc5Title;
					tab2Media.docs6.docTitle.htmlText = pers5Doc6Title;
					// If no title do not show
					tab2Media.docs1.visible  = (pers5Doc1Title != "<b></b>" && pers5Doc1Title != null);
					tab2Media.docs2.visible  = (pers5Doc2Title != "<b></b>" && pers5Doc2Title != null);
					tab2Media.docs3.visible  = (pers5Doc3Title != "<b></b>" && pers5Doc3Title != null);
					tab2Media.docs4.visible  = (pers5Doc4Title != "<b></b>" && pers5Doc4Title != null);
					tab2Media.docs5.visible  = (pers5Doc5Title != "<b></b>" && pers5Doc5Title != null);
					tab2Media.docs6.visible  = (pers5Doc6Title != "<b></b>" && pers5Doc6Title != null);
				} else if (pers == "perspective6"){
					tab2Media.docs1.docTitle.htmlText = pers6Doc1Title;
					tab2Media.docs2.docTitle.htmlText = pers6Doc2Title;
					tab2Media.docs3.docTitle.htmlText = pers6Doc3Title;
					tab2Media.docs4.docTitle.htmlText = pers6Doc4Title;
					tab2Media.docs5.docTitle.htmlText = pers6Doc5Title;
					tab2Media.docs6.docTitle.htmlText = pers6Doc6Title;
					// If no title do not show
					tab2Media.docs1.visible  = (pers6Doc1Title != "<b></b>" && pers6Doc1Title != null);
					tab2Media.docs2.visible  = (pers6Doc2Title != "<b></b>" && pers6Doc2Title != null);
					tab2Media.docs3.visible  = (pers6Doc3Title != "<b></b>" && pers6Doc3Title != null);
					tab2Media.docs4.visible  = (pers6Doc4Title != "<b></b>" && pers6Doc4Title != null);
					tab2Media.docs5.visible  = (pers6Doc5Title != "<b></b>" && pers6Doc5Title != null);
					tab2Media.docs6.visible  = (pers6Doc6Title != "<b></b>" && pers6Doc6Title != null);
				}
				
				//Setting content for doc descriotion area
				pers1Doc1Desc = currentPageTag.perspectives.perspective1.docLink1;
				pers1Doc2Desc = currentPageTag.perspectives.perspective1.docLink2;
				pers1Doc3Desc = currentPageTag.perspectives.perspective1.docLink3;
				pers1Doc4Desc = currentPageTag.perspectives.perspective1.docLink4;
				pers1Doc5Desc = currentPageTag.perspectives.perspective1.docLink5;
				pers1Doc6Desc = currentPageTag.perspectives.perspective1.docLink6;
				
				pers2Doc1Desc = currentPageTag.perspectives.perspective2.docLink1;
				pers2Doc2Desc = currentPageTag.perspectives.perspective2.docLink2;
				pers2Doc3Desc = currentPageTag.perspectives.perspective2.docLink3;
				pers2Doc4Desc = currentPageTag.perspectives.perspective2.docLink4;
				pers2Doc5Desc = currentPageTag.perspectives.perspective2.docLink5;
				pers2Doc6Desc = currentPageTag.perspectives.perspective2.docLink6;
				
				pers3Doc1Desc = currentPageTag.perspectives.perspective3.docLink1;
				pers3Doc2Desc = currentPageTag.perspectives.perspective3.docLink2;
				pers3Doc3Desc = currentPageTag.perspectives.perspective3.docLink3;
				pers3Doc4Desc = currentPageTag.perspectives.perspective3.docLink4;
				pers3Doc5Desc = currentPageTag.perspectives.perspective3.docLink5;
				pers3Doc6Desc = currentPageTag.perspectives.perspective3.docLink6;
				
				pers4Doc1Desc = currentPageTag.perspectives.perspective4.docLink1;
				pers4Doc2Desc = currentPageTag.perspectives.perspective4.docLink2;
				pers4Doc3Desc = currentPageTag.perspectives.perspective4.docLink3;
				pers4Doc4Desc = currentPageTag.perspectives.perspective4.docLink4;
				pers4Doc5Desc = currentPageTag.perspectives.perspective4.docLink5;
				pers4Doc6Desc = currentPageTag.perspectives.perspective4.docLink6;
				
				pers5Doc1Desc = currentPageTag.perspectives.perspective5.docLink1;
				pers5Doc2Desc = currentPageTag.perspectives.perspective5.docLink2;
				pers5Doc3Desc = currentPageTag.perspectives.perspective5.docLink3;
				pers5Doc4Desc = currentPageTag.perspectives.perspective5.docLink4;
				pers5Doc5Desc = currentPageTag.perspectives.perspective5.docLink5;
				pers5Doc6Desc = currentPageTag.perspectives.perspective5.docLink6;
				
				pers6Doc1Desc = currentPageTag.perspectives.perspective6.docLink1;
				pers6Doc2Desc = currentPageTag.perspectives.perspective6.docLink2;
				pers6Doc3Desc = currentPageTag.perspectives.perspective6.docLink3;
				pers6Doc4Desc = currentPageTag.perspectives.perspective6.docLink4;
				pers6Doc5Desc = currentPageTag.perspectives.perspective6.docLink5;
				pers6Doc6Desc = currentPageTag.perspectives.perspective6.docLink6;
			
				
				//Seeting the description of docs area
				tab2Media.docs1.docDesc.htmlText = currentPageTag.perspectives.perspective2.docLink1;
				tab2Media.docs2.docDesc.htmlText = currentPageTag.perspectives.perspective2.docLink2;
				tab2Media.docs3.docDesc.htmlText = currentPageTag.perspectives.perspective2.docLink3;
				tab2Media.docs4.docDesc.htmlText = currentPageTag.perspectives.perspective2.docLink4;
				tab2Media.docs5.docDesc.htmlText = currentPageTag.perspectives.perspective2.docLink5;
				tab2Media.docs6.docDesc.htmlText = currentPageTag.perspectives.perspective2.docLink6;
				//Setting tab index
				projectorBack.linksArea.setChildIndex(tab2Media, 9);
				projectorBack.linksArea.setChildIndex(tab3Media, 0);
				projectorBack.linksArea.setChildIndex(tab4Media, 0);
				projectorBack.linksArea.setChildIndex(projectorBack.linksArea.allHypers, 0);
				//projectorBack.linksArea.setChildIndex(tab6Media, 0);
				
				//Functions for docs button
				function goToDoc1 (e:MouseEvent):void{
					var request:URLRequest = new URLRequest(docLink1Content);
					navigateToURL (request, "_blank");	
				}// end goToDoc1
				function goToDoc2 (e:MouseEvent):void{
					var request:URLRequest = new URLRequest(docLink2Content);
					navigateToURL (request, "_blank");	
				}// end goToDoc1
				function goToDoc3 (e:MouseEvent):void{
					var request:URLRequest = new URLRequest(docLink3Content);
					navigateToURL (request, "_blank");	
				}// end goToDoc1
				function goToDoc4 (e:MouseEvent):void{
					var request:URLRequest = new URLRequest(docLink4Content);
					navigateToURL (request, "_blank");	
				}// end goToDoc1
				function goToDoc5 (e:MouseEvent):void{
					var request:URLRequest = new URLRequest(docLink5Content);
					navigateToURL (request, "_blank");	
				}// end goToDoc1
				function goToDoc6 (e:MouseEvent):void{
					var request:URLRequest = new URLRequest(docLink6Content);
					navigateToURL (request, "_blank");	
				}// end goToDoc1
				
			} else if (e.currentTarget==projectorBack.linksArea.tab3){
				//Audio Scrubber
				tab3Media.media1.trackScrubber.visible = false;
				tab3Media.media1.trackBack.visible = false;
				tab3Media.media2.trackScrubber.visible = false;
				tab3Media.media2.trackBack.visible = false;
				tab3Media.media3.trackScrubber.visible = false;
				tab3Media.media3.trackBack.visible = false;
				tab3Media.media4.trackScrubber.visible = false;
				tab3Media.media4.trackBack.visible = false;
				tab3Media.media5.trackScrubber.visible = false;
				tab3Media.media5.trackBack.visible = false;
				tab3Media.media6.trackScrubber.visible = false;
				tab3Media.media6.trackBack.visible = false;
				//Add Close Event
				linksVideo.closeWinBTN.addEventListener(MouseEvent.MOUSE_DOWN, closeLinksMedia);
				//Add Close Event
				linksImage.closeWinBTN.addEventListener(MouseEvent.MOUSE_DOWN, closeImageMedia);
				//Add Close Event
				linksSWF.closeWinBTN.addEventListener(MouseEvent.MOUSE_DOWN, closeImageSWF);
				//tab2Media Setting Buttons to Mouse Enabled
				tab3Media.media1.invisiBTN.buttonMode = true;
				tab3Media.media2.invisiBTN.buttonMode = true;
				tab3Media.media3.invisiBTN.buttonMode = true;
				tab3Media.media4.invisiBTN.buttonMode = true;
				tab3Media.media5.invisiBTN.buttonMode = true;
				tab3Media.media6.invisiBTN.buttonMode = true;
				//Adding event listeners
				tab3Media.media1.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia1);
				tab3Media.media2.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia2);
				tab3Media.media3.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia3);
				tab3Media.media4.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia4);
				tab3Media.media5.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia5);
				tab3Media.media6.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia6);
				//hide up and down buttons
				projectorBack.linksArea.downHyper.visible = false;
				projectorBack.linksArea.upHyper.visible = false;
				//Set Links Tab Names
				projectorBack.linksArea.hyperTab.htmlText = "<b>" + currentPageTag.@hyperLinkTab + "</b>";
				tab2Media.docsTab.htmlText = "<b>" + currentPageTag.@docsLinkTab + "</b>";
				tab3Media.mediaTab.htmlText = "<b>" + currentPageTag.@meidaLinksTab + "</b>";
				//Settings for media titles
				pers1Media1Title = "<b>" + currentPageTag.perspectives.perspective1.mediaLink1.@mediaTitle + "</b>"
				pers1Media2Title = "<b>" + currentPageTag.perspectives.perspective1.mediaLink2.@mediaTitle + "</b>"
				pers1Media3Title = "<b>" + currentPageTag.perspectives.perspective1.mediaLink3.@mediaTitle + "</b>"
				pers1Media4Title = "<b>" + currentPageTag.perspectives.perspective1.mediaLink4.@mediaTitle + "</b>"
				pers1Media5Title = "<b>" + currentPageTag.perspectives.perspective1.mediaLink5.@mediaTitle + "</b>"
				pers1Media6Title = "<b>" + currentPageTag.perspectives.perspective1.mediaLink6.@mediaTitle + "</b>"
					
				pers2Media1Title = "<b>" + currentPageTag.perspectives.perspective2.mediaLink1.@mediaTitle + "</b>"
				pers2Media2Title = "<b>" + currentPageTag.perspectives.perspective2.mediaLink2.@mediaTitle + "</b>"
				pers2Media3Title = "<b>" + currentPageTag.perspectives.perspective2.mediaLink3.@mediaTitle + "</b>"
				pers2Media4Title = "<b>" + currentPageTag.perspectives.perspective2.mediaLink4.@mediaTitle + "</b>"
				pers2Media5Title = "<b>" + currentPageTag.perspectives.perspective2.mediaLink5.@mediaTitle + "</b>"
				pers2Media6Title = "<b>" + currentPageTag.perspectives.perspective2.mediaLink6.@mediaTitle + "</b>"
					
				pers3Media1Title = "<b>" + currentPageTag.perspectives.perspective3.mediaLink1.@mediaTitle + "</b>"
				pers3Media2Title = "<b>" + currentPageTag.perspectives.perspective3.mediaLink2.@mediaTitle + "</b>"
				pers3Media3Title = "<b>" + currentPageTag.perspectives.perspective3.mediaLink3.@mediaTitle + "</b>"
				pers3Media4Title = "<b>" + currentPageTag.perspectives.perspective3.mediaLink4.@mediaTitle + "</b>"
				pers3Media5Title = "<b>" + currentPageTag.perspectives.perspective3.mediaLink5.@mediaTitle + "</b>"
				pers3Media6Title = "<b>" + currentPageTag.perspectives.perspective3.mediaLink6.@mediaTitle + "</b>"
					
				pers4Media1Title = "<b>" + currentPageTag.perspectives.perspective4.mediaLink1.@mediaTitle + "</b>"
				pers4Media2Title = "<b>" + currentPageTag.perspectives.perspective4.mediaLink2.@mediaTitle + "</b>"
				pers4Media3Title = "<b>" + currentPageTag.perspectives.perspective4.mediaLink3.@mediaTitle + "</b>"
				pers4Media4Title = "<b>" + currentPageTag.perspectives.perspective4.mediaLink4.@mediaTitle + "</b>"
				pers4Media5Title = "<b>" + currentPageTag.perspectives.perspective4.mediaLink5.@mediaTitle + "</b>"
				pers4Media6Title = "<b>" + currentPageTag.perspectives.perspective4.mediaLink6.@mediaTitle + "</b>"
					
				pers5Media1Title = "<b>" + currentPageTag.perspectives.perspective5.mediaLink1.@mediaTitle + "</b>"
				pers5Media2Title = "<b>" + currentPageTag.perspectives.perspective5.mediaLink2.@mediaTitle + "</b>"
				pers5Media3Title = "<b>" + currentPageTag.perspectives.perspective5.mediaLink3.@mediaTitle + "</b>"
				pers5Media4Title = "<b>" + currentPageTag.perspectives.perspective5.mediaLink4.@mediaTitle + "</b>"
				pers5Media5Title = "<b>" + currentPageTag.perspectives.perspective5.mediaLink5.@mediaTitle + "</b>"
				pers5Media6Title = "<b>" + currentPageTag.perspectives.perspective5.mediaLink6.@mediaTitle + "</b>"
					
				pers6Media1Title = "<b>" + currentPageTag.perspectives.perspective6.mediaLink1.@mediaTitle + "</b>"
				pers6Media2Title = "<b>" + currentPageTag.perspectives.perspective6.mediaLink2.@mediaTitle + "</b>"
				pers6Media3Title = "<b>" + currentPageTag.perspectives.perspective6.mediaLink3.@mediaTitle + "</b>"
				pers6Media4Title = "<b>" + currentPageTag.perspectives.perspective6.mediaLink4.@mediaTitle + "</b>"
				pers6Media5Title = "<b>" + currentPageTag.perspectives.perspective6.mediaLink5.@mediaTitle + "</b>"
				pers6Media6Title = "<b>" + currentPageTag.perspectives.perspective6.mediaLink6.@mediaTitle + "</b>"
				//Setting titles for media area
				if (pers == "perspective1"){
					tab3Media.media1.mediaTitle.htmlText = pers1Media1Title;
					tab3Media.media2.mediaTitle.htmlText = pers1Media2Title;
					tab3Media.media3.mediaTitle.htmlText = pers1Media3Title;
					tab3Media.media4.mediaTitle.htmlText = pers1Media4Title;
					tab3Media.media5.mediaTitle.htmlText = pers1Media5Title;
					tab3Media.media6.mediaTitle.htmlText = pers1Media6Title;
					//Make button not visible if no title
					tab3Media.media1.visible  = (pers1Media1Title != "<b></b>" && pers1Media1Title != null);
					tab3Media.media2.visible  = (pers1Media2Title != "<b></b>" && pers1Media2Title != null);
					tab3Media.media3.visible  = (pers1Media3Title != "<b></b>" && pers1Media3Title != null);
					tab3Media.media4.visible  = (pers1Media4Title != "<b></b>" && pers1Media4Title != null);
					tab3Media.media5.visible  = (pers1Media5Title != "<b></b>" && pers1Media5Title != null);
					tab3Media.media6.visible  = (pers1Media6Title != "<b></b>" && pers1Media6Title != null);
				} else if (pers == "perspective2"){
					tab3Media.media1.mediaTitle.htmlText = pers2Media1Title;
					tab3Media.media2.mediaTitle.htmlText = pers2Media2Title;
					tab3Media.media3.mediaTitle.htmlText = pers2Media3Title;
					tab3Media.media4.mediaTitle.htmlText = pers2Media4Title;
					tab3Media.media5.mediaTitle.htmlText = pers2Media5Title;
					tab3Media.media6.mediaTitle.htmlText = pers2Media6Title;
					//Make button not visible if no title
					tab3Media.media1.visible  = (pers2Media1Title != "<b></b>" && pers2Media1Title != null);
					tab3Media.media2.visible  = (pers2Media2Title != "<b></b>" && pers2Media2Title != null);
					tab3Media.media3.visible  = (pers2Media3Title != "<b></b>" && pers2Media3Title != null);
					tab3Media.media4.visible  = (pers2Media4Title != "<b></b>" && pers2Media4Title != null);
					tab3Media.media5.visible  = (pers2Media5Title != "<b></b>" && pers2Media5Title != null);
					tab3Media.media6.visible  = (pers2Media6Title != "<b></b>" && pers2Media6Title != null);
				} else if (pers == "perspective3"){
					tab3Media.media1.mediaTitle.htmlText = pers3Media1Title;
					tab3Media.media2.mediaTitle.htmlText = pers3Media2Title;
					tab3Media.media3.mediaTitle.htmlText = pers3Media3Title;
					tab3Media.media4.mediaTitle.htmlText = pers3Media4Title;
					tab3Media.media5.mediaTitle.htmlText = pers3Media5Title;
					tab3Media.media6.mediaTitle.htmlText = pers3Media6Title;
					//Make button not visible if no title
					tab3Media.media1.visible  = (pers3Media1Title != "<b></b>" && pers3Media1Title != null);
					tab3Media.media2.visible  = (pers3Media2Title != "<b></b>" && pers3Media2Title != null);
					tab3Media.media3.visible  = (pers3Media3Title != "<b></b>" && pers3Media3Title != null);
					tab3Media.media4.visible  = (pers3Media4Title != "<b></b>" && pers3Media4Title != null);
					tab3Media.media5.visible  = (pers3Media5Title != "<b></b>" && pers3Media5Title != null);
					tab3Media.media6.visible  = (pers3Media6Title != "<b></b>" && pers3Media6Title != null);
				} else if (pers == "perspective4"){
					tab3Media.media1.mediaTitle.htmlText = pers4Media1Title;
					tab3Media.media2.mediaTitle.htmlText = pers4Media2Title;
					tab3Media.media3.mediaTitle.htmlText = pers4Media3Title;
					tab3Media.media4.mediaTitle.htmlText = pers4Media4Title;
					tab3Media.media5.mediaTitle.htmlText = pers4Media5Title;
					tab3Media.media6.mediaTitle.htmlText = pers4Media6Title;
					//Make button not visible if no title
					tab3Media.media1.visible  = (pers4Media1Title != "<b></b>" && pers4Media1Title != null);
					tab3Media.media2.visible  = (pers4Media2Title != "<b></b>" && pers4Media2Title != null);
					tab3Media.media3.visible  = (pers4Media3Title != "<b></b>" && pers4Media3Title != null);
					tab3Media.media4.visible  = (pers4Media4Title != "<b></b>" && pers4Media4Title != null);
					tab3Media.media5.visible  = (pers4Media5Title != "<b></b>" && pers4Media5Title != null);
					tab3Media.media6.visible  = (pers4Media6Title != "<b></b>" && pers4Media6Title != null);
				} else if (pers == "perspective5"){
					tab3Media.media1.mediaTitle.htmlText = pers5Media1Title;
					tab3Media.media2.mediaTitle.htmlText = pers5Media2Title;
					tab3Media.media3.mediaTitle.htmlText = pers5Media3Title;
					tab3Media.media4.mediaTitle.htmlText = pers5Media4Title;
					tab3Media.media5.mediaTitle.htmlText = pers5Media5Title;
					tab3Media.media6.mediaTitle.htmlText = pers5Media6Title;
					//Make button not visible if no title
					tab3Media.media1.visible  = (pers5Media1Title != "<b></b>" && pers5Media1Title != null);
					tab3Media.media2.visible  = (pers5Media2Title != "<b></b>" && pers5Media2Title != null);
					tab3Media.media3.visible  = (pers5Media3Title != "<b></b>" && pers5Media3Title != null);
					tab3Media.media4.visible  = (pers5Media4Title != "<b></b>" && pers5Media4Title != null);
					tab3Media.media5.visible  = (pers5Media5Title != "<b></b>" && pers5Media5Title != null);
					tab3Media.media6.visible  = (pers5Media6Title != "<b></b>" && pers5Media6Title != null);
				} else if (pers == "perspective6"){
					tab3Media.media1.mediaTitle.htmlText = pers6Media1Title;
					tab3Media.media2.mediaTitle.htmlText = pers6Media2Title;
					tab3Media.media3.mediaTitle.htmlText = pers6Media3Title;
					tab3Media.media4.mediaTitle.htmlText = pers6Media4Title;
					tab3Media.media5.mediaTitle.htmlText = pers6Media5Title;
					tab3Media.media6.mediaTitle.htmlText = pers6Media6Title;
					//Make button not visible if no title
					tab3Media.media1.visible  = (pers6Media1Title != "<b></b>" && pers6Media1Title != null);
					tab3Media.media2.visible  = (pers6Media2Title != "<b></b>" && pers6Media2Title != null);
					tab3Media.media3.visible  = (pers6Media3Title != "<b></b>" && pers6Media3Title != null);
					tab3Media.media4.visible  = (pers6Media4Title != "<b></b>" && pers6Media4Title != null);
					tab3Media.media5.visible  = (pers6Media5Title != "<b></b>" && pers6Media5Title != null);
					tab3Media.media6.visible  = (pers6Media6Title != "<b></b>" && pers6Media6Title != null);
				}
				
				//Content for Media Description
				pers1Media1Desc = currentPageTag.perspectives.perspective1.mediaLink1;
				pers1Media2Desc = currentPageTag.perspectives.perspective1.mediaLink2;
				pers1Media3Desc = currentPageTag.perspectives.perspective1.mediaLink3;
				pers1Media4Desc = currentPageTag.perspectives.perspective1.mediaLink4;
				pers1Media5Desc = currentPageTag.perspectives.perspective1.mediaLink5;
				pers1Media6Desc = currentPageTag.perspectives.perspective1.mediaLink6;
				
				pers2Media1Desc = currentPageTag.perspectives.perspective2.mediaLink1;
				pers2Media2Desc = currentPageTag.perspectives.perspective2.mediaLink2;
				pers2Media3Desc = currentPageTag.perspectives.perspective2.mediaLink3;
				pers2Media4Desc = currentPageTag.perspectives.perspective2.mediaLink4;
				pers2Media5Desc = currentPageTag.perspectives.perspective2.mediaLink5;
				pers2Media6Desc = currentPageTag.perspectives.perspective2.mediaLink6;
				
				pers3Media1Desc = currentPageTag.perspectives.perspective3.mediaLink1;
				pers3Media2Desc = currentPageTag.perspectives.perspective3.mediaLink2;
				pers3Media3Desc = currentPageTag.perspectives.perspective3.mediaLink3;
				pers3Media4Desc = currentPageTag.perspectives.perspective3.mediaLink4;
				pers3Media5Desc = currentPageTag.perspectives.perspective3.mediaLink5;
				pers3Media6Desc = currentPageTag.perspectives.perspective3.mediaLink6;
				
				pers4Media1Desc = currentPageTag.perspectives.perspective4.mediaLink1;
				pers4Media2Desc = currentPageTag.perspectives.perspective4.mediaLink2;
				pers4Media3Desc = currentPageTag.perspectives.perspective4.mediaLink3;
				pers4Media4Desc = currentPageTag.perspectives.perspective4.mediaLink4;
				pers4Media5Desc = currentPageTag.perspectives.perspective4.mediaLink5;
				pers4Media6Desc = currentPageTag.perspectives.perspective4.mediaLink6;
				
				pers5Media1Desc = currentPageTag.perspectives.perspective5.mediaLink1;
				pers5Media2Desc = currentPageTag.perspectives.perspective5.mediaLink2;
				pers5Media3Desc = currentPageTag.perspectives.perspective5.mediaLink3;
				pers5Media4Desc = currentPageTag.perspectives.perspective5.mediaLink4;
				pers5Media5Desc = currentPageTag.perspectives.perspective5.mediaLink5;
				pers5Media6Desc = currentPageTag.perspectives.perspective5.mediaLink6;
				
				pers6Media1Desc = currentPageTag.perspectives.perspective6.mediaLink1;
				pers6Media2Desc = currentPageTag.perspectives.perspective6.mediaLink2;
				pers6Media3Desc = currentPageTag.perspectives.perspective6.mediaLink3;
				pers6Media4Desc = currentPageTag.perspectives.perspective6.mediaLink4;
				pers6Media5Desc = currentPageTag.perspectives.perspective6.mediaLink5;
				pers6Media6Desc = currentPageTag.perspectives.perspective6.mediaLink6;
				
				//Seeting the description of media area
				if (pers == "perspective1"){
					tab3Media.media1.mediaDesc.htmlText = pers1Media1Desc;
					tab3Media.media2.mediaDesc.htmlText = pers1Media2Desc;
					tab3Media.media3.mediaDesc.htmlText = pers1Media3Desc;
					tab3Media.media4.mediaDesc.htmlText = pers1Media4Desc;
					tab3Media.media5.mediaDesc.htmlText = pers1Media5Desc;
					tab3Media.media6.mediaDesc.htmlText = pers1Media6Desc;
				} else if (pers == "perspective2"){
					tab3Media.media1.mediaDesc.htmlText = pers2Media1Desc;
					tab3Media.media2.mediaDesc.htmlText = pers2Media2Desc;
					tab3Media.media3.mediaDesc.htmlText = pers2Media3Desc;
					tab3Media.media4.mediaDesc.htmlText = pers2Media4Desc;
					tab3Media.media5.mediaDesc.htmlText = pers2Media5Desc;
					tab3Media.media6.mediaDesc.htmlText = pers2Media6Desc;
				} else if (pers == "perspective3"){
					tab3Media.media1.mediaDesc.htmlText = pers3Media1Desc;
					tab3Media.media2.mediaDesc.htmlText = pers3Media2Desc;
					tab3Media.media3.mediaDesc.htmlText = pers3Media3Desc;
					tab3Media.media4.mediaDesc.htmlText = pers3Media4Desc;
					tab3Media.media5.mediaDesc.htmlText = pers3Media5Desc;
					tab3Media.media6.mediaDesc.htmlText = pers3Media6Desc;
				} else if (pers == "perspective4"){
					tab3Media.media1.mediaDesc.htmlText = pers4Media1Desc;
					tab3Media.media2.mediaDesc.htmlText = pers4Media2Desc;
					tab3Media.media3.mediaDesc.htmlText = pers4Media3Desc;
					tab3Media.media4.mediaDesc.htmlText = pers4Media4Desc;
					tab3Media.media5.mediaDesc.htmlText = pers4Media5Desc;
					tab3Media.media6.mediaDesc.htmlText = pers4Media6Desc;
				} else if (pers == "perspective5"){
					tab3Media.media1.mediaDesc.htmlText = pers5Media1Desc;
					tab3Media.media2.mediaDesc.htmlText = pers5Media2Desc;
					tab3Media.media3.mediaDesc.htmlText = pers5Media3Desc;
					tab3Media.media4.mediaDesc.htmlText = pers5Media4Desc;
					tab3Media.media5.mediaDesc.htmlText = pers5Media5Desc;
					tab3Media.media6.mediaDesc.htmlText = pers5Media6Desc;
				} else if (pers == "perspective6"){
					tab3Media.media1.mediaDesc.htmlText = pers6Media1Desc;
					tab3Media.media2.mediaDesc.htmlText = pers6Media2Desc;
					tab3Media.media3.mediaDesc.htmlText = pers6Media3Desc;
					tab3Media.media4.mediaDesc.htmlText = pers6Media4Desc;
					tab3Media.media5.mediaDesc.htmlText = pers6Media5Desc;
					tab3Media.media6.mediaDesc.htmlText = pers6Media6Desc;
				}
				
				//Setting the tab index
				projectorBack.linksArea.setChildIndex(tab2Media, 0);
				projectorBack.linksArea.setChildIndex(tab3Media, 9);
				projectorBack.linksArea.setChildIndex(tab4Media, 0);
				projectorBack.linksArea.setChildIndex(projectorBack.linksArea.allHypers, 0);
				//projectorBack.linksArea.setChildIndex(tab6Media, 0);
				//Functions for playing media
				function playMedia1 (e:MouseEvent):void{
					//Stop all Audio
					SoundMixer.stopAll();
					//See if Audio or video
					if (mediaLink1Content.indexOf(".flv") > -1){
						
						//See if Audio is playing and stop it
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//linksVideo.addChild(videoLinksVid);
						projectorBack.persVid.stop();
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
					
						//Bring in Video
						linksVideo.videoLinksVid.visible = true;
						linksVideo.visible = true;
						TweenLite.to(linksVideo, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
						linksVideo.videoLinksVid.source = mediaLink1Content;
						linksVideo.videoLinksVid.play();
					} else if (mediaLink1Content.indexOf(".mp3") > -1){
						
						//isAudioPlaying
						isAudioPlaying1 = true;
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
							
						tab3Media.media1.mediaPlay.gotoAndStop("pause");
						tab3Media.media1.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, playMedia1);
						tab3Media.media1.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, stopAudio1);
							
						soundFile1 = new Sound();
						soundFile1.load(new URLRequest(mediaLink1Content));
						sndChannel1 = soundFile1.play();
							
						tab3Media.media1.playingAudio.visible = true;
						tab3Media.media1.mediaTitle.visible = false;
						tab3Media.media1.mediaDesc.visible = false;
							
						//Audio Scrubber
						tab3Media.media1.trackScrubber.visible = true;
						tab3Media.media1.trackBack.visible = true;
							
						soundFile1.addEventListener(Event.COMPLETE, soundLoadedDone1);
						tab3Media.media1.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							
						function soundLoadedDone1(e:Event):void{
							timerCount = new Timer(100);
							timerCount.start();
							timerCount.addEventListener(TimerEvent.TIMER, updateScrub);
						}
							function updateScrub(e:TimerEvent):void{
								tallytime = (soundFile1.length/1000);
								tallyCurrentTime = ((sndChannel1.position/1000)/tallytime);
								//trace(tallyCurrentTime);
								updatedTime = tallyCurrentTime * tab3Media.media1.trackBack.width - 2 ;
								//Was up  right after the width. Putting it here incase I need it again "+ tab3Media.media1.trackBack.x"
								//trace(updatedTime);
								tab3Media.media1.trackScrubber.follower.x = updatedTime;
								if(sndChannel1.position >= soundFile1.length - 500){
									timerCount.stop();
								}
							}
							
							function startScrub(e:MouseEvent):void{
								tab3Media.media1.trackScrubber.follower.startDrag(false, new Rectangle(0,0,tab3Media.media1.trackBack.width,0));
								tab3Media.media1.trackScrubber.removeEventListener(MouseEvent.MOUSE_DOWN, startScrub);
								stage.addEventListener(MouseEvent.MOUSE_UP, stopScrub);
								sndChannel1.stop();
								timerCount.stop();
							}
							 function stopScrub(e:MouseEvent):void{
								 tab3Media.media1.trackScrubber.follower.stopDrag();
								 tab3Media.media1.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
								 stage.removeEventListener(MouseEvent.MOUSE_UP, stopScrub);	
								 percNeeded = tab3Media.media1.trackScrubber.follower.x / (tab3Media.media1.trackBack.width + tab3Media.media1.trackBack.x);
								 perToGoTo = Math.floor((percNeeded * tallytime) * 1000);
								 //tab3Media.media1.trackScrubber.follower.x = updatedTime;
								 sndChannel1 = soundFile1.play(perToGoTo);
								 
								 timerAgainCount = new Timer(100);
								 timerAgainCount.start();
								 timerAgainCount.addEventListener(TimerEvent.TIMER, startAgain);
							 }
							 
							 function startAgain(e:TimerEvent):void{
								 timerCount.start();
								 timerAgainCount.stop();
							 }
							
						function stopAudio1(e:MouseEvent):void{
							if (sndChannel1) {
								sndChannel1.stop();
								projectorBack.persVid.play();
							}
							//sndChannel.stop();
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							tab3Media.media1.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, stopAudio1);
							tab3Media.media1.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia1)
								
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
						}
					} else if (mediaLink1Content.indexOf(".jpg") > -1 || mediaLink1Content.indexOf(".png") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader1.load(imageRequest1);
						linksImage.linksImage.addChild(imageLoader1);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksImage, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					} else if (mediaLink1Content.indexOf(".swf") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader1.load(imageRequest1);
						linksSWF.linksImage.addChild(imageLoader1);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksSWF, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					}// End if statement
				}
				function playMedia2 (e:MouseEvent):void{
					//Stop All Audio
					SoundMixer.stopAll();
					//See if Audio or Video
					if (mediaLink2Content.indexOf(".flv") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						//Stop Pers Vid
						projectorBack.persVid.stop();
						//linksVideo.addChild(videoLinksVid);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
					
						//Bring in Video
						linksVideo.videoLinksVid.visible = true;
						linksVideo.visible = true;
						TweenLite.to(linksVideo, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
						linksVideo.videoLinksVid.source = mediaLink2Content;
						linksVideo.videoLinksVid.play();
					} else if (mediaLink2Content.indexOf(".mp3") > -1){
						
						//isAudioPlaying
						isAudioPlaying2 = true;
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						tab3Media.media2.mediaPlay.gotoAndStop("pause");
						tab3Media.media2.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, playMedia2);
						tab3Media.media2.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, stopAudio2);
						
						soundFile2 = new Sound();
						soundFile2.load(new URLRequest(mediaLink2Content));
						sndChannel2 = soundFile2.play();
						
						tab3Media.media2.playingAudio.visible = true;
						tab3Media.media2.mediaTitle.visible = false;
						tab3Media.media2.mediaDesc.visible = false;
						
						//Audio Scrubber
						tab3Media.media2.trackScrubber.visible = true;
						tab3Media.media2.trackBack.visible = true;
						
						soundFile2.addEventListener(Event.COMPLETE, soundLoadedDone2);
						tab3Media.media2.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
						
						function soundLoadedDone2(e:Event):void{
							timerCount = new Timer(100);
							timerCount.start();
							timerCount.addEventListener(TimerEvent.TIMER, updateScrub);
						}
						function updateScrub(e:TimerEvent):void{
							tallytime = (soundFile2.length/1000);
							tallyCurrentTime = ((sndChannel2.position/1000)/tallytime);
							//trace(tallyCurrentTime);
							updatedTime = tallyCurrentTime * tab3Media.media2.trackBack.width - 2 ;
							//Was up  right after the width. Putting it here incase I need it again "+ tab3Media.media1.trackBack.x"
							//trace(updatedTime);
							tab3Media.media2.trackScrubber.follower.x = updatedTime;
							if(sndChannel2.position >= soundFile2.length - 500){
								timerCount.stop();
							}
						}
						
						function startScrub(e:MouseEvent):void{
							tab3Media.media2.trackScrubber.follower.startDrag(false, new Rectangle(0,0,tab3Media.media2.trackBack.width,0));
							tab3Media.media2.trackScrubber.removeEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.addEventListener(MouseEvent.MOUSE_UP, stopScrub);
							sndChannel2.stop();
							timerCount.stop();
						}
						function stopScrub(e:MouseEvent):void{
							tab3Media.media2.trackScrubber.follower.stopDrag();
							tab3Media.media2.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.removeEventListener(MouseEvent.MOUSE_UP, stopScrub);	
							percNeeded = tab3Media.media2.trackScrubber.follower.x / (tab3Media.media1.trackBack.width + tab3Media.media2.trackBack.x);
							perToGoTo = Math.floor((percNeeded * tallytime) * 1000);
							//tab3Media.media1.trackScrubber.follower.x = updatedTime;
							sndChannel1 = soundFile1.play(perToGoTo);
							
							timerAgainCount = new Timer(100);
							timerAgainCount.start();
							timerAgainCount.addEventListener(TimerEvent.TIMER, startAgain);
						}
						
						function startAgain(e:TimerEvent):void{
							timerCount.start();
							timerAgainCount.stop();
						}
						
						function stopAudio2(e:MouseEvent):void{
							if (sndChannel2) {
								sndChannel2.stop();
								projectorBack.persVid.play();
							}
							//sndChannel.stop();
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							tab3Media.media2.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, stopAudio2);
							tab3Media.media2.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia2);
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
						}
					} else if (mediaLink2Content.indexOf(".jpg") > -1 || mediaLink2Content.indexOf(".png") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader2.load(imageRequest2);
						linksImage.linksImage.addChild(imageLoader2);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksImage, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					} else if (mediaLink2Content.indexOf(".swf") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader2.load(imageRequest2);
						linksSWF.linksImage.addChild(imageLoader2);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksSWF, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					}// End if statment
				}
				function playMedia3 (e:MouseEvent):void{
					//Stop All Audio
					SoundMixer.stopAll();
					// See if audio or video
					if (mediaLink3Content.indexOf(".flv") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						//linksVideo.addChild(videoLinksVid);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
					
						//Bring in Video
						linksVideo.videoLinksVid.visible = true;
						linksVideo.visible = true;
						TweenLite.to(linksVideo, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
						linksVideo.videoLinksVid.source = mediaLink3Content;
						linksVideo.videoLinksVid.play();
					} else if (mediaLink3Content.indexOf(".mp3") > -1){
						
						//isAudioPlaying
						isAudioPlaying3 = true;
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						tab3Media.media3.mediaPlay.gotoAndStop("pause");
						tab3Media.media3.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, playMedia3);
						tab3Media.media3.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, stopAudio3);
						
						soundFile3 = new Sound();
						soundFile3.load(new URLRequest(mediaLink3Content));
						sndChannel3 = soundFile3.play();
						
						tab3Media.media3.playingAudio.visible = true;
						tab3Media.media3.mediaTitle.visible = false;
						tab3Media.media3.mediaDesc.visible = false;
						
						//Audio Scrubber
						tab3Media.media3.trackScrubber.visible = true;
						tab3Media.media3.trackBack.visible = true;
						
						soundFile3.addEventListener(Event.COMPLETE, soundLoadedDone3);
						tab3Media.media3.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
						
						function soundLoadedDone3(e:Event):void{
							timerCount = new Timer(100);
							timerCount.start();
							timerCount.addEventListener(TimerEvent.TIMER, updateScrub);
						}
						function updateScrub(e:TimerEvent):void{
							tallytime = (soundFile3.length/1000);
							tallyCurrentTime = ((sndChannel1.position/1000)/tallytime);
							//trace(tallyCurrentTime);
							updatedTime = tallyCurrentTime * tab3Media.media3.trackBack.width - 2 ;
							//Was up  right after the width. Putting it here incase I need it again "+ tab3Media.media1.trackBack.x"
							//trace(updatedTime);
							tab3Media.media3.trackScrubber.follower.x = updatedTime;
							if(sndChannel3.position >= soundFile1.length - 500){
								timerCount.stop();
							}
						}
						
						function startScrub(e:MouseEvent):void{
							tab3Media.media3.trackScrubber.follower.startDrag(false, new Rectangle(0,0,tab3Media.media3.trackBack.width,0));
							tab3Media.media3.trackScrubber.removeEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.addEventListener(MouseEvent.MOUSE_UP, stopScrub);
							sndChannel3.stop();
							timerCount.stop();
						}
						function stopScrub(e:MouseEvent):void{
							tab3Media.media3.trackScrubber.follower.stopDrag();
							tab3Media.media3.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.removeEventListener(MouseEvent.MOUSE_UP, stopScrub);	
							percNeeded = tab3Media.media3.trackScrubber.follower.x / (tab3Media.media3.trackBack.width + tab3Media.media3.trackBack.x);
							perToGoTo = Math.floor((percNeeded * tallytime) * 1000);
							//tab3Media.media1.trackScrubber.follower.x = updatedTime;
							sndChannel3 = soundFile3.play(perToGoTo);
							
							timerAgainCount = new Timer(100);
							timerAgainCount.start();
							timerAgainCount.addEventListener(TimerEvent.TIMER, startAgain);
						}
						
						function startAgain(e:TimerEvent):void{
							timerCount.start();
							timerAgainCount.stop();
						}
						
						function stopAudio3(e:MouseEvent):void{
							if (sndChannel3) {
								sndChannel3.stop();
								projectorBack.persVid.play();
							}
							//sndChannel.stop();
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							tab3Media.media3.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, stopAudio3);
							tab3Media.media3.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia3)
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
						}
					} else if (mediaLink3Content.indexOf(".jpg") > -1 || mediaLink3Content.indexOf(".png") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader3.load(imageRequest3);
						linksImage.linksImage.addChild(imageLoader3);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksImage, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					} else if (mediaLink3Content.indexOf(".swf") > -1){
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader3.load(imageRequest3);
						linksSWF.linksImage.addChild(imageLoader3);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksSWF, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					}// End if statement
				}
				function playMedia4 (e:MouseEvent):void{
					//Stop All Audio
					SoundMixer.stopAll();
					// See if audio or video
					if (mediaLink4Content.indexOf(".flv") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						//linksVideo.addChild(videoLinksVid);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
					
						//Bring in Video
						linksVideo.videoLinksVid.visible = true;
						linksVideo.visible = true;
						TweenLite.to(linksVideo, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
						linksVideo.videoLinksVid.source = mediaLink4Content;
						linksVideo.videoLinksVid.play();
					} else if (mediaLink4Content.indexOf(".mp3") > -1){
						
						//isAudioPlaying
						isAudioPlaying4 = true;
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						tab3Media.media4.mediaPlay.gotoAndStop("pause");
						tab3Media.media4.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, playMedia4);
						tab3Media.media4.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, stopAudio4);
						
						soundFile4 = new Sound();
						soundFile4.load(new URLRequest(mediaLink4Content));
						sndChannel4 = soundFile4.play();
						
						tab3Media.media4.playingAudio.visible = true;
						tab3Media.media4.mediaTitle.visible = false;
						tab3Media.media4.mediaDesc.visible = false;
						
						//Audio Scrubber
						tab3Media.media4.trackScrubber.visible = true;
						tab3Media.media4.trackBack.visible = true;
						
						soundFile4.addEventListener(Event.COMPLETE, soundLoadedDone4);
						tab3Media.media4.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
						
						function soundLoadedDone4(e:Event):void{
							timerCount = new Timer(100);
							timerCount.start();
							timerCount.addEventListener(TimerEvent.TIMER, updateScrub);
						}
						function updateScrub(e:TimerEvent):void{
							tallytime = (soundFile4.length/1000);
							tallyCurrentTime = ((sndChannel4.position/1000)/tallytime);
							//trace(tallyCurrentTime);
							updatedTime = tallyCurrentTime * tab3Media.media4.trackBack.width - 2 ;
							//Was up  right after the width. Putting it here incase I need it again "+ tab3Media.media1.trackBack.x"
							//trace(updatedTime);
							tab3Media.media4.trackScrubber.follower.x = updatedTime;
							if(sndChannel4.position >= soundFile4.length - 500){
								timerCount.stop();
							}
						}
						
						function startScrub(e:MouseEvent):void{
							tab3Media.media4.trackScrubber.follower.startDrag(false, new Rectangle(0,0,tab3Media.media4.trackBack.width,0));
							tab3Media.media4.trackScrubber.removeEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.addEventListener(MouseEvent.MOUSE_UP, stopScrub);
							sndChannel4.stop();
							timerCount.stop();
						}
						function stopScrub(e:MouseEvent):void{
							tab3Media.media4.trackScrubber.follower.stopDrag();
							tab3Media.media4.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.removeEventListener(MouseEvent.MOUSE_UP, stopScrub);	
							percNeeded = tab3Media.media4.trackScrubber.follower.x / (tab3Media.media4.trackBack.width + tab3Media.media4.trackBack.x);
							perToGoTo = Math.floor((percNeeded * tallytime) * 1000);
							//tab3Media.media1.trackScrubber.follower.x = updatedTime;
							sndChannel4 = soundFile4.play(perToGoTo);
							
							timerAgainCount = new Timer(100);
							timerAgainCount.start();
							timerAgainCount.addEventListener(TimerEvent.TIMER, startAgain);
						}
						
						function startAgain(e:TimerEvent):void{
							timerCount.start();
							timerAgainCount.stop();
						}
						
						function stopAudio4(e:MouseEvent):void{
							if (sndChannel4) {
								sndChannel4.stop();
								projectorBack.persVid.play();
							}
							//sndChannel.stop();
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							tab3Media.media4.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, stopAudio4);
							tab3Media.media4.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia4);
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
						}
					} else if (mediaLink4Content.indexOf(".jpg") > -1 || mediaLink4Content.indexOf(".png") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader4.load(imageRequest4);
						linksImage.linksImage.addChild(imageLoader4);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksImage, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					} else if (mediaLink4Content.indexOf(".swf") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader4.load(imageRequest4);
						linksSWF.linksImage.addChild(imageLoader4);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksSWF, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					}// end if statement
				}
				function playMedia5 (e:MouseEvent):void{
					//Stop All Audio
					SoundMixer.stopAll();
					// See if audio or video
					if (mediaLink5Content.indexOf(".flv") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						//linksVideo.addChildAt(videoLinksVid, 0);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
					
						//Bring in Video
						linksVideo.videoLinksVid.visible = true;
						linksVideo.visible = true;
						TweenLite.to(linksVideo, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
						linksVideo.videoLinksVid.source = mediaLink5Content;
						linksVideo.videoLinksVid.play();
					} else if (mediaLink5Content.indexOf(".mp3") > -1){
						
						//isAudioPlaying
						isAudioPlaying5 = true;
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						tab3Media.media5.mediaPlay.gotoAndStop("pause");
						tab3Media.media5.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, playMedia5);
						tab3Media.media5.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, stopAudio5);
						
						soundFile5 = new Sound();
						soundFile5.load(new URLRequest(mediaLink1Content));
						sndChannel5 = soundFile5.play();
						
						tab3Media.media5.playingAudio.visible = true;
						tab3Media.media5.mediaTitle.visible = false;
						tab3Media.media5.mediaDesc.visible = false;
						
						//Audio Scrubber
						tab3Media.media5.trackScrubber.visible = true;
						tab3Media.media5.trackBack.visible = true;
						
						soundFile5.addEventListener(Event.COMPLETE, soundLoadedDone5);
						tab3Media.media5.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
						
						function soundLoadedDone5(e:Event):void{
							timerCount = new Timer(100);
							timerCount.start();
							timerCount.addEventListener(TimerEvent.TIMER, updateScrub);
						}
						function updateScrub(e:TimerEvent):void{
							tallytime = (soundFile5.length/1000);
							tallyCurrentTime = ((sndChannel5.position/1000)/tallytime);
							//trace(tallyCurrentTime);
							updatedTime = tallyCurrentTime * tab3Media.media5.trackBack.width - 2 ;
							//Was up  right after the width. Putting it here incase I need it again "+ tab3Media.media1.trackBack.x"
							//trace(updatedTime);
							tab3Media.media5.trackScrubber.follower.x = updatedTime;
							if(sndChannel5.position >= soundFile5.length - 500){
								timerCount.stop();
								projectorBack.persVid.play();
							}
						}
						
						function startScrub(e:MouseEvent):void{
							tab3Media.media5.trackScrubber.follower.startDrag(false, new Rectangle(0,0,tab3Media.media5.trackBack.width,0));
							tab3Media.media5.trackScrubber.removeEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.addEventListener(MouseEvent.MOUSE_UP, stopScrub);
							sndChannel5.stop();
							timerCount.stop();
						}
						function stopScrub(e:MouseEvent):void{
							tab3Media.media5.trackScrubber.follower.stopDrag();
							tab3Media.media5.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.removeEventListener(MouseEvent.MOUSE_UP, stopScrub);	
							percNeeded = tab3Media.media5.trackScrubber.follower.x / (tab3Media.media5.trackBack.width + tab3Media.media5.trackBack.x);
							perToGoTo = Math.floor((percNeeded * tallytime) * 1000);
							//tab3Media.media1.trackScrubber.follower.x = updatedTime;
							sndChannel5 = soundFile5.play(perToGoTo);
							
							timerAgainCount = new Timer(100);
							timerAgainCount.start();
							timerAgainCount.addEventListener(TimerEvent.TIMER, startAgain);
						}
						
						function startAgain(e:TimerEvent):void{
							timerCount.start();
							timerAgainCount.stop();
						}
						
						function stopAudio5(e:MouseEvent):void{
							if (sndChannel5) {
								sndChannel5.stop();
							}
							//sndChannel.stop();
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							tab3Media.media5.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, stopAudio5);
							tab3Media.media5.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia5);
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
						}
					} else if (mediaLink5Content.indexOf(".jpg") > -1 || mediaLink5Content.indexOf(".png") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader5.load(imageRequest5);
						linksImage.linksImage.addChild(imageLoader5);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksImage, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					} else if (mediaLink5Content.indexOf(".swf") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader5.load(imageRequest5);
						linksSWF.linksImage.addChild(imageLoader5);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksSWF, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					} // End if statement
				}
				function playMedia6 (e:MouseEvent):void{
					//Stop All Audio
					SoundMixer.stopAll();
					// See if Audio or Video
					if (mediaLink6Content.indexOf(".flv") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						//linksVideo.addChild(videoLinksVid);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
					
						//Bring in Video
						linksVideo.videoLinksVid.visible = true;
						linksVideo.visible = true;
						TweenLite.to(linksVideo, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
						linksVideo.videoLinksVid.source = mediaLink6Content;
						linksVideo.videoLinksVid.play();
					} else if (mediaLink6Content.indexOf(".mp3") > -1){
						
						//isAudioPlaying
						isAudioPlaying6 = true;
						
						tab3Media.media6.mediaPlay.gotoAndStop("pause");
						tab3Media.media6.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, playMedia6);
						tab3Media.media6.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, stopAudio6);
						
						soundFile6 = new Sound();
						soundFile6.load(new URLRequest(mediaLink6Content));
						sndChannel6 = soundFile6.play();
						
						tab3Media.media6.playingAudio.visible = true;
						tab3Media.media6.mediaTitle.visible = false;
						tab3Media.media6.mediaDesc.visible = false;
						
						//Audio Scrubber
						tab3Media.media6.trackScrubber.visible = true;
						tab3Media.media6.trackBack.visible = true;
						
						soundFile6.addEventListener(Event.COMPLETE, soundLoadedDone6);
						tab3Media.media6.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
						
						function soundLoadedDone6(e:Event):void{
							timerCount = new Timer(100);
							timerCount.start();
							timerCount.addEventListener(TimerEvent.TIMER, updateScrub);
						}
						function updateScrub(e:TimerEvent):void{
							tallytime = (soundFile6.length/1000);
							tallyCurrentTime = ((sndChannel6.position/1000)/tallytime);
							//trace(tallyCurrentTime);
							updatedTime = tallyCurrentTime * tab3Media.media6.trackBack.width - 2 ;
							//Was up  right after the width. Putting it here incase I need it again "+ tab3Media.media1.trackBack.x"
							//trace(updatedTime);
							tab3Media.media6.trackScrubber.follower.x = updatedTime;
							if(sndChannel6.position >= soundFile6.length - 500){
								timerCount.stop();
								projectorBack.persVid.play();
							}
						}
						
						function startScrub(e:MouseEvent):void{
							tab3Media.media6.trackScrubber.follower.startDrag(false, new Rectangle(0,0,tab3Media.media6.trackBack.width,0));
							tab3Media.media6.trackScrubber.removeEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.addEventListener(MouseEvent.MOUSE_UP, stopScrub);
							sndChannel6.stop();
							timerCount.stop();
						}
						function stopScrub(e:MouseEvent):void{
							tab3Media.media6.trackScrubber.follower.stopDrag();
							tab3Media.media6.trackScrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
							stage.removeEventListener(MouseEvent.MOUSE_UP, stopScrub);	
							percNeeded = tab3Media.media6.trackScrubber.follower.x / (tab3Media.media6.trackBack.width + tab3Media.media6.trackBack.x);
							perToGoTo = Math.floor((percNeeded * tallytime) * 1000);
							//tab3Media.media1.trackScrubber.follower.x = updatedTime;
							sndChannel6 = soundFile6.play(perToGoTo);
							
							timerAgainCount = new Timer(100);
							timerAgainCount.start();
							timerAgainCount.addEventListener(TimerEvent.TIMER, startAgain);
						}
						
						function startAgain(e:TimerEvent):void{
							timerCount.start();
							timerAgainCount.stop();
						}
						
						function stopAudio6(e:MouseEvent):void{
							if (sndChannel6) {
								sndChannel6.stop();
							}
							//sndChannel.stop();
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							tab3Media.media6.invisiBTN.removeEventListener(MouseEvent.MOUSE_DOWN, stopAudio6);
							tab3Media.media6.invisiBTN.addEventListener(MouseEvent.MOUSE_DOWN, playMedia6);
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
						}
					} else if (mediaLink6Content.indexOf(".jpg") > -1 || mediaLink6Content.indexOf(".png") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader6.load(imageRequest6);
						linksImage.linksImage.addChild(imageLoader6);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksImage, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					} else if (mediaLink6Content.indexOf(".swf") > -1){
						
						if (isAudioPlaying1 == true){
							sndChannel1.stop();
							isAudioPlaying1 == false;
							
							tab3Media.media1.mediaPlay.gotoAndStop("play");
							
							tab3Media.media1.playingAudio.visible = false;
							tab3Media.media1.mediaTitle.visible = true;
							tab3Media.media1.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media1.trackScrubber.visible = false;
							tab3Media.media1.trackBack.visible = false;
							
						} else if (isAudioPlaying2 == true){
							sndChannel2.stop();
							isAudioPlaying2 == false;
							
							tab3Media.media2.mediaPlay.gotoAndStop("play");
							
							tab3Media.media2.playingAudio.visible = false;
							tab3Media.media2.mediaTitle.visible = true;
							tab3Media.media2.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media2.trackScrubber.visible = false;
							tab3Media.media2.trackBack.visible = false;
							
						} else if (isAudioPlaying3 == true){
							sndChannel3.stop();
							isAudioPlaying3 == false;
							
							tab3Media.media3.mediaPlay.gotoAndStop("play");
							
							tab3Media.media3.playingAudio.visible = false;
							tab3Media.media3.mediaTitle.visible = true;
							tab3Media.media3.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media3.trackScrubber.visible = false;
							tab3Media.media3.trackBack.visible = false;
							
						} else if (isAudioPlaying4 == true){
							sndChannel4.stop();
							isAudioPlaying4 == false;
							
							tab3Media.media4.mediaPlay.gotoAndStop("play");
							
							tab3Media.media4.playingAudio.visible = false;
							tab3Media.media4.mediaTitle.visible = true;
							tab3Media.media4.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media4.trackScrubber.visible = false;
							tab3Media.media4.trackBack.visible = false;
							
						} else if (isAudioPlaying5 == true){
							sndChannel5.stop();
							isAudioPlaying5 == false;
							
							tab3Media.media5.mediaPlay.gotoAndStop("play");
							
							tab3Media.media5.playingAudio.visible = false;
							tab3Media.media5.mediaTitle.visible = true;
							tab3Media.media5.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media5.trackScrubber.visible = false;
							tab3Media.media5.trackBack.visible = false;
							
						} else if (isAudioPlaying6 == true){
							sndChannel6.stop();
							isAudioPlaying6 == false;
							
							tab3Media.media6.mediaPlay.gotoAndStop("play");
							
							tab3Media.media6.playingAudio.visible = false;
							tab3Media.media6.mediaTitle.visible = true;
							tab3Media.media6.mediaDesc.visible = true;
							
							//Audio Scrubber
							tab3Media.media6.trackScrubber.visible = false;
							tab3Media.media6.trackBack.visible = false;
							
						}// end if statement
						
						//Stop Pers Vid
						projectorBack.persVid.stop();
						imageLoader6.load(imageRequest6);
						linksSWF.linksImage.addChild(imageLoader6);
						//Fade in fader
						fader.alpha = 0;
						fader.visible = true;
						TweenLite.to(fader, .5, {alpha:.75});
						
						//Bring in image
						TweenLite.to(linksSWF, 1, {x:260, y:128, motionBlur:true, ease:Cubic.easeInOut});
					}// End if statement
				}
			} else if (e.currentTarget==projectorBack.linksArea.tab4){
				projectorBack.linksArea.setChildIndex(tab2Media, 0);
				projectorBack.linksArea.setChildIndex(tab3Media, 0);
				projectorBack.linksArea.setChildIndex(tab4Media, 9);
				projectorBack.linksArea.setChildIndex(projectorBack.linksArea.allHypers, 0);
				//hide up and down buttons
				projectorBack.linksArea.downHyper.visible = false;
				projectorBack.linksArea.upHyper.visible = false;
				//projectorBack.linksArea.setChildIndex(tab6Media, 0);
			}// End if Statement
		}// End
		
		//Close out links media
		public function closeLinksMedia(e:MouseEvent):void{
			TweenLite.to(linksVideo, .8, {x:1086, y:128, motionBlur:true, ease:Cubic.easeInOut, onComplete:takeAwayEverything});
			linksVideo.videoLinksVid.stop();
			TweenLite.to(fader, 1, {alpha:0});
			projectorBack.persVid.play();
			linksVideo.videoLinksVid.visible = false;
			//linksVideo.removeChild(videoLinksVid);
		}// End closeLinksMedia
		public function closeImageMedia(e:MouseEvent):void{
			TweenLite.to(linksImage, .8, {x:1086, y:128, motionBlur:true, ease:Cubic.easeInOut, onComplete:takeAwayEverything});
			//inksImage.videoLinksVid.stop();
			TweenLite.to(fader, 1, {alpha:0});
			projectorBack.persVid.play();
		}// End closeLinksMedia
		public function closeImageSWF(e:MouseEvent):void{
			TweenLite.to(linksSWF, .8, {x:1086, y:128, motionBlur:true, ease:Cubic.easeInOut, onComplete:takeAwayEverything});
			//inksImage.videoLinksVid.stop();
			TweenLite.to(fader, 1, {alpha:0});
			projectorBack.persVid.play();
		}// End closeLinksMedia
		
		public function takeAwayEverything(e:Event = null):void{
			fader.visible = false;
		}
		
		// Show language area
		public function showLangArea (e:MouseEvent):void{
			//Show down on show links
			projectorBack.infoArea.mediaLinks.gotoAndStop("up");
			projectorBack.infoArea.transcriptBTN.gotoAndStop("over");
			
			projectorBack.langArea.visible = true;
			projectorBack.linksArea.visible = false
			projectorBack.infoArea.setChildIndex(projectorBack.infoArea.transcriptBTN, 5);
			projectorBack.infoArea.setChildIndex(projectorBack.infoArea.mediaLinks, 4);
			if (sndChannel1) {
				sndChannel1.stop();
			}
			if (sndChannel2) {
				sndChannel2.stop();
			}
			if (sndChannel3) {
				sndChannel3.stop();
			}
			if (sndChannel4) {
				sndChannel4.stop();
			}
			if (sndChannel5) {
				sndChannel5.stop();
			}
			if (sndChannel6) {
				sndChannel6.stop();
			}
			
		}// End showLangArea
		
		public function showLang (e:MouseEvent = null):void{
			
			//projectorBack.langArea.tab2Back.mouseEnabled = false;
			
			if(e.currentTarget==projectorBack.tab2){
				//Setting Index of tabs
				projectorBack.langArea.setChildIndex(tab2BackMC, 4);
				projectorBack.langArea.setChildIndex(tab3BackMC, 0);
				projectorBack.langArea.setChildIndex(tab4BackMC, 0);
				projectorBack.langArea.setChildIndex(tab6BackMC, 0);
				
				if (pers1Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective1.language2;
					lang1ScrollBar.update();
				} else if (pers2Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective2.language2;
					lang1ScrollBar.update();
				} else if (pers3Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective3.language2;
					lang1ScrollBar.update();
				} else if (pers4Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective4.language2;
					lang1ScrollBar.update();
				} else if (pers5Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective5.language2;
					lang1ScrollBar.update();
				} else if (pers6Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective6.language2;
					lang1ScrollBar.update();
				}// End if statement to see which one to pull up
			} else if (e.currentTarget==projectorBack.tab3){
				//Setting Index of tabs
				projectorBack.langArea.setChildIndex(tab2BackMC, 0);
				projectorBack.langArea.setChildIndex(tab3BackMC, 4);
				projectorBack.langArea.setChildIndex(tab4BackMC, 0);
				projectorBack.langArea.setChildIndex(tab6BackMC, 0);
				
				if (pers1Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective1.language3;
					lang1ScrollBar.update();
				} else if (pers2Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective2.language3;
					lang1ScrollBar.update();
				} else if (pers3Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective3.language3;
					lang1ScrollBar.update();
				} else if (pers4Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective4.language3;
					lang1ScrollBar.update();
				} else if (pers5Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective5.language3;
					lang1ScrollBar.update();
				} else if (pers6Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective6.language3;
					lang1ScrollBar.update();
				}/// End if statement to see which one to pull up
			} else if (e.currentTarget==projectorBack.tab4){
				//Setting Index of tabs
				projectorBack.langArea.setChildIndex(tab2BackMC, 0);
				projectorBack.langArea.setChildIndex(tab3BackMC, 0);
				projectorBack.langArea.setChildIndex(tab4BackMC, 4);
				projectorBack.langArea.setChildIndex(tab6BackMC, 0);
				
				if (pers1Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective1.language4;
					lang1ScrollBar.update();
				} else if (pers2Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective2.language4;
					lang1ScrollBar.update();
				} else if (pers3Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective3.language4;
					lang1ScrollBar.update();
				} else if (pers4Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective4.language4;
					lang1ScrollBar.update();
				} else if (pers5Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective5.language4;
					lang1ScrollBar.update();
				} else if (pers6Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective6.language4;
					lang1ScrollBar.update();
				}/// End if statement to see which one to pull up
			} else if (e.currentTarget==projectorBack.tab6){
				//Setting Index of tabs
				projectorBack.langArea.setChildIndex(tab2BackMC, 0);
				projectorBack.langArea.setChildIndex(tab3BackMC, 0);
				projectorBack.langArea.setChildIndex(tab4BackMC, 0);
				projectorBack.langArea.setChildIndex(tab6BackMC, 4);
				
				if (pers1Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective1.language5;
					lang1ScrollBar.update();
				} else if (pers2Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective2.language5;
					lang1ScrollBar.update();
				} else if (pers3Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective3.language5;
					lang1ScrollBar.update();
				} else if (pers4Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective4.language5;
					lang1ScrollBar.update();
				} else if (pers5Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective5.language5;
					lang1ScrollBar.update();
				} else if (pers6Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective6.language5;
					lang1ScrollBar.update();
				}/// End if statement to see which one to pull up
			}else if (e.currentTarget==projectorBack.tab1){
				//Setting Index of tabs
				projectorBack.langArea.setChildIndex(tab2BackMC, 0);
				projectorBack.langArea.setChildIndex(tab3BackMC, 0);
				projectorBack.langArea.setChildIndex(tab4BackMC, 0);
				projectorBack.langArea.setChildIndex(tab6BackMC, 0);
				
				if (pers1Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective1.language1;
					lang1ScrollBar.update();
				} else if (pers2Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective2.language1;
					lang1ScrollBar.update();
				} else if (pers3Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective3.language1;
					lang1ScrollBar.update();
				} else if (pers4Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective4.language1;
					lang1ScrollBar.update();
				} else if (pers5Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective5.language1;
					lang1ScrollBar.update();
				} else if (pers6Lang){
					projectorBack.langArea.langAreaText.htmlText = currentPageTag.perspectives.perspective6.language1;
					lang1ScrollBar.update();
				}/// End if statement to see which one to pull up
			} // End if statement
		}// End showLang
		
	}// End Class
}// End Package