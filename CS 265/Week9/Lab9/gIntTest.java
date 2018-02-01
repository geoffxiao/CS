// CS265 Lab 9
// Geoffrey Xiao
//
// gIntTest.java - JUnit test site for the gInt class
//
// Geoffrey Xiao
// 11/20/2016
//
// junit version 3.8.2
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

import junit.framework.*;

public class gIntTest extends TestCase
{

	private gInt real1_imag1; // real = 1, imag = 1; 1 + i
	private gInt real0_imag1; // 0 + i
	private gInt real1_imag0; // 1
	private gInt realn1_imagn1; // real = -1, imag = -1; -1 - i

	public gIntTest ( String name )
	{
		super( name );
	}

	// Run before every test
	protected void setUp()
	{
		real1_imag1 = new gInt(1, 1);
		real0_imag1 = new gInt(0, 1);
		real1_imag0 = new gInt(1, 0);
		realn1_imagn1 = new gInt(-1, -1);
	}

	// run after every test
	protected void tearDown()
	{
		// Nothing to add here
	}

	public static Test suite()
	{
		TestSuite suite = new TestSuite();
		suite.addTest( new gIntTest( "testAddition" ) );
		suite.addTest( new gIntTest( "testSubtraction" ) );
      suite.addTest( new gIntTest( "testMultiplication" ) );
		suite.addTest( new gIntTest( "testEquals" ) );
		suite.addTest( new gIntTest( "testReal" ) );
		suite.addTest( new gIntTest( "testImag" ) );
		suite.addTest( new gIntTest( "testNorm" ) );
		return suite;
	}

	// testing the add() method of gInt class
	public void testAddition()
	{
		gInt expected_real0_imag0 = new gInt(0, 0);
		gInt expected_real2_imag1 = new gInt(2, 1);
		gInt expected_real1_imag2 = new gInt(1, 2);

		// Testing constructor, make sure object created
		assertNotNull( expected_real0_imag0 );
		assertNotNull( expected_real2_imag1 );
		assertNotNull( expected_real1_imag2 );

		gInt result_real0_imag0 = real1_imag1.add(realn1_imagn1); // (1 + i) + (-1 - i)
		gInt result_real2_imag1 = real1_imag1.add(real1_imag0); // (1 + i) + (1)
		gInt result_real1_imag2 = real1_imag1.add(real0_imag1); // 1 + (1 + i)

		// Test if results equal expected
		assertEquals(expected_real0_imag0, result_real0_imag0);
		assertEquals(expected_real2_imag1, result_real2_imag1);
		assertEquals(expected_real1_imag2, result_real1_imag2);
	}

	// testing the sub() method of gInt class
	public void testSubtraction()
	{
		gInt expected_real1_imag0 = new gInt(1, 0);
		gInt expected_real0_imag1 = new gInt(0, 1);
		gInt expected_real2_imag2 = new gInt(2, 2);

		// Testing constructor, make sure object created
		assertNotNull( expected_real1_imag0 );
		assertNotNull( expected_real0_imag1 );
		assertNotNull( expected_real2_imag2 );

		// Test if results equal expected
		gInt result_real1_imag0 = real1_imag1.sub( real0_imag1 ); // (1 + i) - (i)
		gInt result_real0_imag1 = real1_imag1.sub( real1_imag0 ); // (1 + i) - (1)
		gInt result_real2_imag2 = real1_imag1.sub( realn1_imagn1 ); // (1 + i) - (-1 - i)

		assertEquals( expected_real1_imag0, result_real1_imag0 );
		assertEquals( expected_real0_imag1, result_real0_imag1 );
		assertEquals( expected_real2_imag2, result_real2_imag2 );
	}

	// Test the multiply() method of gInt class
	public void testMultiplication()
	{
		gInt expected_real0_imag2 = new gInt(0, 2); // (1 + i) * (1 + i)
		gInt expected_realn1_imag1 = new gInt(-1, 1); // (1 + i) * (i)
		gInt expected_real1_imag1 = new gInt(1, 1); // (1 + i) * (1)
		
		// Testing constructor, make sure object created
		assertNotNull( expected_real0_imag2 );
		assertNotNull( expected_realn1_imag1 );
		assertNotNull( expected_real1_imag1 );

		gInt result_real0_imag2 = real1_imag1.multiply( real1_imag1 );
		gInt result_realn1_imag1 = real1_imag1.multiply( real0_imag1 );
		gInt result_real1_imag1 = real1_imag1.multiply( real1_imag0 );

		// Test if results equal expected
		assertEquals( expected_real0_imag2, result_real0_imag2 );
		assertEquals( expected_realn1_imag1, result_realn1_imag1 );
		assertEquals( expected_real1_imag1, result_real1_imag1 );
	}

	// Test equals() method of gInt class
	public void testEquals()
	{
		gInt expected = new gInt(1, 1); // 1 + i
		assertEquals( expected, real1_imag1 );
		assertEquals( real1_imag1, expected );
		assertNotSame( realn1_imagn1, expected );
		assertNotSame( expected, realn1_imagn1 );
		assertFalse( expected.equals( realn1_imagn1 ) );
		assertFalse( realn1_imagn1.equals( expected ) );
		assertTrue( expected.equals( real1_imag1 ) );
		assertTrue( real1_imag1.equals( expected ) );
	}

	// Test real() method of gInt class
	public void testReal()
	{
		assertTrue( real1_imag1.real() == 1 );
		assertTrue( real0_imag1.real() == 0 );
		assertTrue( realn1_imagn1.real() == -1 );
	}

	// Test imag() method of gInt class
	public void testImag()
	{
		assertTrue( real1_imag1.imag() == 1 );
		assertTrue( real1_imag0.imag() == 0 );
		assertTrue( realn1_imagn1.imag() == -1 );
	}

	// Test norm() method of gInt class
	public void testNorm()
	{
		double epsilon = Math.pow(10, -10); // a == b iff abs(a - b) < epsilon, necessary for floating point comparison
		
		float expected_real1_imag1 = (float) Math.sqrt( 2 ); // norm(1 + i)
		float expected_real1_imag0 = 1; // norm(1)
		float expected_real0_imag1 = 1; // norm(i)
		
		assertTrue( Math.abs( expected_real1_imag1 - real1_imag1.norm() ) <
				epsilon );
		assertTrue( Math.abs( expected_real1_imag0 - real1_imag0.norm() ) <
				epsilon );
		assertTrue( Math.abs( expected_real0_imag1 - real0_imag1.norm() ) <
				epsilon );
		assertTrue( Math.abs( real1_imag1.norm() - realn1_imagn1.norm() ) <
				epsilon ); // (1 + i) and (-1 - i) should have same norm
	}

	// main 
	public static void main( String args[] )
	{
		junit.textui.TestRunner.run( suite() );
	}

}
