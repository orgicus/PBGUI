package com.disturbmedia.pb.utils {
	/**
	 * @author George Profenza
	 */
	public class ShaderMetaData {
		
		private var _name:String;
		private var _namespace:String;
		private var _vendor:String;
		private var _version:Number;
		private var _description:String;
		
		public function ShaderMetaData(name : String, ns : String, vendor : String, version : Number, description : String) {
			_name = name;
			_namespace = ns;
			_vendor = vendor;
			_version = version;
			_description = description;
		}
		public function toString() : String {
			return "kernel " + _name + "\nnamespace: " + _namespace + "\nvendor: " + _vendor + "\nversion: " + _version + "\ndescription: " + _description;
		}
	}
}
