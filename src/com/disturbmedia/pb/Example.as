package com.disturbmedia.pb {
	import com.disturbmedia.pb.utils.ShaderControls;

	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.ShaderFilter;

	/**
	 * @author George Profenza
	 * 
	 * This example shows how you would the ShaderControls in a project.
	 * PBGUI.as is there to easily load assets, kernels and test them, outsite your project
	 * 
	 * The goal of this project is to generate a GUI for your PixelBender shaders
	 * that you can hook up to your project. This is achieved through the ShaderControls class and it's callbacks
	 * 
	 * ShaderControls draws a draggable window which can be minimized so you can view your project easily
	 * Maximize the window when you want to use the shader controls
	 */
	public class Example extends Sprite {

		[Embed(source="../bin/assets/kernels/Bloom.pbj", mimeType="application/octet-stream")]  
		private var ShaderClass : Class;
		private var shader:Shader;
		private var shaderFilter:ShaderFilter;
		
		[Embed(source="../bin/assets/images/Canyonlands.png")]
		private var ImageClass:Class;		
		private var preview:DisplayObject;
		private var controls:ShaderControls;
		
		public function Example() {
			init();
		}

		private function init() : void {
			preview = new ImageClass();
			addChild(preview);//add some content you want to preview the filter on
			
			//intialize the filter
			shader = new Shader(new ShaderClass());
			shaderFilter = new ShaderFilter(shader);
			
			//intialize the controls
			controls = new ShaderControls(shader);
			controls.onUpdate = updateFilter;
			controls.onToggle = toggleFilter;
			controls.onReset = applyFilter;
			addChild(controls);	
		}
		//update the shader and re-apply the filter. The callback returns the name of the changed parameter and the values array
		private function updateFilter(name : String, value : Array) : void {
			shader.data[name].value = value;
			preview.filters = [shaderFilter];
		}
		//This is called when the "activated" checkbox is toggled
		private function toggleFilter(on:Boolean) : void {
			preview.filters = on ? [shaderFilter] : [];
		}
		//This is called when the "Reset to Defaults" button is pressed
		private function applyFilter() : void {
			preview.filters = [shaderFilter];
		}
	}
}
