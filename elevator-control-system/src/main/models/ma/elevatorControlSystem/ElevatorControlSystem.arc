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

/**
 * @brief This component models an elevator control system 
 *
 * The elevator system has four floors, 
 * each having a request button connected with the ports
 * {@link button1} , {@link button2} , {@link button3} ,
 * {@link button4} and a control light connected via ports
 * {@link light1}, {@link light2}, {@link light3},
 * {@link light4}.
 *
 * If the user presses a request button, the message "true" will
 * be sent via the corresponding channel. 
 * If the message "true" is transmitted via one of the outgoing
 * light ports, the corresponding request light turns on,
 * otherwise it turns off. <br>
 *
 * Every floor provides a sensor which is used to locate the
 * current position of the elevator car.
 * If the message "true" is received via one the of the incoming
 * ports {@link floor1} , {@link floor2} , {@link floor3} ,
 * {@link floor4}, the elevator control system is informed
 * about the elevator car approaching the corresponding floor.<br>
 * 
 * The elevator car consists of a door, which can be opened or
 * closed by a motor via messages through the outgoing ports
 * {@link doorOpen} and {@link doorClose},
 * two sensors that inform the system whether the door is closed
 * or open via the incoming ports {@link doorIsClosed} and
 * {@link doorIsOpen}, and a light sensor connected with the
 * incoming port {@link opticalSensor} which can detect objects in
 * between the door frame while the door is closing. <br>
 *
 * The Control systems uses the outgoing port
 *{@link stopNextFloorOut} to signal whether the motor shall
 * throttle the cars moving speed and stop when reaching the
 * next floor. <br>
 *
 * The outgoing ports {@link motorUp} and {@link motorDown} are used
 * to control the motor of the elevator car: To move it upwards, 
 * downwards or to stop it.
 *
 * @author Oliver Kautz
 * @version 1
 */
 
component ElevatorControlSystem {

  behavior timed;

  autoconnect port;

  port
    /** 
    * This port is directly connected with the request button
    * of floor 1. If the component receives the message "true"
    * via this port, it is informed about a request for floor 1.
    */ 
    in Boolean button1,
    /** 
    * This port is directly connected with the request button
    * of floor 2. If the component receives the message "true"
    * via this port, it is informed about a request for floor 2.
    */ 
    in Boolean button2,
    /** 
    * This port is directly connected with the request button
    * of floor 3. If the component receives the message "true"
    * via this port, it is informed about a request for floor 3.
    */     
    in Boolean button3,
    /** 
    * This port is directly connected with the request button
    * of floor 4. If the component receives the message "true"
    * via this port, it is informed about a request for floor 4.
    */     
    in Boolean button4,    
    /**
    * If the component receives the message "true" via this port,
    * it is informed that the elevator car approaches floor 1.
    */
    in Boolean floor1,
    /**
    * If the component receives the message "true" via this port,
    * it is informed that the elevator car approaches floor 2.
    */
    in Boolean floor2,
    /**
    * If the component receives the message "true" via this port,
    * it is informed that the elevator car approaches floor 3.
    */
    in Boolean floor3,
    /**
    * If the component receives the message "true" via this port,
    * it is informed that the elevator car approaches floor 4.
    */
    in Boolean floor4,  
    /**
    * If the component receives the signal "true" via this port,
    * it is informed that the elevator car door is closed.
    */
    in Boolean doorIsClosed,
    /**
    * If the component receives the signal "true" via this port,
    * it is informed that the elevator car door is open.
    */
    in Boolean doorIsOpen,  
    /**
    * If the component receives the message "true" via this port,
    * it is informed that an object is located in between the
    * door frame.
    */
    in Boolean opticalSensor,  
    /**
    * This component emits "true" via this port to illuminate the
    * control light located at floor 1. It emits "false" via this
    * port to turn off the control light at floor 1.
    */
    out Boolean light1,
    /**
    * This component emits "true" via this port to illuminate the
    * control light located at floor 2. It emits "false" via this
    * port to turn off the control light at floor 2.
    */
    out Boolean light2,
    /**
    * This component emits "true" via this port to illuminate the
    * control light located at floor 3. It emits "false" via this
    * port to turn off the control light at floor 3.
    */    
    out Boolean light3,
    /**
    * This component emits "true" via this port to illuminate the
    * control light located at floor 4. It emits "false" via this
    * port to turn off the control light at floor 4.
    */    
    out Boolean light4,
    /**
    * The component emits "true" via this port to instruct the 
    * motor to move the elevator car upwards.
    */
    out Boolean motorUp,
    /**
    * The component emits "true" via this port to instruct the 
    * car motor to move the elevator car downwards.
    */
    out Boolean motorDown,
    /**
    * The component emits "true" via this port to instruct the 
    * door motor to open the elevator car door.
    */
    out Boolean doorOpen,
    /**
    * The component emits "true" via this port to instruct the 
    * door motor to close the elevator car door.
    */    
    out Boolean doorClose,
    /**
    * If the component emits "true" via this port, it instructs
    * the car motor to throttle its speed and to stop when 
    * reaching the next floor.
    */
    out Boolean stopNextFloorOut;
    
  component Floors;
  component Elevator;
  component ma.sim.FixDelay<Integer>(1) clrFlRequestDelay;
  
  connect elevator.clrFlRequest -> clrFlRequestDelay.portIn;
  connect clrFlRequestDelay.portOut -> floors.clrFlRequest;

}