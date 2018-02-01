/*
* Geoffrey Xiao, gx26
*   10/31/2016
* CS265 Lab 7, problem 2
*   Takes one integer command line argument. Determines if integer is even
*   or odd
*
* java version "1.8.0_111"
* Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
* Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
*
*/

public class prob2
{

	public static void main ( String [] args )
	{
		// Check arguments
		if( args.length == 0 )
		{
			System.out.println("No arguments!");
		}
		else
		{
			int i = Integer.parseInt( args[0] );
			
			// Is argument a number?
			if( (i % 2) == 0 )
			{
				System.out.printf("%d is even\n", i);
			}
			else
			{
				System.out.printf("%d is odd\n", i);
			}
		}
	}

}
