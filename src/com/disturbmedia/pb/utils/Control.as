package com.disturbmedia.pb.utils {
	import com.bit101.components.VBox;

	import flash.display.ShaderParameter;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author George Profenza
	 */
	public class Control extends Sprite {
		
		protected var _parameter:ShaderParameter;
		protected var _value:Array;
		protected var _onUpdateCallback:Function;
		protected var _changeEvent:Event;
		protected var _container:VBox;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _spacing:Number = 0;
		
		protected function init(parameter : ShaderParameter, onUpdate : Function = null) : void {
			_changeEvent = new Event(Event.CHANGE);
			_parameter = parameter;
			if (onUpdate != null) _onUpdateCallback = onUpdate;
			this.name = parameter.name; 
			_value = [];
			_container = new VBox(this);
			_container.spacing = 0;
		}
		protected function valueChanged(event:Event = null):void{
			callUpdate();
		}
		protected function callUpdate() : void {
			if (_onUpdateCallback != null) _onUpdateCallback(name,_value);
		}
		public function setup(parameter : ShaderParameter, onUpdate : Function = null):void {
			init(parameter, onUpdate);
		}
		public function reset():void{
			callUpdate();
		}
		public function invalidate():void{
			//callUpdate();	
		}
		public function set onUpdate(callback : Function) : void {
			_onUpdateCallback = callback;
		}

		public function getWidth() : Number {
			return _width;
		}
		public function getHeight() : Number {
			return _height;
		}		
	}
}
