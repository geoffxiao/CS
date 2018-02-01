/* 
* Geoffrey Xiao, gx26
*   10/31/2016
* CS265 Lab 7, problem 1
* 	 Takes one command line argument. Prints that argument 100 times.
* 
* java version "1.8.0_111"
* Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
* Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
*
*/
public class prob1
{
	static int HUNDRED = 100; 
	
	public static void main ( String args [] )
	{
		// Argument checking
		if(args.length == 0)
		{
			System.out.println("No argument passed!");
		}

		// Loop to print the argument one hundred times
		else
		{
			for(int i = 0; i < HUNDRED; i++)
			{
				System.out.printf("%s ", args[0]);
			}
			System.out.print("\n");
		}
	}
}
