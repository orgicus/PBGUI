package com.disturbmedia.pb.utils {
	import flash.display.ShaderParameter;
	/**
	 * @author George Profenza
	 */
	public class Matrix4x4Control extends Matrix2x2Control {
		override protected function init(parameter : ShaderParameter, onUpdate : Function = null) : void {
			_size = 4;
			_numInputs = _size*_size;
			super.init(parameter, onUpdate);
		}
	}
}