package com.disturbmedia.pb.utils {
	import com.bit101.components.HUISlider;

	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import flash.events.Event;
	/**
	 * @author George Profenza
	 */
	public class Float4Control extends Float3Control {
		
		protected var _slider3:HUISlider;
		
		override protected function init(parameter : ShaderParameter,onUpdate:Function = null) : void {
			super.init(parameter,onUpdate);
			_slider3 = new HUISlider(_vbox, 0, 0, "[3]", valueChanged);
			_slider3.setSize(_slider3.width - _label.width, _slider3.height);
			_height += _slider3.height * 2 + _spacing;
			if (parameter.minValue && parameter.maxValue && parameter.defaultValue){
				_slider3.setSliderParams(parameter.minValue[3], parameter.maxValue[3], parameter.defaultValue[3]);
				if (parameter.type == ShaderParameterType.FLOAT4){
					if (parameter.minValue[0] == 0 && parameter.maxValue[0] <= 1) _slider0.tick = .1;
					if (parameter.minValue[1] == 0 && parameter.maxValue[1] <= 1) _slider1.tick = .1;
					if (parameter.minValue[2] == 0 && parameter.maxValue[2] <= 1) _slider2.tick = .1;
					if (parameter.minValue[3] == 0 && parameter.maxValue[3] <= 1) _slider3.tick = .1;
				}
			}
			graphics.lineStyle(1,0xDEDEDE,0);
			graphics.drawRect(0, 0, _width, _height);
		}
		override public function reset() : void {
			super.reset();
			_slider3.value = _parameter.defaultValue[3];
		}

		override public function invalidate() : void {
			super.reset();
			_slider3.dispatchEvent(_changeEvent);
		}
		override protected function valueChanged(event : Event = null) : void {
			_value[3] = _slider3.value;
			super.valueChanged();
		}
		
	}
}
