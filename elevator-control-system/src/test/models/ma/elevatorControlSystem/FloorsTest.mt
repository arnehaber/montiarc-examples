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


testsuite FloorsTest for Floors {

  /**
  * This test simulates an incoming floor request
  * and clears the request afterwards.
  */ 
  test requestElok {
    input {
      clrFlRequest: <Tk,       Tk, 1, 3*Tk>;
      button1:      <Tk, true, Tk,    3*Tk>;
      button2:      <Tk,       Tk,    3*Tk>;
      button3:      <Tk,       Tk,    3*Tk>;
      button4:      <Tk,       Tk,    3*Tk>;
    }
    expect {
      flRequest1:   <Tk, false, 2*(Tk, true),  2 * (Tk, false)>;
      flRequest2:   <5*(Tk, false)>;
      flRequest3:   <5*(Tk, false)>;
      flRequest4:   <5*(Tk, false)>;
      light1:       <Tk, false, 2*(Tk, true),  2 * (Tk, false)>;
      light2:       <5*(Tk, false)>;
      light3:       <5*(Tk, false)>;
      light4:       <5*(Tk, false)>;
    }
  }
 
}
