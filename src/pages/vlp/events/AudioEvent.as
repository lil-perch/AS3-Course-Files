////////////////////////////////////////////////////////////////////////////////
//  
//  Copyright (c) 2008 Gabriel Montagné Láscaris-Comneno and Alberto
//  Brealey-Guzmán.
//  
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//  
////////////////////////////////////////////////////////////////////////////////

package src.pages.vlp.events
{

import flash.events.Event;

/**
 *  The AudioEvent class represents the event object passed to the event
 *  listener for events dispatched by the Audio control.
 *
 *  @author Gabriel Montagné Láscaris-Comneno gabriel@rojored.com 
 */
public class AudioEvent extends Event 
{

    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    /**
     *  The AudioPlayheadUpdateEvent.PLAYHEAD_UPDATE constant defines the value
     *  of the <code>type</code> property of the AudioPlayheadUpdateEvent
     *  object for a <code>playheadUpdate</code> event, which indicates that
     *  the <code>playheadTime</code> has changed.
     */
    public static const PLAYHEAD_UPDATE:String = "playheadUpdate";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor
     */
    public function AudioEvent(type:String, 
                               bubbles:Boolean = false,
                               cancelable:Boolean = false,
                               playheadTime:Number = NaN) 
    {
        super(type, bubbles, cancelable);
        this.playheadTime = playheadTime;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

	//----------------------------------
    //  playheadTime
    //----------------------------------

    /**
	 *  The location of the playhead of the Audio control 
	 *  when the event occurs.
     */   
    public var playheadTime:Number;

    //--------------------------------------------------------------------------
    //
    //  Overriden methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override public function clone():Event
    {
        return new AudioEvent(type, bubbles, cancelable, playheadTime);
    }

    /**
     *  @private
     */
    override public function toString():String 
    {
        return formatToString(
            "AudioEvent",
            "type",
            "bubbles",
            "cancelable",
            "playheadTime"
        );
    }
}
}
