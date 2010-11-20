package com.disturbmedia.pb.utils {
	import com.bit101.components.ComboBox;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReferenceList;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;

	/**
	 * @author George Profenza
	 */
	public class ShaderSelector extends Sprite {
		private var _box : VBox;
		private var _label : Label;
		private var _browse : PushButton;
		private var _content : ComboBox;
		private var _loader:URLLoader;
		private var _onComplete:Function;
		
		private var _files:FileReferenceList;
		private var _filesNum:int;
		
		public function ShaderSelector() {
			init();
		}

		private function init() : void {
			_box = new VBox(this,10,10);
			_label = new Label(_box,0,0,"Shader Selector");
			_browse = new PushButton(_box,0,10,'browse shaders',selectFiles);
			_content = new ComboBox(_box, 0, 20, "select shader");
			_content.addEventListener(Event.SELECT, contentSelected);

			_files = new FileReferenceList();
			_files.addEventListener(Event.SELECT, filesSelected);
			
			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener(Event.COMPLETE, shaderLoaded);
		}

		private function shaderLoaded(event : Event) : void {
			try{
				if (_onComplete != null) _onComplete(event.target.data);
			} catch(error : ArgumentError) {
				trace(error.message);
			}
		}
		private function selectFiles(event:MouseEvent):void{
			_files.browse([new FileFilter("Shaders (*.pbj)", "*.pbj")]);
		}
		private function filesSelected(event:Event):void{
			_content.items = [];
			_filesNum = _files.fileList.length;
			for (var i : int = 0; i < _filesNum; i++) _content.items.push(_files.fileList[i].name);
			_content.selectedIndex = 0;
		}
		private function contentSelected(event : Event) : void {
			// _loader.load(new URLRequest('assets/' + _content.selectedItem));
			_files.fileList[_content.selectedIndex].load();
			if(!_files.fileList[_content.selectedIndex].hasEventListener(Event.COMPLETE)) _files.fileList[_content.selectedIndex].addEventListener(Event.COMPLETE,shaderLoaded);
		}

		public function set onComplete(callback : Function) : void {
			_onComplete = callback;
		}

	}
}
