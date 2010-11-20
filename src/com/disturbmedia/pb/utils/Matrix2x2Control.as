package com.disturbmedia.pb.utils {
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;

	import flash.display.ShaderParameter;
	import flash.events.Event;
	/**
	 * @author George Profenza
	 */
	public class Matrix2x2Control extends Control {
		
		protected var _label:Label;
		protected var _size:int = 2;
		protected var _numInputs:int = 4;
		protected var _inputs:Vector.<NumericStepper>;
		
		override protected function init(parameter : ShaderParameter,onUpdate:Function = null) : void {
			super.init(parameter, onUpdate);
			draw();
		}
		
		protected function draw() : void {
			_label = new Label(_container, 0, 0, _parameter.name);
			_width += 65 * _size;//60+hbox spacing
			_height += _label.height + _spacing;
			_inputs = new Vector.<NumericStepper>();
			for (var j : int = 0; j < _size; j++) {
				var hbox : HBox = new HBox(_container);
				for (var i : int = 0; i < _size; i++) {
					var input : NumericStepper = new NumericStepper(hbox, 60 * i, 20 * j, valueChanged);
					input.setSize(60, 20);
					input.value = int(i == j);
					input.name = String(input.value);
					_inputs.push(input);
				}
				_height += 20;
			}
			_inputs.fixed = true;
			graphics.lineStyle(1,0x990000,0);
			graphics.drawRect(0, 0, _width, _height);
		}
		override public function reset() : void {
			for (var i : int = 0; i < _numInputs; i++)	_inputs[i].value = int(_inputs[i].name);
		}

		override public function invalidate() : void {
			for (var i : int = 0; i < _numInputs; i++)	_inputs[i].dispatchEvent(_changeEvent);
		}

		override protected function valueChanged(event : Event = null) : void {
			for (var i : int = 0; i < _numInputs; i++) _value[i] = _inputs[i].value;	
			super.valueChanged();
		}
	}
}
