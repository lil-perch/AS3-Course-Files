////////////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2008 Gabriel Montagné Láscaris-Comneno and Alberto
// Brealey-Guzmán.
// 
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
// 
////////////////////////////////////////////////////////////////////////////////

package src.pages.vlp.manager
{

import src.pages.vlp.events.AudioEvent;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.TimerEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundLoaderContext;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.Timer;
//import mx.core.IMXMLObject;

//--------------------------------------
// Events
//--------------------------------------

/**
 *  Dispatched when the audio file has completed loading.
 *
 *  @eventType flash.events.Event.COMPLETE
 */
[Event(name="complete")]

/**
 *  Dispatched when ID3 data is available for an MP3 sound.
 *
 *  @eventType flash.events.Event.ID3
 */
[Event(name="id3")]

/**
 *  Dispatched when an error causes the load operation to fail.
 */
[Event(name="ioError", type="flash.events.IOErrorEvent")]

/**
 *  Dispatched when a connection has been opened.
 */
[Event(name="open")]

/**
 *  Dispatched continuosly while the video is playing.
 * 
 *  @eventType com.rojored.view.controls.audioClasses.AudioEvent
 */
[Event(name="playheadUpdate", type="com.rojored.view.controls.audioClasses.AudioEvent")]

/**
 *  Dispatched continuously until the FLV file has downloaded completely.
 * 
 *  @eventType flash.events.ProgressEvent
 */
[Event(name="progress", type="flash.events.ProgressEvent")]

/**
 *  Dispatched when the sound has finished playing.
 *
 *  @eventType flash.events.Event
 */
[Event(name="soundComplete")]

/**
 *  Chromeless audio player that allows scrubbing and the use of embedded
 *  sources.
 * 
 *  @author Gabriel Montagné Láscaris-Comneno gabriel@rojored.com 
  implements IMXMLObject 
 
 */
public class Audio extends EventDispatcher
{

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function Audio() 
    {
        super();
		initialized(null,'id');
    } 

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private var sound:Sound;

    /**
     *  @private
     */
    private var channel:SoundChannel;

    /**
     *  @private
     */
    private var soundTransform:SoundTransform;

    /**
     *  @private
     *  Indicates the last measured time before pausing. Used to determine the
     *  playhead time when resuming.
     */
    private var resumeTime:Number = 0;

    /**
     *  @private
     *  Indicates the length of the sound we have we use it with bytes total
     *  and loaded to estimate the actual length of the audio being played
     */
    private var loadedLength:Number = 0;

    /**
     *  @private
     */
    private var isInitialized:Boolean;

    /**
     *  @private
     */
    private var channelUpdateTimer:Timer;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  source
    //--------------------------------------

    /**
     *  @private
     *  Storage for the source property
     */
    private var _source:Object;

    [Bindable("sourceChanged")]

    /**
     *  Relative path and filename of the audio file to play.
     */
    public function get source():Object 
    {
        return _source;
    }

    /**
     *  @private
     */
    public function set source(value:Object):void 
    {
        if (_source == value) 
            return;

        stop();

        _source = value;
        dispatchEvent(new Event("sourceChanged"));

        if (autoPlay)   
            play();
    }

    //--------------------------------------
    //  playheadTimeChanged 
    //--------------------------------------

    /**
     *  @private 
     *  Storage for the playheadTime property
     */
    private var _playheadTime:Number = 0;

    [Bindable("playheadUpdate")]

    /**
     *  Playhead position, measured in seconds, since the audio starting
     *  playing. 
     *
     *  <p>Setting this property to a value in seconds performs a seek
     *  operation. If the audio is currently playing, it continues playing
     *  from the new playhead position.  If the video is paused, it seeks to
     *  the new playhead position and remains paused.  </p>
     */
    public function get playheadTime():Number 
    {
        return _playheadTime;
    }

    /**
     *  @private
     */
    public function set playheadTime(value:Number):void 
    {
        if (_playheadTime == value)     
            return;

        var wasPaused:Boolean = _isPaused;
        var wasPlaying:Boolean = _isPlaying;

        pause();

        _playheadTime = resumeTime = Math.min(value, loadedLength); 

        dispatchEvent(
            new AudioEvent(
                AudioEvent.PLAYHEAD_UPDATE,
                false,
                false,
                _playheadTime
            )
        );

        // TODO: we should we throw errors for out of range values?
        // TODO: should we throw the autoPlay into this AND?
        if (!wasPaused && wasPlaying) 
            play();
    }

    //--------------------------------------
    //  leftPeak 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the leftPeak property
     */
    private var _leftPeak:Number = 0;

    [Bindable("playheadUpdate")]

    /**
     *  The current amplitude (volume) of the left channel, from 0 (silent) to
     *  1 (full amplitude)
     */
    public function get leftPeak():Number 
    {
        return _leftPeak;
    }

    //--------------------------------------
    //  rightPeak 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the rightPeak property
     */
    private var _rightPeak:Number = 0;

    [Bindable("playheadUpdate")]

    /**
     *  The current amplitude (volume) of the right channel, from 0 (silent) to
     *  1 (full amplitude)
     */
    public function get rightPeak():Number 
    {
        return _rightPeak;
    }

    //--------------------------------------
    //  totalTime 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the totalTime property
     */
    private var _totalTime:Number = 0;

    [Bindable("progress")]
    [Bindable("complete")]

    /**
     *  Total length of the media, in milliseconds.
     */
    // TODO: transform to seconds?
    public function get totalTime():Number 
    {
        return _totalTime;
    }

    //--------------------------------------
    //  volume 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the volume property
     */
    private var _volume:Number = 1;

    [Bindable("volumeChanged")]

    /**
     *  The volume, ranging from 0 (silent) to 1 (full volume).
     */
    public function get volume():Number 
    {
        return _volume;
    }

    /**
     *  @private
     */
    public function set volume(value:Number):void 
    {

        if (_volume == value) 
            return;

        _volume = value > 1 ? 1
                : value < 0 ? 0
                : value
                ;

        updateSoundTransform();
        dispatchEvent(new Event("volumeChanged"));
    }

    //--------------------------------------
    //  pan 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the pan property
     */
    private var _pan:Number = 0;

    [Bindable("panChanged")]

    /**
     *  left-to-right panning of the sound, raging from -1 (full pan left) to 1
     *  (full pan right).
     */
    public function get pan():Number 
    {
        return _pan;
    }

    /**
     *  @private
     */
    public function set pan(value:Number):void 
    {
        if (_pan == value) return;
        _pan = value < -1 ? -1
                : value > 1 ? 1 
                : value
                ;
        updateSoundTransform();
        dispatchEvent(new Event("panChanged"));

    }

    //--------------------------------------
    //  isPlaying 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the isPlaying property
     */
    private var _isPlaying:Boolean;

    [Bindable("playheadUpdate")]
    [Bindable("soundComplete")]

    /**
     *  If <code>true</code>, the audio is currently playing.
     */
    public function get isPlaying():Boolean 
    {
        return _isPlaying && !_isBuffering;
    }

    /**
     *  @private
     */
    public function set isPlaying(value:Boolean):void
    {
        if (_isPlaying == value)
            return;

        _isPlaying = value;
    }

    //--------------------------------------
    //  playing 
    //--------------------------------------

    [Bindable("playheadUpdate")]
    [Bindable("soundComplete")]

    /**
     *  Small concesion for users familiar the VideoDisplay component API.
     */
    public function get playing():Boolean
    {
        return isPlaying;
    }

    //--------------------------------------
    //  isPaused 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the isPaused property
     */
    private var _isPaused:Boolean;

    [Bindable("playheadUpdate")]

    /**
     *  If <code>true</code>, the audio is currently paused.
     */
    public function get isPaused():Boolean 
    {
        return _isPaused;
    }

    //--------------------------------------
    //  isBuffering 
    //--------------------------------------

    /**
     *  @private
     *  Storage for tha isBuffering property
     */
    private var _isBuffering:Boolean;

    [Bindable("playheadUpdate")]

    /**
     *  If <code>true</code> the audio is being buffered.
     */
    public function get isBuffering():Boolean 
    {
        return _isBuffering;
    }

    //--------------------------------------
    //  bytesLoaded 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the bytesLoaded property
     */
    private var _bytesLoaded:int;

    [Bindable("progress")]

    /**
     *  The number of bytes that are loaded for the audio file.
     */
    public function get bytesLoaded():int 
    {
        return _bytesLoaded;
    }

    //--------------------------------------
    //  bytesTotal 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the bytesTotal property
     */
    private var _bytesTotal:int;

    [Bindable("progress")]

    /**
     *  The number of bytes in the entire audio file.
     */
    public function get bytesTotal():int 
    {
        return _bytesTotal;
    }

    //--------------------------------------
    //  album 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the album property
     */
    private var _album:String = "";

    [Bindable("id3")]

    /**
     *  The name of the album; corresponds to the ID3 2.0 tag TALB.
     */
    public function get album():String 
    {
        return _album;
    }

    //--------------------------------------
    //  artist 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the artist property
     */
    private var _artist:String = "";

    [Bindable("id3")]

    /**
     *  The name of the artist; corresponds to the ID3 2.0 tag TPE1.
     */
    public function get artist():String 
    {
        return _artist;
    }

    //--------------------------------------
    //  comment 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the comment property
     */
    private var _comment:String = "";

    [Bindable("id3")]

    /**
     *  A comment about the recording; corresponds to the ID3 2.0 tag COMM.
     */
    public function get comment():String 
    {
        return _comment;
    }

    //--------------------------------------
    //  comment 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the genre property
     */
    private var _genre:String = "";

    [Bindable("id3")]

    /**
     *  The genre of the song; corresponds to the ID3 2.0 tag TCON.
     */
    public function get genre():String 
    {
        return _genre;
    }

    //--------------------------------------
    //  songName 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the songName property
     */
    private var _songName:String = "";

    [Bindable("id3")]

    /**
     *  The name of the song; corresponds to the ID3 2.0 tag TIT2.
     */
    public function get songName():String 
    {
        return _songName;
    }

    //--------------------------------------
    //  track 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the track property
     */
    private var _track:String = "";

    [Bindable("id3")]

    /**
     *  The track number; corresponds to the ID3 2.0 tag TRCK.
     */
    public function get track():String 
    {
        return _track;
    }

    //--------------------------------------
    //  year 
    //--------------------------------------

    /**
     *  @private
     *  Storage for the year property
     */
    private var _year:String = "";

    [Bindable("id3")]

    /**
     *  The year of the recording; corresponds to the ID3 2.0 TYER.
     */
    public function get year():String 
    {
        return _year;
    }

    //--------------------------------------
    //  autoPlay 
    //--------------------------------------

    [Bindable] 

    /**
     *  Specifies whether the audio should start playing immediately when the
     *  source property is set.
     */
    public var autoPlay:Boolean = true;

    //--------------------------------------
    //  autoRewind 
    //--------------------------------------

    [Bindable] 

    /**
     *  Specifies whether the audio should be rewond to the beginning when play
     *  stops.
     */
    public var autoRewind:Boolean = true; // TODO: double check functionality.

    //--------------------------------------
    //  bufferTime 
    //--------------------------------------

    [Bindable] 

    /**
     *  The number of seconds to preload a streaming sound into a buffer before
     *  the sound starts to stream.
     */
    public var bufferTime:Number = 1000;

    [Bindable] 

    //--------------------------------------
    //  checkPolicyFile 
    //--------------------------------------

    /**
     *  Specifies whether the existence of a cross-domain policy file should be
     *  checked upon.  This is neccessary if ID3 tags are to be processed, but
     *  the source needs to be inside the security sandbox.
     *
     *  <p>Sandbox security errors will be swallowed by the component.</p>
     */
    public var checkPolicyFile:Boolean = true;

    //--------------------------------------
    //  playheadUpdateInterval 
    //--------------------------------------

    [Bindable]

    /**
     *  Specifies the amount of time, in milliseconds, between each
     *  <code>playheadUpdate</code> event.
     */
    public var playheadUpdateInterval:Number = 250;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    public function initialized(document:Object, id:String):void 
    {
        isInitialized = true;
        if (_source && autoPlay) 
            play();
    }

    /**
     *  @private
     */
    private function prepareSound():void 
    {

        // if we have to actually load the sound
        if (_source is String) 
            loadSound(String(_source));

        // or is it embeded
        if (_source is Class) 
            instantiateSoundFromClass(Class(_source));

    }

    /**
     *  @private
     */
    private function loadSound(url:String):void 
    {

        soundCleanup();
        sound = new Sound(); 

        attachSoundListeners();

        sound.load(
            new URLRequest(url),
            new SoundLoaderContext(bufferTime, checkPolicyFile)
        );

    }

    /**
     *  @private
     */
    private function instantiateSoundFromClass(soundClass:Class):void 
    {

        sound = new soundClass() as Sound;
        loadedLength = sound.length;
        _totalTime = sound.length;
        _bytesTotal = sound.bytesTotal;
        _bytesLoaded = sound.bytesLoaded;

        // fake that we loaded everything instantaneously to force binding
        // refresh.
        // TODO: actually send a progress event with the appropriate data.
        dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));

        sound_id3Handler(null); // force id3 refresh

        dispatchEvent(new Event(Event.COMPLETE));

    }

    /**
     *  @private
     */
    private function updateSoundTransform():void 
    {
        soundTransform = soundTransform || new SoundTransform(); 
        soundTransform.volume = volume;
        soundTransform.pan = pan;
        if (channel) 
            channel.soundTransform = soundTransform;
    }

    /**
     *  @private
     */
    private function cleanup():void 
    {
        soundCleanup();
        channelCleanup();
    }

    /**
     *  @private
     */
    private function soundCleanup():void 
    {
        if (!sound) 
            return;

        try 
        {
            sound.close();
        } 
        catch (error:IOError) 
        {
            // channel was not open, nothing to worry about.
        }

        removeSoundListeners();
        sound = null;
    }

    /**
     *  @private
     */
    private function channelCleanup():void 
    {
        if (!channel) return;

        channel.removeEventListener(
            Event.SOUND_COMPLETE,
            channel_soundCompleteHandler
        );

        channelUpdateTimer.stop();
        channelUpdateTimer.removeEventListener(
            TimerEvent.TIMER,
            channelUpdateTimer_timerHandler
        );
        channel = null;
    }

    /**
     *  @private
     */
    private function attachSoundListeners():void 
    {
        if (!sound) 
            return;

        sound.addEventListener(Event.COMPLETE, sound_completeHandler);
        sound.addEventListener(Event.ID3, sound_id3Handler);
        sound.addEventListener(Event.OPEN, sound_openHandler);
        sound.addEventListener(IOErrorEvent.IO_ERROR, sound_ioErrorHandler);
        sound.addEventListener(ProgressEvent.PROGRESS, sound_progressHandler);
    }

    /**
     *  @private
     */
    private function removeSoundListeners():void 
    {

        if (!sound) 
            return;

        sound.removeEventListener(Event.COMPLETE, sound_completeHandler);
        sound.removeEventListener(Event.ID3, sound_id3Handler);
        sound.removeEventListener(Event.OPEN, sound_openHandler);
        sound.removeEventListener(IOErrorEvent.IO_ERROR, sound_ioErrorHandler);
        sound.removeEventListener(
            ProgressEvent.PROGRESS,
            sound_progressHandler
        );

    }

    /**
     *  @private
     */
    private function primeChannel():void 
    {
        if (!channel) 
            return;

        channel.soundTransform = soundTransform;
        channel.addEventListener(
            Event.SOUND_COMPLETE, 
            channel_soundCompleteHandler
        );
        channelUpdateTimer = new Timer(playheadUpdateInterval);

        channelUpdateTimer.addEventListener(
            TimerEvent.TIMER,
            channelUpdateTimer_timerHandler
        );

        channelUpdateTimer.start();
    }

    /**
     *  @private
     */
    private function resetID3Tags():void 
    {

        // reset properties
        _artist = _album = _comment = _genre = _songName = _track = _year =
            "";

        dispatchEvent(new Event(Event.ID3));
    }

    /**
     *  @private
     */
    private function resetLoadingInfo():void 
    {

        _bytesTotal = _bytesLoaded = _totalTime = 0;

        // TODO: pack the appropriate params.
        dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
    }

    /**
     *  @private
     */
    private function relayEvent(event:Event):void 
    {
        dispatchEvent(event);
    }

    /**
     *  Starts playing the audio.
     */
    public function play():void 
    {
        if (!isInitialized) 
            return;

        if (_isPlaying || !_isPaused) 
            stop();

        if (!_source) 
            return;

        if (!sound) 
            prepareSound();

        if (!soundTransform) 
            updateSoundTransform();

        channelCleanup();

        channel = sound.play(resumeTime);

        primeChannel();

        _isPlaying = true;
        _isPaused = false;
    }

    /**
     *  Pauses the audio.
     */
    public function pause():void 
    {
        if (!_isPlaying || _isPaused) 
            return;

        resumeTime = _playheadTime;
        channel.stop();

        _isPlaying = false;
        _isPaused = true;
    }

    /**
     *  Stops the audio.
     */
    public function stop():void 
    {
        resetID3Tags();
        resetLoadingInfo();

        if (channel) channel.stop();
        cleanup();

        resumeTime = 0;

        _isPlaying = false;
        _isPaused = false;
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private function channelUpdateTimer_timerHandler(event:TimerEvent):void 
    {
        // Mostly used for when paused; if we don't check for updates, we
        // could dispatch PLAYHEAD_UPDATE many times without having
        // anything new to really broadcast
        // TODO: double check and optimize
        var broadcastChange:Boolean = (
                (_isBuffering != sound.isBuffering) 
            ||  (_leftPeak != channel.leftPeak)
            ||  (_rightPeak != channel.rightPeak)
            ||  (!_isPaused && (_playheadTime != channel.position))
        );

        if (!broadcastChange) 
            return;

        _isBuffering = sound.isBuffering;
        _leftPeak = channel.leftPeak;
        _rightPeak = channel.rightPeak;

        // this is for scrubbing while paused.
        if (!_isPaused) _playheadTime = channel.position;

        dispatchEvent(
            new AudioEvent(
                AudioEvent.PLAYHEAD_UPDATE,
                false,
                false,
                _playheadTime
            )
        );
    }

    /**
     *  @private
     */
    private function channel_soundCompleteHandler(event:Event):void 
    {
        if (autoRewind) 
        {
            stop();
            if (autoPlay)
                play();
        }
        else 
        {
            pause();
        }
        relayEvent(event);
    }

    /**
     *  @private
     */
    private function sound_completeHandler(event:Event):void 
    {
        relayEvent(event);
    }

    /**
     *  @private
     */
    private function sound_openHandler(event:Event):void 
    {
        relayEvent(event);
    }

    /**
     *  @private
     */
    private function sound_progressHandler(event:ProgressEvent):void 
    {
        _bytesLoaded = event.bytesLoaded;
        _bytesTotal = event.bytesTotal;
        loadedLength = sound.length;

        // loadedLength indicates the length of the sound we have
        // actually already loaded. we use bytes total and loaded to
        // project, more or less, how long the sound will end up being.
        _totalTime = Math.ceil(
            loadedLength / (_bytesLoaded / _bytesTotal)
        ); 
        relayEvent(event);
    }

    /**
     *  @private
     */
    private function sound_ioErrorHandler(event:IOErrorEvent):void 
    {
        stop();

        // we only want to relay the event if it's being handled outside
        // as well... nasty runtime errors we're not interested in.
        if (hasEventListener(IOErrorEvent.IO_ERROR)) 
            relayEvent(event);
    }

    /**
     *  @private
     */
    private function sound_id3Handler(event:Event = null):void 
    {
        try 
        {
            _artist = sound.id3.artist || "";
            _album = sound.id3.album || "";
            _comment = sound.id3.comment || "";
            _genre = sound.id3.genre || "";
            _songName = sound.id3.songName || "";
            _track = sound.id3.track || "";
            _year = sound.id3.year || "";
        } 
        catch (error:SecurityError) 
        {
            // nothing too bad. we just don't have security permission to
            // see the id3 tags of the current file.
        } 
        relayEvent(event || new Event(Event.ID3));
    }
}
}
