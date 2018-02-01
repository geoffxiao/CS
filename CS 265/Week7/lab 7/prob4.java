/*
* Geoffrey Xiao, gx26
*   10/31/2016
* CS265 Lab 7, problem 4
*  Accepts an integer between 0 and 3. 
*		0: number of milliseconds since Jan. 1, 1970
*		1: number of seconds since Jan. 1, 1970
*		2: number of days since Jan. 1, 1970
* 		3: current date and time
*
* java version "1.8.0_111"
* Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
* Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
*
*/

import java.util.Date;
import java.text.DateFormat;
import java.util.concurrent.TimeUnit;

public class prob4
{

	public static void main ( String args [] )
	{
		if( args.length > 0 )
		{
	
			Date now = new Date(); // The date now
			long diff = now.getTime(); // time in ms since Jan. 1, 1970
			
			switch( Integer.parseInt(args[0]) )
			{
				case 0: // milliseconds
					System.out.printf("Milliseconds since January 1, 1970: %d\n",
							diff);
					break;

				case 1: // seconds
					diff = TimeUnit.SECONDS.convert(diff, TimeUnit.MILLISECONDS);
					System.out.printf("Seconds since January 1, 1970: %d\n", diff);
					break;
				
				case 2: // days
					diff = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
					System.out.printf("Days since January 1, 1970: %d\n", diff);
					break;

				case 3: // current data and time
					DateFormat dateFormat = DateFormat.getDateTimeInstance();
					System.out.println("Current date and time: " +
							dateFormat.format(now));
					break;

				default:
					System.out.println("Please pass an integer between 0 and 3.");
					break;
			}
		}
		else
		{
			System.out.println("Insufficient arguments.");	
		}	
	
	}

}
