package controller.Class
{
	/*
	 **Classe responsável para a conexão com o AMFPHP
	 **@Autor: Gregory Ancosqui
	 **@Data: 07/07/2010
	 **@Versão: 1.1 
	 */
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.ArrayUtil;

	public class Conn {
		
		public static const TYPE_ARRAY_COLLECTION:uint = 0;
		public static const TYPE_STRING:uint = 1;
		
		private var Manipula:RemoteObject = new RemoteObject("amfphp");
		private var temp:String;
		private var evento:String;
		private var tipo:int;
		private var retornoString:String;
		
		[Bindable]private var arrDados:ArrayCollection;
		
		//método construtor da classe, registra a classe do php que será utilizada
		public function Conn(classe:String) {
			Manipula.source = classe;
			Manipula.addEventListener(FaultEvent.FAULT, erro);
		}
		
		//método responsável por enviar erro caso a requisição ao server seja mal sucedida
		private function erro(fault:FaultEvent):void {
			Manipula.removeEventListener(FaultEvent.FAULT,erro);
			CursorManager.removeBusyCursor();
			//Alert.show(fault.fault.faultString, fault.fault.faultCode.toString());
		}
		
		//método responsável por executar um método no server
		public function exec(metodo:String,evento:String,tipo:int=0,param:Array=null):void {
			CursorManager.setBusyCursor();
			this.temp = metodo;
			this.evento = evento;
			this.tipo = tipo;
			var arg:String=null;
			var calc:uint = 0;
			if(param != null) {
				calc = param.length;
				arg = '1';
			}
			
			//adiciona um evento para o resultado da requisição
			if(this.tipo == 1) {
				Manipula.getOperation(this.temp).addEventListener(ResultEvent.RESULT, this.getReturnString);
			} else {
				Manipula.getOperation(this.temp).addEventListener(ResultEvent.RESULT, this.getReturn);
			}
						
			//verifica se existe argumentos e faz a requisição ao server
			if(arg != null) {
				Manipula.getOperation(this.temp).arguments = param;
			}
			Manipula.getOperation(this.temp).send();
		}
				
		/*método que retorna um array collection bindable dos dados do servidor*/
		private function getReturn(evt:ResultEvent):void{
			CursorManager.removeBusyCursor();
			if(evt.result != null) {
				if(evt.result.length < 0) {
					this.arrDados = evt.result.data;
				} else {
					this.arrDados = new ArrayCollection(ArrayUtil.toArray(evt.result));
				}
			} else {
				this.arrDados.removeAll();
			}
			
			Manipula.getOperation(this.temp).removeEventListener(ResultEvent.RESULT,getReturn);
			this.temp = null;
			this.disparaEvento();
		}
		
		// pega o resultado do php e atribui a uma variavel
		private function getReturnString(evt:ResultEvent):void {
			CursorManager.removeBusyCursor();
			this.retornoString = evt.result.toString();
			Manipula.getOperation(this.temp).removeEventListener(ResultEvent.RESULT,getReturnString);
			this.temp = null;
			this.disparaEvento();
		}
		
		private function disparaEvento():void {
			dispatchEvent(new Event(this.evento));
		}
		
		// Retorna um arrayCollection com os dados do php
		public function getArrDados():ArrayCollection {
			return this.arrDados;
		}
		
		// Retorna uma string do php
		public function getDados():String{
			return this.retornoString;
		}
	}
}