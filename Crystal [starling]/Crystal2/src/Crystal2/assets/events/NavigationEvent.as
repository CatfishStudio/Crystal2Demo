package Crystal2.assets.events 
{
	  import starling.events.Event;

      public class NavigationEvent extends Event
      {
         public static const CHANGE_SCREEN:String = "changeScreen";
         public var param:Object;

         public function NavigationEvent(type:String, _params:Object=null, bubbles:Boolean=false)
         {
            super(type, bubbles);
            this.param = _params;
         }
      } 

}