package com.disturbmedia.pb.utils {
	import com.bit101.components.ComboBox;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReferenceList;

	/**
	 * @author George Profenza
	 */
	public class ShaderPreview extends Sprite {
		private var _box : VBox;
		private var _label : Label;
		private var _browse : PushButton;
		private var _content : ComboBox;
		private var _loader:Loader;
		
		private var _files:FileReferenceList;
		private var _filesNum:int;
		
		public function ShaderPreview() {
			init();
		}

		private function init() : void {
			_box = new VBox(this,10,10);
			_label = new Label(_box,0,0,"Shader Preview");
			_browse = new PushButton(_box,0,10,'browse content',selectFiles);
			_content = new ComboBox(_box, 0, 20, "select content");
			_content.addEventListener(Event.SELECT, contentSelected);

			_files = new FileReferenceList();
			_files.addEventListener(Event.SELECT, filesSelected);
			
			_loader = new Loader();
			_box.addChild(_loader);
		}
		
		private function selectFiles(event:MouseEvent):void{
			_files.browse([new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png"),new FileFilter("Flash Video(*.flv, *.f4v)", "*.flv;*.f4v"),new FileFilter("Flash Content(*.swf, *.spl)", "*.swf;*.swf")]);
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
			if(!_files.fileList[_content.selectedIndex].hasEventListener(Event.COMPLETE)) _files.fileList[_content.selectedIndex].addEventListener(Event.COMPLETE,contentLoaded);
		}

		private function contentLoaded(event : Event) : void {
			_loader.loadBytes(event.target.data);
		}

		public function get loader() : Loader {
			return _loader;
		}
	}
}