package com.disturbmedia.pb {
	import com.disturbmedia.pb.utils.ShaderControls;
	import com.disturbmedia.pb.utils.ShaderPreview;
	import com.disturbmedia.pb.utils.ShaderSelector;

	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;

	/**
	 * @author George Profenza
	 */
	public class PBGUI extends Sprite {
		
		[Embed(source="../bin/assets/kernels/PolarFP.pbj", mimeType="application/octet-stream")]  
		private var _ShaderClass : Class;
		private var _shader : Shader;
		private var _controls:ShaderControls;
		private var _preview : ShaderPreview;
		private var _shaderFilter : ShaderFilter;
		private var _selector : ShaderSelector;
		
		public function PBGUI() {
			loaderInfo.addEventListener(Event.COMPLETE,init);
		}

		private function init(event : Event = null) : void {
			_selector = addChild(new ShaderSelector()) as ShaderSelector;
			_selector.onComplete = onComplete;
			_preview = addChild(new ShaderPreview()) as ShaderPreview;
			
			_shader = new Shader(new _ShaderClass());
			_controls = addChild(new ShaderControls()) as ShaderControls;
			_controls.onInit = layout;
			_controls.onToggle = onToggle;
			_controls.onUpdate = onUpdate;
			_controls.onReset = onReset;
			_controls.setShader(_shader);
						
			_shaderFilter = new ShaderFilter(_shader);
			_preview.loader.filters = [_shaderFilter];
		}

		private function onUpdate(name : String, value : Array) : void {
			_shader.data[name].value = value;
			_preview.loader.filters = [_shaderFilter];
		}
		private function onReset():void{
			_preview.loader.filters = [_shaderFilter];	
		}
		private function onToggle(on:Boolean):void{
			_preview.loader.filters = on ? [_shaderFilter]:[];	
		}
		private function onComplete(data : ByteArray) : void {
			_shader = new Shader(data);
			_shaderFilter = new ShaderFilter(_shader);
			_preview.loader.filters = [_shaderFilter];
			_controls.setShader(_shader);
		}
		private function layout():void{
			_selector.y = int(_controls.getHeight());
			_preview.x = int(_controls.getWidth());
		}

		public function get controls() : ShaderControls {
			return _controls;
		}

		public function get preview() : ShaderPreview {
			return _preview;
		}

		public function get selector() : ShaderSelector {
			return _selector;
		}
		
	}
}
