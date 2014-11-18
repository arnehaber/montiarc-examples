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


testsuite StopNextContinueTest for StopNextContinue {
    
  /**
  * Test whether the component relays its most recently
  * received value while starting to transmit "false"
  */  
  test changeOutputTest {
    input {
      stopNextFloor: <5*Tk, true, 10* Tk, false, Tk>;
    }
    expect {
      stopNextFloorOut:<5*(Tk, false), 10*(Tk, true), Tk, false>;
    }
  }
  
}
