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
* Component used to store and manage floor querys. <br> <br>
*
* If the message "true" is received on one of the incoming ports
* button{1-4} , thus the proper request button has been pressed,
* the continuous message "true" will be transmitted via the
* corresponding flRequest{1-4} and via the corresponding light{1-4}
* channel. <br>
* 
* By receiving a floor number via the port {@link clrFlRequest}, this component solves the associated floor request by sending the
* continuous message "false" via the corresponding outgoing channels flRequest{1-4} and light{1-4}.
*/

component Floors {
  timing instant;

  autoconnect port;
  
  port
    in Boolean button1,
    in Boolean button2,
    in Boolean button3,
    in Boolean button4,
    
    in Integer clrFlRequest,
    
    out Boolean flRequest1,
    out Boolean flRequest2,
    out Boolean flRequest3,
    out Boolean flRequest4,
    
    out Boolean light1,
    out Boolean light2,
    out Boolean light3,
    out Boolean light4;
    
    component FloorControl fc1, fc2, fc3, fc4;
    component Split;
    
    connect clrFlRequest -> split.clrFlRequest;
    
    connect split.clrReq1 -> fc1.clrReq;
    connect split.clrReq2 -> fc2.clrReq;
    connect split.clrReq3 -> fc3.clrReq;
    connect split.clrReq4 -> fc4.clrReq;
    
    connect button1 -> fc1.button;
    connect button2 -> fc2.button;
    connect button3 -> fc3.button;
    connect button4 -> fc4.button;
    
    connect fc1.light -> light1;
    connect fc2.light -> light2;
    connect fc3.light -> light3;
    connect fc4.light -> light4;
    
    connect fc1.flRequest -> flRequest1;
    connect fc2.flRequest -> flRequest2;
    connect fc3.flRequest -> flRequest3;
    connect fc4.flRequest -> flRequest4;
}