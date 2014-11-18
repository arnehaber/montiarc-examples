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


testsuite ElevatorControlSystemTest for ElevatorControlSystem {
  boolean t = true;
  boolean f = false;

  /**
  * Test the systems behavior if the door is open
  * and there is no other input in the beginning.
  */
  test tickTest {
    input {
      button1:       <10*Tk>;
      button2:       <10*Tk>;
      button3:       <10*Tk>;
      button4:       <10*Tk>; 
      floor1:        <10*Tk>;
      floor2:        <10*Tk>;
      floor3:        <10*Tk>;
      floor4:        <10*Tk>;
      doorIsOpen:    <10*Tk>;
      doorIsClosed:  <10*Tk>;
      opticalSensor: <10*Tk>;
    }
    expect {
      light1:           <10*(Tk, f)>; 
      light2:           <10*(Tk, f)>; 
      light3:           <10*(Tk, f)>; 
      light4:           <10*(Tk, f)>;  
      motorUp:          <10*(Tk, f)>;    
      motorDown:        <10*(Tk, f)>; 
      doorOpen:         <10*(Tk, f)>;
      doorClose:        <10*(Tk, t)>;
      stopNextFloorOut: <10*(Tk, f)>; 
    }
    
  }

  /**
  * Simulates the initialisation phase for the car
  * located at the fourth floor in the beginning.
  */
  test initialisationStartInFloor4Test {
    input {
      button1:       <18*Tk>;
      button2:       <18*Tk>;
      button3:       <18*Tk>;
      button4:       <18*Tk>; 
      floor1:        <16*Tk, t, 2*Tk>;
      floor2:        <15*Tk, t, 3*Tk>;
      floor3:        <14*Tk, t, 4*Tk>;
      floor4:        <t, 18*Tk>;
      doorIsOpen:    <18*Tk>;
      doorIsClosed:  <10*Tk, t, 8*Tk>;
      opticalSensor: <18*Tk>;
    }
    expect {
      light1:           <18*(Tk, f)>; 
      light2:           <18*(Tk, f)>; 
      light3:           <18*(Tk, f)>; 
      light4:           <18*(Tk, f)>;  
      motorUp:          <18*(Tk, f)>;    
      motorDown:        <13*(Tk, f), 4*(Tk, t), Tk, f>; 
      doorOpen:         <18*(Tk, f)>;
      doorClose:        <10*(Tk, t), 8*(Tk, f) >;
      stopNextFloorOut: <18*(Tk, f)>; 
    }
    
  }
    
  // Start in floor 1 and do initialisation
  test initialisationStartInFloor1Test {
    input {
      button1:       <10*Tk>;
      button2:       <10*Tk>;
      button3:       <10*Tk>;
      button4:       <10*Tk>; 
      floor1:        <t, 10*Tk>;
      floor2:        <10*Tk>;
      floor3:        <10*Tk>;
      floor4:        <10*Tk>;
      doorIsOpen:    <t,  5*Tk, f, 5*Tk>;
      doorIsClosed:  <f, 5*Tk, t, 5*Tk>;
      opticalSensor: <10*Tk>;
    }
    expect {
      light1:           <10*(Tk, f)>; 
      light2:           <10*(Tk, f)>; 
      light3:           <10*(Tk, f)>; 
      light4:           <10*(Tk, f)>;  
      motorUp:          <10*(Tk, f)>;    
      motorDown:        <10*(Tk, f)>; 
      doorOpen:         <10*(Tk, f)>;
      doorClose:        <5*(Tk, t), 5*(Tk, f)>;
      stopNextFloorOut: <10*(Tk, f)>; 
    }
    
  }  
  
  /**
  * Tests whether the system does not emit signals to
  * move the car in any direction if a floor is requested
  * while the door is open.
  */
  test doorBlockTest {
    input {
      button1:       <10*Tk>;
      button2:       <10*Tk>;
      button3:       <10*Tk>;
      button4:       <t, 10*Tk>; 
      floor1:        <t, 10*Tk>;
      floor2:        <10*Tk>;
      floor3:        <10*Tk>;
      floor4:        <10*Tk>;
      doorIsOpen:    <t,  10*Tk>;
      doorIsClosed:  <f, 10*Tk>;
      opticalSensor: <10*Tk>;
    }
    expect {
      light1:           <10*(Tk, f)>; 
      light2:           <10*(Tk, f)>; 
      light3:           <10*(Tk, f)>; 
      light4:           <10*(Tk, t)>;  
      motorUp:          <10*(Tk, f)>;    
      motorDown:        <10*(Tk, f)>; 
      doorOpen:         <10*(Tk, f)>;
      doorClose:        <10*(Tk, t)>;
      stopNextFloorOut: <10*(Tk, f)>; 
    }
    
  }  

  /**
  * This test simulates a scenario where the elevator car is
  * located at the first floor and the fourth floor is
  * requested in the beginning. After the initialisation
  * phase, the system moves the car up to floor 4.
  * When the car reaches floor 4, the system emits signals
  * to open the door.
  * The scenario ends with the car door open and the control
  * system emitting a signal to close the door again.
  */
  test requestFloor4AfterInitialisationTest {
    input {
      button1:       <30*Tk>;
      button2:       <30*Tk>;
      button3:       <30*Tk>;
      button4:       <10*Tk, t, 20*Tk>; 
      floor1:        <t, 30*Tk>;
      floor2:        <13*Tk, t, 17*Tk>;
      floor3:        <14*Tk, t, 16*Tk>;
      floor4:        <15*Tk, t, 15*Tk>;
      doorIsOpen:    <t,  5*Tk, f, 12*Tk, t, 13*Tk>;
      doorIsClosed:  <f, 5*Tk, t, 12*Tk, f, 13*Tk>;
      opticalSensor: <30*Tk>;
    }
    expect {
      light1:           <30*(Tk, f)>; 
      light2:           <30*(Tk, f)>; 
      light3:           <30*(Tk, f)>; 
      light4:           <10*(Tk, f), 8*(Tk, t), 12*(Tk, f)>;  
      motorUp:          <12*(Tk, f), 4*(Tk, t), 14*(Tk, f)>;    
      motorDown:        <30*(Tk, f)>; 
      doorOpen:         <17*(Tk, f), Tk, t, 12*(Tk,f)>;
      doorClose:        <5*(Tk, t), 24*(Tk, f), Tk, t >;
      stopNextFloorOut: <15*(Tk, f), 15*(Tk, t)>; 
    }
    
  }  
    
  /**
  * This test simulates a short scenario.
  * After the initialisation phase, the system receives a
  * request of floor 4. While it is moving up the car to serve
  * that request, it receives a request for floor 1 when the
  * car is located at floor 2. While still trying to serve the
  * request of floor 4, the system receives a request for
  * floor 3, when the elevator car is located between floor 2
  * and floor 3. Afterwards it serves the request of floor 4.
  * Then the system serves the request of floor 3.
  * Afterwards it serves the request of floor 1 and begins to
  * idle. Afer a period of time, floor 1 gets requested again. 
  * The scenario ends with the elevator control system 
  * emitting signals to open the door.
  */
  test scenarioTest {
    input {
      button1:       <13*Tk, t, 67*Tk, t, 10*Tk>;
      button2:       <90*Tk>;
      button3:       <14*Tk, t, 76*Tk>;
      button4:       <10*Tk, t, 80*Tk>; 
      floor1:        <t,54*Tk, t, 36*Tk>;
      floor2:        <13*Tk, t, 40*Tk , t, 37*Tk>;
      floor3:        <14*Tk, t, 20*Tk, t, 56*Tk>;
      floor4:        <15*Tk, t, 75*Tk>;    
      doorIsOpen: <
        t, 5*Tk, f, 12*Tk, t, 13*Tk, f, 7*Tk, t, 12*Tk, f,
        8*Tk, t, 12*Tk, f, 21*Tk
      >;   
      doorIsClosed:  <
        f, 5*Tk, t, 12*Tk, f, 13*Tk, t, 7*Tk, f, 12*Tk, t,
        8*Tk, f, 12*Tk, t, 21*Tk
      >; 
      
      opticalSensor: <90*Tk>;
    }
    expect {
      light1: <
        13*(Tk, f), 44*(Tk, t), 23*(Tk, f), 5*(Tk, t),
        5*(Tk, f)
      >;   
      light2: <90*(Tk, f)>; 
      light3: <14*(Tk, f), 23*(Tk, t), 53*(Tk, f)>; 
      light4: <10*(Tk, f), 8*(Tk, t), 72*(Tk, f)>;  
      motorUp: <12*(Tk, f), 4*(Tk, t), 74*(Tk, f)>;    
      motorDown: <
        33*(Tk, f), 2*(Tk, t), 17*(Tk, f), 3*(Tk, t),
        35*(Tk, f)
      >; 
      doorOpen: <
        17*(Tk, f), Tk, t, 18*(Tk,f), Tk, t, 19*(Tk, f),
        Tk, t, 27*(Tk, f), 6*(Tk, t)
      >;
      doorClose: <
        5*(Tk, t), 24*(Tk, f), Tk, t, 18*(Tk, f), Tk, t,
       19*(Tk, f), Tk, t, 21*(Tk, f)
      >;
      stopNextFloorOut: <
        15*(Tk, f), 37*(Tk, t), 2*(Tk, f), 36*(Tk, t)
      >; 
    }   
  }  


/**
  * This test simulates a scenario where the elevator car is
  * located at the first floor and the fourth floor is
  * requested in the beginning. After the initialisation
  * phase, the system moves the car up to floor 4.
  * When the car reaches floor 4, the system emits signals
  * to open the door.
  * The scenario ends with the car door open and the control
  * system emitting a signal to close the door again.
  */
  test requestFloor3AfterInitialisationTest {
    input {
      button3:       <10*Tk, t, 20*Tk>; 
      floor1:        <t, 30*Tk>;
      floor2:        <13*Tk, t, 17*Tk>;
      floor3:        <14*Tk, t, 16*Tk>;
      doorIsOpen:    <t, 5*Tk, f, 10*Tk, t, 15*Tk>;
      doorIsClosed:  <f, 5*Tk, t, 10*Tk, f, 15*Tk>;
    }
    expect {
      light1:           <30*(Tk, f)>; 
      light2:           <30*(Tk, f)>; 
      light3:           <10*(Tk, f), 7*(Tk, t), 13*(Tk, f)>;  
      light4:           <30*(Tk, f)>; 
      motorUp:          <12*(Tk, f), 3*(Tk, t), 15*(Tk, f)>;    
      motorDown:        <30*(Tk, f)>; 
      doorOpen:         <16*(Tk, f), Tk, t, 13*(Tk,f)>;
      doorClose:        <5*(Tk, t), 23*(Tk, f), 2 * (Tk, t)>;
      stopNextFloorOut: <14*(Tk, f), 16*(Tk, t)>; 
    }
    
  }          
}
