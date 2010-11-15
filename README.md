PBGUI
========

#### A Minimal Components GUI for Pixel Bender shaders ####

Pixel Bender shaders can be used in Photoshop, After Effects and Flash Player.
While Photoshop and After Effects provides a GUI, there are no helper GUI classes
for actionscript.

PBGUI generates a simple interface using <a href="http://minimalcomps.com/">Keith Peter's Minimal Comps</a>.

<!--
[More info...](http://disturbmedia.com/blog/)
-->

### Example: ###

[![lights_pointlights](http://orgicus.github.com/PBGUI/bin/pbgui.gif)](http://orgicus.github.com/PBGUI/pbgui.html)

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
	function onUpdate(name : String, value : Array) : void {
		shader.data[name].value = value;
		preview.loader.filters = [shaderFilter];
	}
	private function onReset():void{
		preview.loader.filters = [shaderFilter];	
	}
	private function onToggle(on:Boolean):void{
		preview.loader.filters = on ? [shaderFilter]:[];	
	}
	
PBGUI.as provides an extended example.