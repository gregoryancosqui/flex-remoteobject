package br.com.cricketdesign
{
	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	import mx.controls.ColorPicker;
	import mx.controls.ComboBox;
	import mx.controls.DateField;
	import mx.controls.NumericStepper;
	import mx.controls.RadioButton;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	
	import spark.components.CheckBox;
	import spark.components.ComboBox;
	import spark.components.NumericStepper;
	import spark.components.RadioButton;
	import spark.components.TextArea;
	import spark.components.TextInput;

	public class formUtil
	{
		private var arrData:ArrayCollection = new ArrayCollection();
		
		private const FIELD_TEXTINPUT:String = 'TextInput';
		private const FIELD_TEXTAREA:String = 'TextArea';
		private const FIELD_CHECKBOX:String = 'CheckBox';
		private const FIELD_COMBOBOX:String = 'ComboBox';
		private const FIELD_NUMERICSTEPPER:String = 'NumericStepper';
		private const FIELD_COLORPICKER:String = 'ColorPicker';
		private const FIELD_RADIOBUTTON:String = 'RadioButton';
		private const FIELD_DATEFIELD:String = 'DateField';
		
		public function formUtil(){}
		
		public function getData(obj:*):void{
			if(!obj) return;
			if(obj.numChildren){
				for(var i:uint=0; i<obj.numChildren;i++){
					try{
						getData(obj.getChildAt(i));
					}catch(e:Error){}
				}
			}
			
			//TextInput
			if(obj is spark.components.TextInput || obj is mx.controls.TextInput){this.setValue(obj, FIELD_TEXTINPUT);}
						
			//TextArea
			if(obj is spark.components.TextArea || obj is mx.controls.TextArea){this.setValue(obj, FIELD_TEXTAREA);}
			
			//CheckBox
			if(obj is mx.controls.CheckBox || obj is spark.components.CheckBox){this.setValue(obj, FIELD_CHECKBOX);}
						
			//ComboBox
			if(obj is spark.components.ComboBox || obj is mx.controls.ComboBox){this.setValue(obj, FIELD_COMBOBOX);}
			
			//NumericStepper
			if(obj is spark.components.NumericStepper || obj is mx.controls.NumericStepper){this.setValue(obj, FIELD_COMBOBOX);}
			
			//mx:ColorPicker
			if(obj is mx.controls.ColorPicker){this.setValue(obj, FIELD_COLORPICKER);}
			
			//radioButton
			if(obj is spark.components.RadioButton || obj is mx.controls.RadioButton){this.setValue(obj, FIELD_RADIOBUTTON);}
			
			//DateField
			if(obj is mx.controls.DateField){this.setValue(obj, FIELD_DATEFIELD);}
		}
		
		private function setValue(obj:*, type:String):Boolean{
			var objPHP:Object;
			objPHP = new Object();
			objPHP.id = obj.id;
			objPHP.name = obj.name;
			
			switch(type){
				case FIELD_COMBOBOX:
					objPHP.value = obj.selectedItem.data;
					break;
				case FIELD_CHECKBOX:
					objPHP.value = obj.selected;
					break;
				case FIELD_TEXTINPUT:
					objPHP.value = obj.text;
					break;
				case FIELD_TEXTAREA:
					objPHP.value = obj.text;
					break;
				case FIELD_COLORPICKER:
					objPHP.value = obj.selectedColor;
					break;
				case FIELD_NUMERICSTEPPER:
					objPHP.value = obj.value;
					break;
				case FIELD_RADIOBUTTON:
					objPHP.value = obj.selectedValue;
					break;
				case FIELD_DATEFIELD:
					objPHP.value = obj.text;
					break;
				default:
					objPHP.value = '';
			}
			objPHP.type = type;
			arrData.addItem(objPHP);
			return true;
		}
		
		public function getDados():ArrayCollection{
			return this.arrData;
		}
		
		public function clearForm(obj:*):void{
			if(!obj) return;
			if(obj.numChildren){
				for(var i:uint=0; i<obj.numChildren;i++){
					try{
						clearForm(obj.getChildAt(i));
					}catch(e:Error){}
				}
			}
			
			//TextInput
			if(obj is spark.components.TextInput || obj is mx.controls.TextInput){obj.text = '';}
			
			//TextArea
			if(obj is spark.components.TextArea || obj is mx.controls.TextArea){obj.text = '';}
			
			//CheckBox
			if(obj is mx.controls.CheckBox || obj is spark.components.CheckBox){obj.selected = false;}
			
			//ComboBox
			if(obj is spark.components.ComboBox || obj is mx.controls.ComboBox){obj.selectedIndex = 0;}
			
			//NumericStepper
			if(obj is spark.components.NumericStepper || obj is mx.controls.NumericStepper){obj.value = 0;}
			
			//mx:ColorPicker
			if(obj is mx.controls.ColorPicker){obj.selectedColor = 0xFFFFFF;}
			
			//radioButton
			/*if(obj is spark.components.RadioButton){this.setValue(obj, 'RadioButton');}
			if(obj is mx.controls.RadioButton){this.setValue(obj, 'RadioButton');}*/
			
			//DateField
			if(obj is mx.controls.DateField){obj.text = '';}
		}
		
		public function enabledForm(obj:*, enabled:Boolean):void{
			if(!obj) return;
			if(obj.numChildren){
				for(var i:uint=0; i<obj.numChildren;i++){
					try{
						enabledForm(obj.getChildAt(i), enabled);
					}catch(e:Error){}
				}
			}
			
			//TextInput
			if(obj is spark.components.TextInput || obj is mx.controls.TextInput){obj.enabled = enabled;}
			
			//TextArea
			if(obj is spark.components.TextArea || obj is mx.controls.TextArea){obj.enabled = enabled;}
			
			//CheckBox
			if(obj is mx.controls.CheckBox || obj is spark.components.CheckBox){obj.enabled = enabled;}
			
			//ComboBox
			if(obj is spark.components.ComboBox || obj is mx.controls.ComboBox){obj.enabled = enabled;}
			
			//NumericStepper
			if(obj is spark.components.NumericStepper || obj is mx.controls.NumericStepper){obj.enabled = enabled;}
			
			//mx:ColorPicker
			if(obj is mx.controls.ColorPicker){obj.enabled = enabled;}
			
			//radioButton
			if(obj is spark.components.RadioButton){obj.enabled = enabled;}
			if(obj is mx.controls.RadioButton){obj.enabled = enabled;}
			
			//DateField
			if(obj is mx.controls.DateField){obj.enabled = enabled;}
		}
		
		public function completeForm(obj:*, dados:ArrayCollection):void{
			
			if(!obj) return;
			if(obj.numChildren){
				for(var i:uint=0; i<obj.numChildren;i++){
					try{
						completeForm(obj.getChildAt(i), dados);
					}catch(e:Error){}
				}
			}
			
			//TextInput and TextArea
			if(obj is spark.components.TextInput || obj is mx.controls.TextInput || obj is spark.components.TextArea || obj is mx.controls.TextArea){
				for(var t:uint=0; t<dados.length;t++){
					if((dados.getItemAt(t).type == FIELD_TEXTINPUT || dados.getItemAt(t).type == FIELD_TEXTAREA) && dados.getItemAt(t).id == obj.id){
						obj.text = dados.getItemAt(t).value;
					}
				}
			}
			
						
			//CheckBox
			if(obj is mx.controls.CheckBox || obj is spark.components.CheckBox){
				for(var ck:uint=0; ck<dados.length;ck++){
					if(dados.getItemAt(ck).type == FIELD_CHECKBOX && dados.getItemAt(ck).id == obj.id){
						obj.selected = dados.getItemAt(ck).value;
					}
				}
			}
			
			//ComboBox
			if(obj is spark.components.ComboBox || obj is mx.controls.ComboBox){
				//obj.selectedIndex = 0;
				for(var i:uint=0; i<dados.length;i++){
					if(dados.getItemAt(i).type == FIELD_COMBOBOX && dados.getItemAt(i).id == obj.id){
						//obj.text = dados.getItemAt(i).value;
						var arrTemp:ArrayCollection = obj.dataProvider;
						for(var a:uint=0; a<arrTemp.length; a++){
							if(arrTemp.getItemAt(a).data == dados.getItemAt(i).value){
								obj.selectedIndex = a;
							}
						}
						
					}
				}
			}
			
			//NumericStepper
			if(obj is spark.components.NumericStepper || obj is mx.controls.NumericStepper){
				for(var n:uint=0; n<dados.length;n++){
					if(dados.getItemAt(n).type == FIELD_NUMERICSTEPPER && dados.getItemAt(n).id == obj.id){
						obj.value = dados.getItemAt(n).value;
					}
				}
			}
			
			//mx:ColorPicker
			if(obj is mx.controls.ColorPicker){
				for(var c:uint=0; c<dados.length;c++){
					if(dados.getItemAt(c).type == FIELD_COLORPICKER && dados.getItemAt(c).id == obj.id){
						obj.selectedColor = dados.getItemAt(c).value;
					}
				}
			}
			
			//radioButton
			/*if(obj is spark.components.RadioButton){this.setValue(obj, 'RadioButton');}
			if(obj is mx.controls.RadioButton){this.setValue(obj, 'RadioButton');}*/
			
			//DateField
			if(obj is mx.controls.DateField){
				for(var d:uint=0; d<dados.length;d++){
					if(dados.getItemAt(d).type == FIELD_DATEFIELD && dados.getItemAt(d).id == obj.id){
						obj.text = dados.getItemAt(d).value;
					}
				}
			}
			
		}
	}
}