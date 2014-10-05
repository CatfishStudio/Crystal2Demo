package Crystal.events 
{
	import flash.events.Event;
	
	public class NavigationEvent extends Event 
	{
		/* Описание значений константы
		 * GAME_MENU_PLAY - открытие окна глобальной карты (кнопка "Играть")
		 * GAME_BACK_IN_MENU - открытие окна главного меню (возврат в меню)
		 * 
		 * 
		 * */
		public static const CHANGE_SCREEN:String = "changeScreen";
        public var param:Object;
		
		public function NavigationEvent(type:String, _params:Object = null, bubbles:Boolean=false) 
		{
			super(type, bubbles);
			this.param = _params;
		}
		
	}

}