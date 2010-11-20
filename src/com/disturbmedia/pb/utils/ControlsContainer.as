package com.disturbmedia.pb.utils {
	import flash.geom.Rectangle;
	import flash.events.Event;
	import com.bit101.components.VSlider;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author George Profenza
	 */
	public class ControlsContainer extends Sprite {
		
		private var _maxHeight:Number;
		private var _totalHeight:Number = 0;
		private var _spacing:Number;
		private var _container:Sprite;
		private var _children:Vector.<Control>;
		private var _scroll:VSlider;
		private var _scrollRect:Rectangle;
		
		public function ControlsContainer(parent : DisplayObjectContainer, spacing : Number = 5, maxHeight : Number = 180) {
			init(parent, spacing, maxHeight);
		}

		private function init(parent : DisplayObjectContainer,spacing:Number,maxHeight:Number) : void {
			parent.addChild(this);
			_container = new Sprite();
			addChild(_container);
			_scrollRect = new Rectangle(0, 0, width, maxHeight);
			_spacing = spacing;
			_maxHeight = maxHeight;
			_children = new Vector.<Control>();
		}

		override public function addChild(child : DisplayObject) : DisplayObject {
			if(!(child is Control)) super.addChild(child);
			else {
				if (_container.numChildren > 0) {
					var prev : Control = _children[_container.numChildren - 1];
					child.y = prev.y + prev.getHeight() + _spacing;
				}
				var current : Control = child as Control;
				_children.push(current);
				_container.addChild(child);
				_totalHeight += current.getHeight() + _spacing;
				if (height > _maxHeight) {
					if (!_scroll) {
						_scroll = new VSlider(this, 0, _maxHeight, scrolled);
						_scroll.maximum = 1;
						_scroll.tick = 0.01;
						_scroll.setSize(_scroll.width, _maxHeight);
						_scroll.scaleY = -1;
					} else _scroll.x = _container.width - 20;
					_scrollRect.width = _container.width;
					_container.scrollRect = _scrollRect;
				}
			}
			return child;
		}

		public function getHeight() : Number {
			if (this.height < _maxHeight) return height;
			else return _maxHeight;	
		}

		private function scrolled(event : Event) : void {
			_scrollRect.y = (_totalHeight - _maxHeight) * _scroll.value;
			_container.scrollRect = _scrollRect;
		}
	}
}
