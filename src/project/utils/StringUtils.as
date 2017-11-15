package project.utils 
{

	public class StringUtils 
	{

		public static function multiForm(number:Number, word1:String, word2:String, word3:String):String
		{
			
			if (number != Math.round (number)) return word2;	
			if (number >= 10 && number <=20) return word3;	
			else 
			{
				number = number % 10;	
				switch (number){
					case 1:
						return word1;
						break;			
					case 2:
					case 3:
					case 4:
						return word2;
						break;			
					case 5:
					case 6:
					case 7:
					case 8:
					case 9:
					case 0:
						return word3;
						break;
				}
			}
			return '';
		}
		
	}
	
}