package com.disturbmedia.pb.utils {
	import flash.display.Shader;
	import flash.display.ShaderData;
	import flash.display.ShaderInput;
	import flash.display.ShaderParameter;
	/**
	 * @author George Profenza
	 */
	public class ShaderDataUtils {
		
		private var _shader:Shader;
		private var _data:ShaderData;
		private var _input:Vector.<ShaderInput>;
		private var _parameters:Vector.<ShaderParameter>;
		private var _metadata : ShaderMetaData;
		
		public function ShaderDataUtils(shader : Shader = null) {
			if (shader != null) init(shader);
		}

		private function init(shader : Shader) : void {
			_shader = shader;
			_data = _shader.data;
			_input = new Vector.<ShaderInput>();
			_parameters = new Vector.<ShaderParameter>();
			for (var prop:String in _data) {
				if (_data[prop] is ShaderInput) _input[_input.length] = _data[prop];
				else if (_data[prop] is ShaderParameter)  _parameters[_parameters.length] = _data[prop];  
			}
			_input.fixed = _parameters.fixed = true;
			_metadata = new ShaderMetaData(_data.name,_data.namespace,_data.vendor,_data.version,_data.description);
		}
		public function setShader(shader:Shader):void{
			init(shader);
		}

		public function getInput() : Vector.<ShaderInput> {
			return _input;
		}

		public function getParameters() : Vector.<ShaderParameter> {
			return _parameters;
		}

		public function getMetadata() : ShaderMetaData {
			return _metadata;
		}
		
	}
}