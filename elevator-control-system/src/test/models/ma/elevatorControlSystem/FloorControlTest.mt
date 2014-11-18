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


testsuite FloorControlTest for FloorControl {

  /**
  * Test whether this components adequately reacts to
  * incoming requests. Furtheremore test whether the 
  * component clears requests when it is instructed to.
  */
  test testTheWholeMachine {
    input {
      clrReq:       <Tk,       Tk, Tk, true, Tk, Tk>;
      button:       <Tk, true, Tk, Tk,       Tk, Tk>;
    }
    expect {
      light:        <Tk, false, 2*(Tk, true), 2*(Tk, false)>;
      flRequest:    <Tk, false, 2*(Tk, true), 2*(Tk, false)>;
    }
  } 
 
}
