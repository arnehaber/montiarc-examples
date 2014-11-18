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


testsuite DoorControlTest for DoorControl {
  boolean t = true;
  boolean f = false; 
  
  /* We are testing the whole STD.
  * Order of visited states:
  * Init -> Wait 
  * -> 2* ( 2*CloseDoor -> 2*DoorIsClosed
  *         -> 2*OpenDoor -> 10*DoorIsOpen -> CloseDoor -> OpenDoor
  *         -> DoorIsOpen -> CloseDoor
  *       )
  */
  test machineTest {
    input {                                       
      doorCom: <
        10* Tk, t, 20*Tk,  3* Tk, t, 20*Tk
      >;                                           
      opticalSensor: <
        24* Tk, t, 23* Tk, t, 6*Tk
      >;
      doorIsOpen: <    
       7*Tk, t, 4*(Tk, f), Tk, t, 18*Tk, t, 4*(Tk, f),
       Tk, t, 18*Tk
      >;
      doorIsClosed: <
        7*Tk, f, 4*(Tk, t), Tk, f, 18*Tk, f, 4*(Tk, t),
        Tk, f, 18* Tk
      >;
    }
    expect {  
      doorState: <
        7*(Tk, f), 2*(Tk, f), Tk, t, 22*(Tk, f), Tk, t, 20*(Tk, f)
      >;
      doorOpen:  <
        10*(Tk, f), 2*(Tk, t), 12*(Tk, f), Tk, t, 8*(Tk, f), 
        2*(Tk, t), 12*(Tk, f), Tk, t, 5*(Tk,f)
      >;
      doorClose: <
        8*(Tk, t), 15*( Tk, f ), Tk, t, 5*(Tk, false),
        2*(Tk, t),  15*(Tk, f), Tk, t, 5*(Tk, f), Tk, t
      >;
    }
  } 
   
}
