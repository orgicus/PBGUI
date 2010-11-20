PBGUI
========

#### A Minimal Components GUI for Pixel Bender shaders ####

Pixel Bender shaders can be used in Photoshop, After Effects and Flash Player.
While Photoshop and After Effects provides a GUI, there are no helper GUI classes
for actionscript.

PBGUI generates a simple interface using <a href="http://minimalcomps.com/">Keith Peters' Minimal Comps</a>.

Most of the sample images ship with Pixel Bender by default.
For more Pixel Bender shaders checkout the <a href="http://www.adobe.com/cfusion/exchange/index.cfm?event=productHome&exc=26">Pixel Bender Exchange</a>

[More info...](http://disturbmedia.com/blog/post/pbgui-a-minimal-actionscript-ui-for-pixel-bender-shaders/)


### Example: ###

[![PBGUI](https://github.com/orgicus/PBGUI/raw/master/bin/pbgui.gif)](http://orgicus.github.com/PBGUI/bin/pbgui.html)

### Usage ###

While the PBGUI class provides a basic example of Pixel Bender parameters + a means to load shaders and images
for preview, the aim is to provide a simple class that draws a GUI and handles input for shaders.
This is achieved using the ShaderControls class:

	//shader is a reference to an initialized Shader instance
	var controls:ShaderControls = new ShaderControls(shader);
	addChild(controls);
	//changes are handled through callbacks
	controls.onToggle = onToggle;
	controls.onUpdate = onUpdate;
	controls.onReset = onReset;
	
	//name = shader parameter name and value is the array of values for the updated parameter
	//preview = a DisplayObject used for previewing/applying the filters
	function onUpdate(name : String, value : Array) : void {
		shader.data[name].value = value;
		preview.loader.filters = [shaderFilter];
	}
	function onReset():void{
		preview.loader.filters = [shaderFilter];	
	}
	function onToggle(on:Boolean):void{
		preview.loader.filters = on ? [shaderFilter]:[];	
	}
	
Here is an expanded <a href="https://github.com/orgicus/PBGUI/blob/master/src/com/disturbmedia/pb/Example.as">example</a> :	

	package {
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

### Notes ###

Not all controls have been thoroughly tested, so watch out, here be bugs!
In case you run into any, plase provide details on the <a href="https://github.com/orgicus/PBGUI/issues">Issues</a> page.

### Changes ###

* tested controls - added VarTest kernel to test parameters
* added ControlsContainer - if your filter has A LOT of parameters, you can set a maximum height for the controls area(default is 180)
anything larger is accessed through scrolling. Use browse filter and VarTest.pbj to see this.