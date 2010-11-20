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
	
<a href="https://github.com/orgicus/PBGUI/blob/master/src/com/disturbmedia/pb/PBGUI.as">PBGUI.as</a> provides an extended example.

### Notes ###

Not all controls have been thoroughly tested, so watch out, here be bugs!
In case you run into any, plase provide details on the <a href="https://github.com/orgicus/PBGUI/issues">Issues</a> page.