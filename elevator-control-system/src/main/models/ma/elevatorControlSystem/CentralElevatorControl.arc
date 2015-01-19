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
* @brief Implements a control algorithm for an elevator system
*
* Component CentralElevatorControl models the control
* unit of an elevator control system with four floors.
* It implements a strategy to handle incoming floor
* requests and emits signals to actuate a motor to open
* or close a door and motor to move the elevator car. <br>
*
* The conrol system has a priority direction. As long as there
* are requests in the priority direction, the control system
* moves the elevator car in that direction. If there are no 
* requests in the priority direction anymore, the control system
* stops the elevator car and idles, or instead changes the priority
* direction if there is any request in the opposite direction. <br>
*
*/
component CentralElevatorControl {
  timing instant;

  port
    /**
    * If the component receives the message "true" via this port,
    * it is informed about a request for floor 1.
    */
    in Boolean flRequest1,
    /**
    * If the component receives the message "true" via this port,
    * it is informed about a request for floor 2.
    */    
    in Boolean flRequest2,
    /**
    * If the component receives the message "true" via this port,
    * it is informed about a request for floor 3.
    */    
    in Boolean flRequest3,
    /**
    * If the component receives the message "true" via this port,
    * it is informed about a request for floor 4.
    */    
    in Boolean flRequest4,
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
    * it is informed that the elevator car door is open.
    * Vice versa, if it receives the message "false" via this
    * port, is is informed that the elevator car door is closed.
    */
    in Boolean doorState,
    /**
    * If the component emits "true" via this port, it instructs
    * the car motor to throttle its speed and to stop when 
    * reaching the next floor.
    */    
    out Boolean stopNextFloor,
    /**
    * The component emits the signal "1" via this port to 
    * instruct the car motor to move the elevator car upwards.
    * It emits the signal "2" via this port to instruct the
    * car motor to move the car downwards.
    * It emits the signal "0" via this port to stop the moving
    * of the elevator car.
    */
    out Integer motorCom,    
    /**
    * This component emits the message "true" via this port to
    * open the door.
    */
    out Boolean doorCom,
    /**
    * To clear a request for a floor, this component emits the
    * corresponding floor number through this port.
    */
    out Integer clrFlRequest;
}