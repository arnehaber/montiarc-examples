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

component Elevator {

  autoconnect port;

  port
    in Boolean flRequest1,
    in Boolean flRequest2,
    in Boolean flRequest3,
    in Boolean flRequest4,
    
    in Boolean floor1,
    in Boolean floor2,
    in Boolean floor3,
    in Boolean floor4,
    
    in Boolean doorIsOpen,
    in Boolean doorIsClosed,
    in Boolean opticalSensor,
    
    out Integer clrFlRequest,
    out Boolean doorOpen,
    out Boolean doorClose,
    
    out Boolean motorUp,
    out Boolean motorDown,
    
    out Boolean stopNextFloorOut;
    
  component CentralElevatorControl cec;
  component DoorControl;
  component MotorControl;
  component StopNextContinue;
  component ma.sim.FixDelay<Boolean>(1) doorDelay;
  
  connect cec.doorCom -> doorDelay.portIn;
  connect doorDelay.portOut -> doorControl.doorCom;
  
}