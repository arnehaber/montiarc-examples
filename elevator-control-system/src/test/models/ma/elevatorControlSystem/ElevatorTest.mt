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


testsuite ElevatorTest for Elevator {
  
  /**
  * Test whether the door control initially emits
  * signals to close the door when it is open in 
  * the beginning.
  */ 
  test doorControlInitialisationTest {
    input {
      flRequest1:    <12*Tk>;
      flRequest2:    <12*Tk>;
      flRequest3:    <12*Tk>;
      flRequest4:    <12*Tk>; 
      floor1:        <12*Tk>;
      floor2:        <12*Tk>;
      floor3:        <12*Tk>;
      floor4:        <12*Tk>;
      doorIsOpen:    <true, 10*Tk, false, 2*Tk>;
      doorIsClosed:  <false, 10*Tk, true, 2*Tk>;
      opticalSensor: <12*Tk>;
    }
    expect {
      motorUp:          <12*(Tk,false)>;
      motorDown:        <12*(Tk,false)>;
      doorClose:        <10*(Tk, true), 2*(Tk, false)>;
      doorOpen:         <10*(Tk,false), 2*(Tk, false)>;
      clrFlRequest:     <12*Tk>;
      stopNextFloorOut: <12*(Tk,false)>;
    }
    
  }

  /**
  * Simulates the initialisation phase for the car
  * located at the fourth floor in the beginning.
  */
  test initStartFloor4Test {
    input {
      flRequest1:    <10*Tk>;
      flRequest2:    <10*Tk>;
      flRequest3:    <10*Tk>;
      flRequest4:    <10*Tk>; 
      floor1:        <8*Tk, true, 2*Tk>;
      floor2:        <7*Tk, true, 3*Tk>;
      floor3:        <6*Tk, true, 4*Tk>;
      floor4:        <true, 10*Tk>;
      doorIsOpen:    <true,  2*Tk, false, 8*Tk>;
      doorIsClosed:  <false, 2*Tk, true,  8*Tk>;
      opticalSensor: <10*Tk>;
    }
    expect {
      motorUp:          <10*(Tk,false)>;
      motorDown:        <5*(Tk,false), 4*(Tk, true), Tk, false>;
      doorClose:        <Tk, true, Tk, true, 8*(Tk, false)>;
      doorOpen:         <10*(Tk,false)>;
      clrFlRequest:     <10*Tk>;
      stopNextFloorOut: <10*(Tk,false)>;
    }
    
  }
  
  /**
  * Simulates the initialisation phase for the car
  * located at the first floor in the beginning.
  */
  test initStartFloor1Test {
    input {
      flRequest1:    <8*Tk>;
      flRequest2:    <8*Tk>;
      flRequest3:    <8*Tk>;
      flRequest4:    <8*Tk>; 
      floor1:        <true, 8*Tk>;
      floor2:        <8*Tk>;
      floor3:        <8*Tk>;
      floor4:        <8*Tk>;
      doorIsOpen:    <8*Tk>;
      doorIsClosed:  <true, 8*Tk>;
      opticalSensor: <8*Tk>;
    }
    expect {
      motorUp:          <8*(Tk,false)>;
      motorDown:        <8*(Tk,false)>;
      doorClose:        <8*(Tk, false)>;
      doorOpen:         <8*(Tk,false)>;
      clrFlRequest:     <8*Tk>;
      stopNextFloorOut: <8*(Tk,false)>;
    }
    
  }
  
  /**
  * Tests whether the system does not emit signals to
  * move the car in any direction if a floor is requested
  * while the door is open.
  */
  test doorBlockTest {
    input {
      flRequest1:    <10*Tk>;
      flRequest2:    <10*Tk>;
      flRequest3:    <10*Tk>;
      flRequest4:    <10*Tk>; 
      floor1:        <8*Tk, true, 2*Tk>;
      floor2:        <7*Tk, true, 3*Tk>;
      floor3:        <6*Tk, true, 4*Tk>;
      floor4:        <true, 10*Tk>;
      doorIsOpen:    <true,  10*Tk>;
      doorIsClosed:  <false, 10*Tk>;
      opticalSensor: <10*Tk>;
    }
    expect {
      motorUp:          <10*(Tk,false)>;
      motorDown:        <10*(Tk,false)>;
      doorClose:        <10*(Tk, true)>;
      doorOpen:         <10*(Tk,false)>;
      clrFlRequest:     <10*Tk>;
      stopNextFloorOut: <10*(Tk,false)>;
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
  test requestOnWayTest {
    input {
      flRequest1:    <15*Tk>;
      flRequest2:    <15*Tk>;
      flRequest3:    <11*Tk, true, 4*Tk>;
      flRequest4:    <8*Tk, true, 7*Tk>; 
      floor1:        <true, 15*Tk>;
      floor2:        <10*Tk, true, 5*Tk>;
      floor3:        <11*Tk, true, 4*Tk>;
      floor4:        <12*Tk, true, 3*Tk>;
      doorIsOpen:    <15*Tk>;
      doorIsClosed:  <true, 15*Tk>;
      opticalSensor: <15*Tk>;
    }
    expect {
      motorUp:       <9*(Tk,false), 4*(Tk, true), 2*(Tk, false)>;
      motorDown:     <14*(Tk,false), Tk, false>;
      doorClose:     <15*(Tk, false)>;
      doorOpen:      <14*(Tk,false), Tk, true>;
      clrFlRequest:  <13*Tk, 4, 2*Tk>;
      stopNextFloorOut: <12*(Tk,false), 3*(Tk, true)>;
    }
    
  }
  
  /**
  * This test checks the central elevator control
  * strategy regarding priority direction changes.
  */ 
  test requestInOppositeDirectionTest {
    input {
      flRequest1:    <10*Tk, true, 5*Tk>;
      flRequest2:    <15*Tk>;
      flRequest3:    <15*Tk>;
      flRequest4:    <8*Tk, true, 7*Tk>; 
      floor1:        <true, 15*Tk>;
      floor2:        <10*Tk, true, 5*Tk>;
      floor3:        <11*Tk, true, 4*Tk>;
      floor4:        <12*Tk, true, 3*Tk>;
      doorIsOpen:    <15*Tk>;
      doorIsClosed:  <true, 15*Tk>;
      opticalSensor: <15*Tk>;
    }
    expect {
      motorUp:          <9*(Tk,false), 4*(Tk, true), Tk, false, Tk, false>;
      motorDown:        <15*(Tk,false)>;
      doorClose:        <15*(Tk, false)>;
      doorOpen:         <14*(Tk,false), Tk, true>;
      clrFlRequest:     <13*Tk, 4, 2*Tk>;
      stopNextFloorOut: <12*(Tk,false), 3*(Tk, true)>;
    }
    
  }
      
  /**
  * This tests simulates a small input- output-scenario.
  * Tests whether the control system emits signals to open
  * the car door when reaching a requested floor. 
  * Further it tests whether it emits signals to close the door
  * again after a period of time.
  */
  test openCloseDoorAfterRequestTest {
    input {
      flRequest1:    <10*Tk, true, 21*Tk>;
      flRequest2:    <31*Tk>;
      flRequest3:    <31*Tk>;
      flRequest4:    <8*Tk, true, 23*Tk>; 
      floor1:        <true, 31*Tk>;
      floor2:        <10*Tk, true, 21*Tk>;
      floor3:        <11*Tk, true, 20*Tk>;
      floor4:        <12*Tk, true, 19*Tk>;
      doorIsOpen:    <15*Tk, true, 16*Tk>;
      doorIsClosed:  <true, 15*Tk, false, 12*Tk, true, 4*Tk>;
      opticalSensor: <31*Tk>;
    }
    expect {
      motorUp:       <9*(Tk,false), 4*(Tk, true), 18*(Tk, false)>;
      motorDown:     <30*(Tk,false), Tk, true>;
      doorClose:     <26*(Tk, false), Tk, true, 4*(Tk, false)>;
      doorOpen:      <14*(Tk,false), Tk, true, 16*(Tk, false)>;
      clrFlRequest:  <13*Tk, 4, 18*Tk>;
      stopNextFloorOut: <12*(Tk,false), 18*(Tk, true), Tk, false>;
    }
    
  }
        
}
