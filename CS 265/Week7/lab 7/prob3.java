/*
* Geoffrey Xiao, gx26
*   10/31/2016
* CS265 Lab 7, problem 3
*   Takes one integer command line argument. Determines if integer is a
*   leap year.
*
* java version "1.8.0_111"
* Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
* Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
*
*/

public class prob3
{

	public static void main ( String args [] )
	{
		// Insufficient arguments	
		if( args.length == 0 )
		{
			System.out.println("No year argument passed.");		
		}
		else
		{
			int year = Integer.parseInt( args[0] );	

			// leap year if divisible by 4
				// unless divisible by 100
					// unless divisble by 400
			if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) 
			{
				System.out.println( year + " is a leap year." );
			}
			else
			{
				System.out.println( year + " is not a leap year." );
			}
		}
	}

}

