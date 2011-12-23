package src.pages.utils.drag_drop {
   
   import flash.events.Event;
 
   public class CustomEvent extends Event {
     
      public static const ON_STOP_DRAG:String = "onStopDrag";
      public static const ON_START_DRAG:String = "onStartDrag";
      public static const ON_MOVE_DRAG:String = "onMoveDrag";
      public static const ON_RESET_DRAG:String = "onResetDrag";
      public static const ON_ENABLED_CHANGE:String = "onEnabledChange";
      public static const ON_UPDATE_POS:String = "onUpdatePos";
      public static const ON_COMPLETE:String = "onComplete";




     
      public var arg:*;
     
      public function CustomEvent(type:String, customArg:*=null,
                                  bubbles:Boolean=false,
                                  cancelable:Boolean=false) {
         
         super(type, bubbles, cancelable);
         
         this.arg = customArg;
         
      }
           
      public override function clone():Event {
         return new CustomEvent(type, arg, bubbles, cancelable);
      }
     
      public override function toString():String {
         return formatToString("CustomEvent", "type", "arg",
                               "bubbles", "cancelable", "eventPhase");
      }
   
   }
 
}