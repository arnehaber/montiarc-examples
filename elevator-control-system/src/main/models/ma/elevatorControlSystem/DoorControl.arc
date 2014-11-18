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
* Controls the elevator car door. <br> <br>
*
* When the elevator car reaches a requested floor, it stops and sends the signal "true" through channel doorCom. <br>
* After receiving a message to open the door ( "true" on {@link doorCom} ) , opening it, by sending "true" through the
* channel {@link doorOpen}, and letting it open for 2*Tk, this components tries to close the door, by transmitting "true"
* via the port {@link doorClose}, again. <br>
*
* While the door is closing and this component receives the message
* "true" on at least one of the channels {@link doorCom} or {@link opticalSensor},
* it opens the car door again and lets it stay open for 1*Tk. Afterwards it tries to close the door again. <br>
* 
* While the car door is closed, it transmits the continuous signal "true" via the port {@link doorState}.
*/

component DoorControl {
  behavior timed;

  port
    /**
    * If the component receives "true" via this port, it is instructed to open the car door.
    * If it receives "false" via this port, it is instructed to close the car door.
    */
    in Boolean doorCom,             
    /**
    * If the component receives the message "true" via this port, it is informed about an object 
    * located in between the door frame.
    */
    in Boolean opticalSensor,      
    /**
    * If the component receives the message "true" via this port, it is informed about that  
    * the car door is opened.
    */
    in Boolean doorIsOpen,          
    /**
    * If the component receives the message "true" via this port, it is informed about that  
    * the car door is closed.
    */    
    in Boolean doorIsClosed,        
    /**
    * If the car door is closed, the component emits "true" via this port. Else,
    * it emits "false" via this port.
    */
    out Boolean doorState,       
    /*
    * The component emits "true" via this port to instruct the door motor to open the door
    */   
    out Boolean doorOpen,     
    /*
    * The component emits "true" via this port to instruct the door motor to close the door
    */        
    out Boolean doorClose;         
}