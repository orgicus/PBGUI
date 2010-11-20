package com.disturbmedia.pb.utils {
	import flash.display.DisplayObject;
	import com.bit101.components.FPSMeter;
	import com.bit101.components.CheckBox;
	import flash.events.MouseEvent;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import com.bit101.components.VBox;
	import flash.display.ShaderParameter;
	import com.bit101.components.Window;
	import flash.display.Shader;
	import flash.display.Sprite;

	/**
	 * @author George Profenza
	 */
	public class ShaderControls extends Sprite {
		
		private var _shader : Shader;
		private var _utils : ShaderDataUtils;
		private var _onInit:Function;
		private var _onUpdate:Function;
		private var _onReset:Function;
		private var _onToggle:Function;
		private var _container : Window;
		private var _vbox:VBox;
		private var _numParams : uint;
		private var _controls : Vector.<Control>;
		private var _active : CheckBox;
		
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		public function ShaderControls(shader:Shader=null) {
			if(shader) init(shader);
		}
		private function init(shader : Shader) : void {
			_shader = shader;
			_utils = new ShaderDataUtils(_shader);
			// draw
			while(numChildren>0)removeChildAt(0);
			var width:Number = 0,height:Number = 10;
			_container = new Window(this, 0, 0, "Shader Parameters");
			_container.hasMinimizeButton = true;
			_vbox = new VBox(_container.content, 10, 10);
			_vbox.spacing = 5;
			_active = new CheckBox(_vbox, 0, 0, "activated", toggled);
			_active.selected = true;
			height += _active.height + _vbox.spacing;
			new FPSMeter(_container.titleBar, 120, 0).start();
			var reset : PushButton = new PushButton(_vbox, 0, 0, 'Reset to Defaults', resetAll);
			height += reset.height + _vbox.spacing;
			var details : TextArea = new TextArea(_vbox, 0, 0, _utils.getMetadata().toString());
			details.setSize(180, 100);
			details.editable = false;
			_vbox.addChild(details);
			if (details.width > width) width = details.width;
			height += details.height + _vbox.spacing;
			var params : Vector.<ShaderParameter> = _utils.getParameters();
			_numParams  = params.length;
			var className:String;
			var UIClass:Class;
			var control : Control;
			var controlsContainer:ControlsContainer = new ControlsContainer(_vbox);
			_controls = new Vector.<Control>(_numParams,true);
			for (var i : int = 0; i < _numParams; i++) {
				className = "com.disturbmedia.pb.utils." + params[i].type.substr(0, 1).toUpperCase() + params[i].type.substr(1).toLowerCase() + "Control";
				UIClass = getDefinitionByName(className) as Class;
				control = new UIClass() as Control;
				control.setup(params[i]);
				if (_onUpdate != null) control.onUpdate = _onUpdate;
				_controls[i] = control;
				controlsContainer.addChild(control);
			}
			height += controlsContainer.getHeight();
			if(controlsContainer.width > width) width = controlsContainer.width;
			height += _container.titleBar.height + _vbox.spacing;
			_width = width;
			_height = height;
			_vbox.draw();
			_container.setSize(_width, _height);
			graphics.clear();
			graphics.lineStyle(1,0x009900,0);
			graphics.drawRect(0, 0,_width, _height);
			
			if(_onInit != null) _onInit();
		}
		public function getWidth():Number{
			return _width;
		}
		public function getHeight():Number{
			return _height;
		}
		private function resetAll(event:MouseEvent = null):void{
			for (var i : int = 0; i < _numParams; i++) {
				_controls[i].reset();
				_controls[i].invalidate();
			}
			if (_onReset != null) _onReset();
		}

		private function toggled(event : Event) : void {
			if (_onToggle != null) _onToggle(_active.selected);
		}
		public function set onInit(callback:Function):void{
			_onInit = callback;
		}

		public function set onUpdate(callback: Function) : void {
			_onUpdate = callback;
			for (var i : int = 0; i < _numParams; i++) {
				_controls[i].onUpdate = callback;
			}
		}

		public function set onReset(callback: Function) : void {
			_onReset = callback;
		}

		public function set onToggle(toggleCallback: Function) : void {
			_onToggle = toggleCallback;
		}

		public function setShader(shader : Shader) : void {
			init(shader);
		}
		public function bringToFront():void{
			if(parent) parent.addChild(this);
		}
		/*FDT_IGNORE*/
		private function stub():void{
			var f:FloatControl;	
			var f2:Float2Control;	
			var f3:Float3Control;	
			var f4:Float4Control;	
			var i:IntControl;	
			var i2 :Int2Control;
			var i3:Int3Control;	
			var i4 : Int4Control;
			var m2:Matrix2x2Control;
			var m3:Matrix3x3Control;
			var m4:Matrix4x4Control;
		}
		/*FDT_IGNORE*/
	}
}
