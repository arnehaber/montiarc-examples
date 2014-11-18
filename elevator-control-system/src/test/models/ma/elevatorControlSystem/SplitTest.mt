package ma.elevatorControlSystem;

/*
 * #%L
 * elevator-control-system
 * %%
 * Copyright (C) 2013 - 2014 Software Engineering, RWTH
 *                             Aachen University
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Lesser Public License for more details.
 * 
 * You should have received a copy of the GNU General Lesser Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/lgpl-3.0.html>.
 * #L%
 */


testsuite SplitTest for Split {

  /** 
   *  Test whether the component relays incoming
   *  messages via the proper port.
   */
  test outputOnAnyPortTest {
    input {
      clrFlRequest: <5 * Tk, 1, 5 * Tk, 2, 5 * Tk, 3, 5 * Tk, 4, 5 * Tk, 6, Tk>;
    }
    expect {
      clrReq1: <6 * Tk,  true, 20 * Tk>;
      clrReq2: <11 * Tk, true, 15 * Tk>;
      clrReq3: <16 * Tk, true, 10 * Tk>;
      clrReq4: <21 * Tk, true, 5 * Tk>;      
    }
  }
  
  test outputOnFirstPortTest {
    input {
      clrFlRequest: <5 * Tk, 1, 5 * Tk>;
    }
    expect {
      clrReq1: <6 * Tk,  true, 4 * Tk>;
      clrReq2: <10 * Tk>;
      clrReq3: <10 * Tk>;
      clrReq4: <10 * Tk>;      
    }
  }

  test outputOnSecondPortTest {
    input {
      clrFlRequest: <5 * Tk, 2, 5 * Tk>;
    }
    expect {
      clrReq1: <10 * Tk>;
      clrReq2: <6 * Tk,  true, 4 * Tk>;
      clrReq3: <10 * Tk>;
      clrReq4: <10 * Tk>;      
    }
  }
  
  test outputOnThirdPortTest {
    input {
      clrFlRequest: <5 * Tk, 3, 5 * Tk>;
    }
    expect {
      clrReq1: <10 * Tk>;
      clrReq2: <10 * Tk>;
      clrReq3: <6 * Tk,  true, 4 * Tk>;
      clrReq4: <10 * Tk>;      
    }
  }  

  test outputOnFourthPortTest {
    input {
      clrFlRequest: <5 * Tk, 4, 5 * Tk>;
    }
    expect {
      clrReq1: <10 * Tk>;
      clrReq2: <10 * Tk>;
      clrReq3: <10 * Tk>;      
      clrReq4: <6 * Tk,  true, 4 * Tk>;
    }
  }  
    
  test outputOnWrongPortTest {
    input {
      clrFlRequest: <5 * Tk, 5, 5 * Tk, -1, 5 * Tk, 100, 5 * Tk, -100, 5 * Tk>;
    }
    expect {
      clrReq1: <25 * Tk>;
      clrReq2: <25 * Tk>;
      clrReq3: <25 * Tk>;      
      clrReq4: <25 * Tk>;
    }
  }      
}
