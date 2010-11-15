package com.disturbmedia.pb.utils {
	import com.bit101.components.HUISlider;

	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import flash.events.Event;

	/**
	 * @author George Profenza
	 */
	public class FloatControl extends Control{
		
		protected var _slider0:HUISlider;
				
		override protected function init(parameter : ShaderParameter, onUpdate : Function = null) : void {
			super.init(parameter, onUpdate);
			_slider0 = new HUISlider(_container, 0, 0, parameter.name, valueChanged);
			_height += _slider0.height + _spacing;
			_width += _slider0.width;
			if (parameter.minValue && parameter.maxValue && parameter.defaultValue){
				_slider0.setSliderParams(parameter.minValue[0], parameter.maxValue[0], parameter.defaultValue[0]);
				if (parameter.type == ShaderParameterType.FLOAT)
					if(parameter.minValue[0] == 0 && parameter.maxValue[0] <= 1) _slider0.tick = .01;
			}
			graphics.lineStyle(1,0x777777,0);
			graphics.drawRect(0, 0, _width, _height);
		}

		override public function reset() : void {
			if(_parameter.defaultValue) _slider0.value = _parameter.defaultValue[0];
		}
		
		override public function invalidate() : void {
			_slider0.dispatchEvent(_changeEvent);
		}
		override protected function valueChanged(event : Event = null) : void {
			_value[0] = _slider0.value;
			super.valueChanged();
		}
	}
}
