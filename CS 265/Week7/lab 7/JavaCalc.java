import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Stack;
import java.util.StringTokenizer;

public class JavaCalc
{

	public JavaCalc()
	{}

	public void processFile( String file ) // process file
	{
		try
		{	
			BufferedReader br = new BufferedReader( new FileReader(file) );
   		for( String infix; (infix = br.readLine()) != null; ) 
			{
				infix = infix + " )";
				ArrayList<Token> postfix = makePostfix( infix );
				System.out.println( printPostfix( postfix ) );
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();	
		}
	}

	public ArrayList<Token> makePostfix( String infix )
	{
		ArrayList<Token> postfix = new ArrayList<Token>(); // Contains postfix
		Stack<Operator> stack = new Stack<Operator>(); // Stack for the algorithm
		stack.push( toOperator("(") );

		StringTokenizer st = new StringTokenizer( infix );
      
		while( st.hasMoreTokens() )		
		{
			String tok = st.nextToken();	
			if( isInteger(tok) ) // Operand
			{
				postfix.add( new Operand( Integer.parseInt(tok) ) );
			}
			else // Operator, LPAR, or RPAR
			{
				Operator opScan = toOperator( tok );
				if( opScan.getVal() == opType.LPAR )
				{
					stack.push( opScan );
				}
				else if( opScan.getVal() == opType.RPAR )
				{
					while( (stack.peek()).getVal() != opType.LPAR )
					{
						postfix.add( stack.pop() );
					}
					stack.pop(); // remove and discad LPAR
				}
				else // Operator
				{
					while( Operator.compare(opScan, stack.peek()) >= 0 &&
							 (stack.peek()).getVal() != opType.LPAR &&
							 (stack.peek()).getVal() != opType.RPAR )
					{
						postfix.add( stack.pop() );
					}
					stack.push( opScan );
				}
			}
		}

		return postfix;

	}

	public String printPostfix( ArrayList<Token> postfix )
	{
		String out = "";
      for(int i = 0; i < postfix.size(); i++)	      
		{		
		  	out += postfix.get(i) + " ";		
		}

		return out;
	
	}

	private boolean isInteger( String str )
	{
		// Nothing in string
      if( str.length() < 1 )
      	return false;

      for( int i = 0; i < str.length(); i++ )
		{
      	char c = str.charAt(i);
         if( !Character.isDigit(c) )
				return false;
		}
      return true;
	}

	private Operator toOperator( String token )
	{
		switch( token )
		{
			case "+":
				return new Operator( opType.ADD );
			case "-":
				return new Operator( opType.SUB );
			case "*":
				return new Operator( opType.MULT );
			case "/":
				return new Operator( opType.DIV );
			case "%":
				return new Operator( opType.MOD );
			case "(":
				return new Operator( opType.LPAR );
			case ")":
				return new Operator( opType.RPAR );
		}
		return null;
	}

}
