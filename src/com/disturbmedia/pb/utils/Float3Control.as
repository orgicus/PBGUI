package com.disturbmedia.pb.utils {
	import com.bit101.components.HUISlider;

	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import flash.events.Event;

	/**
	 * @author George Profenza
	 */
	public class Float3Control extends Float2Control {
		
		protected var _slider2:HUISlider;
		
		override protected function init(parameter : ShaderParameter,onUpdate:Function = null) : void {
			super.init(parameter, onUpdate);
			_slider2 = new HUISlider(_vbox, 0, 0, "[2]", valueChanged);
			_slider2.setSize(_slider2.width - _label.width, _slider2.height);
			_height += _slider2.height + _spacing;
			if (parameter.minValue && parameter.maxValue && parameter.defaultValue){
				_slider2.setSliderParams(parameter.minValue[2], parameter.maxValue[2], parameter.defaultValue[2]);
				if (parameter.type == ShaderParameterType.FLOAT3){
					if (parameter.minValue[0] == 0 && parameter.maxValue[0] <= 1) _slider0.tick = .1;
					if (parameter.minValue[1] == 0 && parameter.maxValue[1] <= 1) _slider1.tick = .1;
					if (parameter.minValue[2] == 0 && parameter.maxValue[2] <= 1) _slider2.tick = .1;
				}
			}
			graphics.lineStyle(1,0xCCCCCC,0);
			graphics.drawRect(0, 0, _width, _height);
		}
		override public function reset() : void {
			super.reset();
			_slider2.value = _parameter.defaultValue[2];
		}

		override public function invalidate() : void {
			super.reset();
			_slider2.dispatchEvent(_changeEvent);
		}
		override protected function valueChanged(event : Event = null) : void {
			_value[2] = _slider2.value;
			super.valueChanged();
		}
		
	}
}
