package project.utils
{
	import com.hurlant.crypto.symmetric.BlowFishKey;
	import com.hurlant.crypto.symmetric.ECBMode;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.PKCS5;
	import com.hurlant.util.Base64;
	
	import flash.utils.ByteArray;

	public class Blowfish
	{
		static public function encrypt($text:String, $key:String=""):String
		{
			
			try
			{				
				$key = Base64.encode($key);

				
				var $output:ByteArray = new ByteArray();
				$output.writeUTFBytes($text);
				var $pad:IPad = new PKCS5(8);
				var $cipher:ICipher = _getCipher( $key, $pad );
				$pad.setBlockSize( $cipher.getBlockSize() );
				$cipher.encrypt( $output );
				$cipher.dispose();
				return Base64.encodeByteArray( $output );
			}
			catch ($error:Error)
			{
				trace("An encryption error occured.");
			}
			return null;

		}

		
//		static public function decrypt($text:String, $key:String=""):String
//		{
//			try
//			{
//				$key = Base64.encode($key);
//				
//				var $input:ByteArray = Base64.decodeToByteArray( $text );
//				var $pad:IPad = new PKCS5();
//				var $cipher:ICipher = _getCipher( $key, $pad );
//				$pad.setBlockSize( $cipher.getBlockSize() );
//				$cipher.decrypt( $input );
//				$cipher.dispose();
//				$input.position = 0;
//				return $input.readUTF();
//			}
//			catch ($error:Error)
//			{
//				trace("A decryption error occured.");
//			}
//			return null;
//		}
		

		private static function _getCipher( $key:String, $pad:IPad ):ICipher 
		{
			return new ECBMode( new BlowFishKey(Base64.decodeToByteArray( $key )), $pad );
		}
	}
}