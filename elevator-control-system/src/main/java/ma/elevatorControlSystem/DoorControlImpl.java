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


import ma.elevatorControlSystem.gen.ADoorControl;

public class DoorControlImpl extends ADoorControl {
    
    protected int timer;
    protected State currentState;
    
    // Buffers of last messages received via the correspondig ports
    protected boolean doorCom = false;
    protected boolean doorIsOpen = false;
    protected boolean doorIsClosed = false;
    protected boolean opticalSensor = false;
    
    public static int time;
    
    public DoorControlImpl() {
        super();
        this.currentState = State.CLOSE_DOOR;
        time = 0;
    }
    
    private enum State {
        CLOSE_DOOR, DOOR_IS_OPEN, OPEN_DOOR, DOOR_IS_CLOSED
    }
    
    @Override
    public void treatDoorCom(Boolean message) {
        this.doorCom = message;
    }
    
    @Override
    public void treatOpticalSensor(Boolean message) {
        this.opticalSensor = message;
    }
    
    @Override
    public void treatDoorIsOpen(Boolean message) {
        this.doorIsOpen = message;
    }
    
    @Override
    public void treatDoorIsClosed(Boolean message) {
        this.doorIsClosed = message;
    }
    
    @Override
    protected void timeIncreased() {
        time++;
        
        switch (currentState) {
            case CLOSE_DOOR:
                if (opticalSensor || doorCom) {
                    timer = 3;
                    currentState = State.OPEN_DOOR;
                    sendDoorClose(false);
                    sendDoorOpen(true);
                    sendDoorState(false);
                }
                else {
                    if (doorIsClosed) {
                        currentState = State.DOOR_IS_CLOSED;
                        sendDoorClose(false);
                        sendDoorOpen(false);
                        sendDoorState(false);
                    }
                    else {
                        if (!doorIsClosed) {
                            sendDoorClose(true);
                            sendDoorOpen(false);
                            sendDoorState(false);
                        }
                    }
                }
                break;
            case DOOR_IS_CLOSED:
                if (doorCom) {
                    timer = 10;
                    currentState = State.OPEN_DOOR;
                    sendDoorClose(false);
                    sendDoorOpen(true);
                    sendDoorState(false);
                }
                else {
                    if (!doorCom) {
                        sendDoorClose(false);
                        sendDoorOpen(false);
                        sendDoorState(true);
                    }
                }
                break;
            case OPEN_DOOR:
                if (doorIsOpen) {
                    currentState = State.DOOR_IS_OPEN;
                    sendDoorClose(false);
                    sendDoorOpen(false);
                    sendDoorState(false);
                }
                else {
                    if (!doorIsOpen) {
                        sendDoorClose(false);
                        sendDoorOpen(true);
                        sendDoorState(false);
                    }
                }
                break;
            case DOOR_IS_OPEN:
                if (this.timer > 0) {
                    timer--;
                    sendDoorClose(false);
                    sendDoorOpen(false);
                    sendDoorState(false);
                }
                else {
                    if (timer == 0) {
                        currentState = State.CLOSE_DOOR;
                        sendDoorClose(true);
                        sendDoorOpen(false);
                        sendDoorState(false);
                    }
                }
                break;
        
        }
        
        // Reset the buffers.
        this.doorCom = false;
        this.opticalSensor = false;
    }
    
}
