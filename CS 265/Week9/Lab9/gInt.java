// CS265 Lab 9
// Geoffrey Xiao
//
// gInt.java - Gaussian Integer class for Lab 9 Part 2: Junit
//
// Geoffrey Xiao
// 11/20/2016
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

public class gInt
{

	private int a; // real part
	private int b; // imaginary part

	// constructor
	public gInt( int r, int i )
	{
		this.a = r;
		this.b = i;
	}

   // constructor
	public gInt( int r )
	{
		this( r, 0 );
	}

	public boolean equals ( Object anObject ) // override equals method
	{

      if( anObject instanceof gInt ) {
      	gInt agInt = (gInt) anObject;
      	return agInt.real() == this.real() && agInt.imag() == this.imag();
		}
   	return false;
	
	}

	// real part of Gaussian integer
	public int real()
	{
		return this.a;
	}

	// imaginary part of Gaussian integer
	public int imag()
	{
		return this.b;
	}

	// this + rhs
	public gInt add( gInt rhs )
	{
		return new gInt( this.a + rhs.a, this.b + rhs.b );
	}

	// this - rhs
	public gInt sub( gInt rhs )
	{
		return new gInt( this.a - rhs.a, this.b - rhs.b );
	}

	// this * rhs
	public gInt multiply( gInt rhs )
	{
		return new gInt( this.a * rhs.a - this.b * rhs.b, 
				this.a * rhs.b + this.b * rhs.a );
	}

	// returns magntiude of the Gaussian integer
	public float norm()
	{
		return (float)Math.abs( Math.sqrt( a * a + b * b ) );
	}

}
