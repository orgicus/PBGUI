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
		private var ShaderClass : Class;
		private var shader : Shader;
		private var controls:ShaderControls;
		private var preview : ShaderPreview;
		private var shaderFilter : ShaderFilter;
		private var selector : ShaderSelector;
		
		public function PBGUI() {
			loaderInfo.addEventListener(Event.COMPLETE,init);
		}

		private function init(event:Event = null) : void {
			shader = new Shader(new ShaderClass());
			controls = addChild(new ShaderControls(shader)) as ShaderControls;
			controls.onToggle = onToggle;
			controls.onUpdate = onUpdate;
			controls.onReset = onReset;
			preview = addChild(new ShaderPreview()) as ShaderPreview;
			preview.x = 220;
			selector = addChild(new ShaderSelector()) as ShaderSelector;
			selector.y = 350;
			selector.onComplete = onComplete;
			
			shaderFilter = new ShaderFilter(shader);
			preview.loader.filters = [shaderFilter];
		}

		private function onUpdate(name : String, value : Array) : void {
			shader.data[name].value = value;
			preview.loader.filters = [shaderFilter];
		}
		private function onReset():void{
			preview.loader.filters = [shaderFilter];	
		}
		private function onToggle(on:Boolean):void{
			preview.loader.filters = on ? [shaderFilter]:[];	
		}

		private function onComplete(data : ByteArray) : void {
			shader = new Shader(data);
			shaderFilter = new ShaderFilter(shader);
			preview.loader.filters = [shaderFilter];
			controls.setShader(shader);
		}
	}
}
