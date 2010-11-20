package com.disturbmedia.pb.utils {
	import com.bit101.components.HBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.VBox;

	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import flash.events.Event;

	/**
	 * @author George Profenza
	 */
	public class Float2Control extends Control {
		
		protected var _label:Label;
		protected var _slider0:HUISlider;
		protected var _slider1 : HUISlider;
		protected var _hbox : HBox;
		protected var _vbox : VBox;
		
		override protected function init(parameter : ShaderParameter,onUpdate:Function = null) : void {
			super.init(parameter, onUpdate);
			_hbox = new HBox(_container, 0, 0);
			_hbox.spacing = 0;
			_label = new Label(_hbox, 0, 0, parameter.name);
			_vbox = new VBox(_hbox);
			_vbox.spacing = 0;
			_slider0 = new HUISlider(_vbox, 0, 0, "[0]", valueChanged);
			_slider1 = new HUISlider(_vbox, 0, 0, "[1]", valueChanged);
			_slider0.setSize(_slider0.width - _label.width, _slider0.height);
			_slider1.setSize(_slider1.width - _label.width, _slider1.height);
			_width += _label.width + _slider0.width;
			_height += _slider0.height + _spacing;
			_height += _slider1.height + _spacing;
			if (parameter.minValue && parameter.maxValue && parameter.defaultValue){
				_slider0.setSliderParams(parameter.minValue[0], parameter.maxValue[0], parameter.defaultValue[0]);
				_slider1.setSliderParams(parameter.minValue[1], parameter.maxValue[1], parameter.defaultValue[1]);
				if (parameter.type == ShaderParameterType.FLOAT2){
					if (parameter.minValue[0] == 0 && parameter.maxValue[0] <= 1) _slider0.tick = .1;
					if (parameter.minValue[1] == 0 && parameter.maxValue[1] <= 1) _slider1.tick = .1;
				}
			}
			graphics.lineStyle(1,0x999999,0);
			graphics.drawRect(0, 0, _width, _height);
		}
		override public function reset() : void {
			_slider0.value = _parameter.defaultValue[0];
			_slider1.value = _parameter.defaultValue[1];
		}

		override public function invalidate() : void {
			_slider0.dispatchEvent(_changeEvent);
			_slider1.dispatchEvent(_changeEvent);
		}
		override protected function valueChanged(event : Event = null) : void {
			_value[0] = _slider0.value;
			_value[1] = _slider1.value;
			super.valueChanged();
		}
	}
}
