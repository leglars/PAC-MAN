package {

	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.MovieClip;;
	import flash.net.Socket;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.Endian;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.text.TextFieldAutoSize;

	public class arduino extends MovieClip {

		private static const dataend: String = "$"; //定义一个结束字符，注意与arduino上一样
		private var _socket: Socket;
		private var _proxyAddress: String = "127.0.0.1";
		private var _proxyPort: uint = 5333;

		public function arduino() {
			// constructor code

			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage); //移除侦听

			//下面的程序是与arduino建立连接，如果连接上了怎么样，如果断了怎么样等等
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(Event.CLOSE, onClose);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData); //侦听有无来自端口的数据
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_socket.endian = Endian.LITTLE_ENDIAN;
			_socket.connect(_proxyAddress, _proxyPort);
		}
		//连接上了执行
		private function onConnect(event: Event): void {
			trace("Socket Connected"); //连接上就发送一个消息
		}
		private var buffer: String = ""; //定义一个字符串缓存字符
		//下面程序接受来自arduino的数据，一个字母一个字母接收的
		private function onSocketData(eventrogressEvent): void {
			var data: String = _socket.readUTFBytes(_socket.bytesAvailable);
			buffer += data; //把来自串口缓存的一个个字符拼接起来
			var msg: String; //再定义一个字符串变量来msg
			var index: int; //一个整形变量index来读取结束字符在buffer字符串中的位置
			while ((index = buffer.indexOf(dataend)) > -1) //如果读到了结束字符，也就是"$"
			{
				msg = buffer.substring(0, index); //msg就等于去掉了“$”后的字符串
				buffer = buffer.substring(index + 1); //另buffer等于结束字符串的后一位，以便下一个字符串的接受
				trace("Message Received from Arduino : " + msg); //测试时候用，输出以下msg的值
				//下面我们让它显示在文本框中  
			}
		}
		//下面定义关掉arduino时，显示Socket Closed
		private function onClose(event: Event): void {
			trace("Socket Closed");
		}
		//下面是出错时显示的消息的
		private function onIOError(event: IOErrorEvent): void {
			trace("IOErrorEvent : " + event.text);
		}
		//下面也是出错时的
		private function onSecurityError(event: SecurityErrorEvent): void {
			trace("SecurityErrorEvent : " + event.text);
		}

	}

}