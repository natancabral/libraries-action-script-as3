package GNNC.data.validator
{
	import mx.validators.Validator;

	public class gnncValidatorRg extends Validator
	{
		public function gnncValidatorRg()
		{
			/*
			
			http://www.profcardy.com/artigos/rg.php
			
			a b . c d e . f g h i
			x2 x3 x4 x5 x6 x7 x8 x9 x100
			= A = B = C = D = E = F = G = H = I
			Total = A + B + C + D + E + F + G + H + I
			Sendo o número do RG válido o Total deverá ser divisível por 11 
			(ou seja, se dividir por onze o resto será zero).
			
			*/
		}
	}
}