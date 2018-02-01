// Csv.java - Java implementation of Csv interface
//
// Geoffrey Xiao
// 11/11
//
// java version "1.8.0_111"
// Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
// Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
// Distributor ID: Ubuntu
// Description:    Ubuntu 16.04.1 LTS
// Release:        16.04
// Codename:       xenial
//
// EDITOR:  tabstop=2, cols=80
//
// NOTES:
// 	Records will be separated by EOL (so, on *nix, the newline character)
//		Fields are separated by commas
//		A field may contain commas, if it is quoted using double-quotes
//		A field is quoted if the first non-blank character is a double-quote
//		Leading and trailing space will be removed from each field, unless that
//		space is inside a quoted string
//		Double-quotes may appear inside quoted fields; they must be escaped with
//		another double-quote.
//
// Uses algorithm developed by Brian Kernighan in The Practice of Programming
//

import java.util.*;
import java.io.*;

public class Csv
{

	private BufferedReader reader; // input file reader
	private String line; // input line
	private ArrayList<String> field; // field strings
	int nfield; //number of fields
	private String fieldsep; // seperator characters

	public Csv( BufferedReader br, String sep) // constructor
	{
		this.reader = br;
		this.fieldsep = sep;
	}	

	// returns null, if reached EOF
	// gets line of the csv file
	public String getline()
	{
		try
		{
			this.line = (this.reader).readLine();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if( line != null )
			this.split(); // create fields
		return this.line; // will be null if EOF	
	}

	// returns the String in the field if it exists, otherwise returns null
	public String getfield( int n )
	{
		if( n >= 0 && n < field.size() )
			return (this.field).get( n );
		else
			return null;
	}

	// number of fields in the line
	public int getnfield()
	{
		return this.nfield;
	}

	// split line into fields
	// Use algorithm developed in csvgetline.cc
	private int split()
	{
		int i, j;
		this.nfield = 0;

		field = new ArrayList<String>();

		// empty line
		if( (this.line).length() == 0 )
			return 0;

		i = 0;
		line = line.trim(); // remove leading and trailing whitespace
		
		// The C++ algorithm works with C Strings which are terminated by '\0'
		line = line + Character.toString(Character.MIN_VALUE);		

		do
		{
			// quoted 
			if( i < (this.line).length() && (this.line).charAt(i) == '"' )
			{
				j = advquoted( this.line, ++i ); 
			}	
			// not quoted
			else
			{
				j = advplain( this.line, i );
			}
			this.nfield++;
			i = j + 1;
		} while ( j < (this.line).length() );

		return this.nfield;	
	}

	// for quoted fields
	// return index of next seperator, adds field to field ArrayList
	private int advquoted( String s, int i )
	{
		int j;
		String fld = "";
		for( j = i; j < s.length(); j++ )
		{
			// quote enclosed
			if( s.charAt(j) == '"' && s.charAt(++j) != '"' ) // not ""
			{
				int k = s.indexOf( this.fieldsep, j ); // search string for fieldsep
				if( k < 0 ) // not found, -1 is returned
					k = s.length();
				for( k -= j; k-- > 0; ) // Create the field
				{	
					fld += Character.toString( s.charAt(j++) );
				}
				break;
			}
			fld += Character.toString( s.charAt(j) ); // "" -> " in the field
		}
		(this.field).add(fld.trim()); // add to field ArrayList, trim whitespace
		return j;
	}

	// for unquoted fields
	// return index of next seperator, adds field to field ArrayList
	private int advplain( String s, int i )
	{
		String fld = "";
		int j;

		j = s.indexOf( this.fieldsep, i ); 
		if( j < 0 ) // not found, -1 is returned
			j = s.length();
		fld = s.substring( i, j );
		(this.field).add(fld.trim()); // add to field ArrayList, trim whitespace
		return j;
	}

	// test driver
	public static void main( String [] args )
	{
		try 
		{
			// Input file is "test.csv"
			BufferedReader reader = new BufferedReader( new FileReader( "test.csv") );

     	 	Csv csv = new Csv( reader, "," );
      	String line;

			// Read all lines in the file
      	while( (line = csv.getline()) != null )
      	{
         	System.out.println( "line = '" + line + "'" );
         	for( int i = 0; i < csv.getnfield(); i++ )
        	 	{
           		System.out.println( "\tfield[" + i + "] = '" + csv.getfield(i) + "'" );
         	}
	      }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	
	}

}
