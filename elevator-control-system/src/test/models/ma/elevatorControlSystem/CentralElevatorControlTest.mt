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


testsuite CentralElevatorControlTest for CentralElevatorControl {
  boolean t = true;
  boolean f = false;
  
  /**
  * Simulates the initialisation phase for the car
  * located at the fourth floor in the beginning.
  */
  test InitStartFloor4Test {
    input {
      flRequest1: <         4*Tk>;
      flRequest2: <         4*Tk>;
      flRequest3: <         4*Tk>;
      flRequest4: <         4*Tk>; 
      floor1:     <3*Tk, t,   Tk>;
      floor2:     <2*Tk, t, 2*Tk>;
      floor3:     <Tk, t,   3*Tk>;
      floor4:     <t,       4*Tk>;
      doorState:  <t,       4*Tk>;
    }
    expect {
     stopNextFloor: <4*Tk>;
      motorCom:     <3*(Tk, 2), Tk, 0>;
      doorCom:      <4*Tk>;
      clrFlRequest: <4*Tk>;
    }
  }
  
  /**
  * Simulates the initialisation phase for the car
  * located at the first floor in the beginning.
  */
  test InitStartFloor1Test {
    input {
      flRequest1: <   Tk>;
      flRequest2: <   Tk>;
      flRequest3: <   Tk>;
      flRequest4: <   Tk>; 
      floor1:     <t, Tk>;
      floor2:     <   Tk>;
      floor3:     <   Tk>;
      floor4:     <   Tk>;
      doorState:  <t, Tk>;
    }
    expect {
     stopNextFloor: <Tk>;
      motorCom:     <Tk, 0>;
      doorCom:      <Tk>;
      clrFlRequest: <Tk>;
    }
  }
  
  
  /**
  * Tests whether the system does not emit signals to
  * move the car in any direction if a floor is requested,
  * while the door is open.
  */
  test doorBlockTest {
    input {
      flRequest1: <          11*Tk>;
      flRequest2: <          11*Tk>;
      flRequest3: <          11*Tk>;
      flRequest4: <   Tk, t, 10*Tk>; 
      floor1:     <t,        11*Tk>;
      floor2:     <          11*Tk>;
      floor3:     <          11*Tk>;
      floor4:     <          11*Tk>;
      doorState:  <t, Tk, f, 10*Tk>;
    }
    expect {
     stopNextFloor: <11*Tk>;
      motorCom:     <Tk, 0, 10*Tk>;
      doorCom:      <11*Tk>;
      clrFlRequest: <11*Tk>;
    }
  }
  
  /**
  * This test simulates a system run where the
  * elevator car is located at the first floor
  * at the beginning and the fourth floor is requested.
  * The simulation stops once the car reaches the fourth floor.
  */
  test initFloor4RequestTest {
    input {
      flRequest1: <   Tk,    Tk,    Tk,    Tk,    Tk>;
      flRequest2: <   Tk,    Tk,    Tk,    Tk,    Tk>;
      flRequest3: <   Tk,    Tk,    Tk,    Tk,    Tk>;
      flRequest4: <   Tk, t, Tk,    Tk,    Tk,    Tk>; 
      floor1:     <t, Tk,    Tk,    Tk,    Tk,    Tk>;
      floor2:     <   Tk,    Tk, t, Tk,    Tk,    Tk>;
      floor3:     <   Tk,    Tk,    Tk, t, Tk,    Tk>;
      floor4:     <   Tk,    Tk,    Tk,    Tk, t, Tk>;
      doorState:  <t, Tk,    Tk,    Tk,    Tk,    Tk>;
    } 
    expect {
     stopNextFloor: <Tk, 2*(Tk, f), (Tk, t), Tk>;
      motorCom:     <Tk, 0, 3*(Tk, 1), Tk, 0 >;
      doorCom:      <Tk, Tk, Tk, Tk, Tk, t>;
      clrFlRequest: <Tk, Tk, Tk, Tk, Tk, 4>;
    }
  }
  
  /**
  * This test simulates a system
  * run where the elevator car is located at the first floor 
  * in the beginning and the floors 2,3,4 are requested.
  * In the simulation the elevator car stops and opens the door
  * at each floor. The simulation stops once the car reaches the
  * fourth floor.
  */
  test requestFloors2and3and4ServeAllRequestsTest {
    input {
      flRequest1: <                                   9*Tk>;
      flRequest2: <Tk, t,                             8*Tk>;
      flRequest3: <Tk, t,                             8*Tk>;
      flRequest4: <Tk, t,                             8*Tk>; 
      floor1:     <t,                                 9*Tk>;
      floor2:     <2*Tk, t,                           7*Tk>;
      floor3:     <5*Tk, t,                           4*Tk>;
      floor4:     <8*Tk, t,                             Tk>;
      doorState:  <t, 3*Tk, f, Tk, t, 2*Tk, f, Tk, t, 2*Tk>;
    } 
    expect {
     stopNextFloor: <2*Tk, t, Tk, 2*(Tk, Tk, t, Tk)           >;
      motorCom:     <Tk, 0, Tk, 1, Tk, 0, 2*(Tk, Tk, 1, Tk, 0)>;
      doorCom:      <3*Tk, 2*(t, Tk, Tk, Tk), t               >;
      clrFlRequest: <3*Tk, 2, 3*Tk, 3, 3*Tk, 4                >;
    }
  }
  
  /**
  * This test checks whether the central elevator control does
  * not emit signals to stop the elevator car without slowing
  * the motor down in case of a spontaneous floor request.
  * In the beginning of this test case the elevator car is
  * located at the first floor. The system receives a request 
  * for floor 4. While driving up to serve that request, the 
  * central elevator control receives a request of floor 3 when
  * it is located between the second and the third floor.
  * Since it did not emit signals to slow the motor down when
  * it was located between the second and the third floor  
  * because the request for floor 3 just received the system, 
  * it does not emit signals to stop at the third floor.
  */
  test requestWhilePassingWayTest {
    input {
      flRequest1: <8* Tk>;
      flRequest2: <8* Tk>;
      flRequest3: <3*Tk, true, 5* Tk>;
      flRequest4: <Tk, t, 7* Tk>; 
      floor1:     <t, 8* Tk>;
      floor2:     <2*Tk, t, 6* Tk>;
      floor3:     <3* Tk, t, 4*Tk, true, Tk>;
      floor4:     <4* Tk, t, 4* Tk>;
      doorState:  <t, 5* Tk, f, Tk, t, 2*Tk>;
    } 
    expect {
      stopNextFloor: <Tk, 2*(Tk, false), (Tk, true), 3*Tk, true, Tk>;
      motorCom:     <Tk, 0, 3*(Tk, 1), Tk, 0, 2* Tk, 2, Tk, 0>;
      doorCom:      <5* Tk, t, 3* Tk, t>;
      clrFlRequest: <5* Tk, 4, 3* Tk, 3>;
    }
  }  
  
  /**
  * This test checks the central elevator control
  * strategy regarding priority direction changes.
  */ 
  test requestInOppositeDirectionTest {
    input {
      flRequest1: <9*Tk>;
      flRequest2: <2*Tk, t, 7*Tk>;
      flRequest3: <9*Tk>;
      flRequest4: <Tk, t, 8*Tk>; 
      floor1:     <true, 9*Tk>;
      floor2:     <2*Tk, t, 6*Tk, t, Tk>;
      floor3:     <3*Tk, t, 4*Tk, t, 2*Tk>;
      floor4:     <4*Tk, t, 5*Tk>;
      doorState:  <t, 5*Tk, f, Tk, t,  3*Tk>;
    } 
    expect {
     stopNextFloor:<Tk, 2*(Tk, f), (Tk, t), 3*Tk, f, Tk, t, Tk>;
     motorCom:     <Tk, 0, 3*(Tk, 1), Tk, 0, 2*Tk, 2*(2, Tk), 0>;
     doorCom:      <5* Tk, true, 4* Tk, t>;
     clrFlRequest: <5* Tk, 4, 4* Tk, 2>;
    }
  }
      
}
