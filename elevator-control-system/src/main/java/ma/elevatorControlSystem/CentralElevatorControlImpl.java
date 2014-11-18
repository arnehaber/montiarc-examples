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


import java.util.LinkedList;
import java.util.List;

import ma.elevatorControlSystem.gen.ACentralElevatorControl;

public class CentralElevatorControlImpl extends ACentralElevatorControl {
    
    
    protected enum States {
        INIT, SERVE_REQUEST, SEARCH_REQUEST
    }
    
    protected States state;
    
    /*
     * Stores floorRequests. 
     * florrRequestList.contains(X) == true,
     *  iff floorX is requested.
     */
    protected List<Integer> floorRequestList;
    
    /*
     * Buffers messages received via port doorState.
     * (doorState == true), iff the elevator car door is closed.
     */
    protected boolean doorState = false;
    
    // Stores the last floor signal received
    protected int lastFloorSignal = 0;
    
    /*
     * Stores the current priority moving direction
     * of the elevator car.
     * direction == 1 -> priority moving direction: upwards
     * direction == 2 -> priority moving direction: downwards
     */
    protected int direction;
    
    protected boolean stopNextFloor;
    
    /*
     * (idle == true) iff the elevator car idles or
     * begins idling.
     */
    protected boolean idle;
    
    public CentralElevatorControlImpl() {
        floorRequestList = new LinkedList<Integer>();
        state = States.INIT;
    }
    
    @Override
    public void treatFlRequest1(Boolean message) {
        if (message && !floorRequestList.contains(1)) {
            floorRequestList.add(1);
        }
        else {
            if (!message) {
                floorRequestList.remove(new Integer(1));
            }
        }
        
    }
    
    @Override
    public void treatFlRequest2(Boolean message) {
        if (message && !floorRequestList.contains(2)) {
            floorRequestList.add(2);
        }
        else {
            if (!message) {
                floorRequestList.remove(new Integer(2));
            }
        }
        
    }
    
    @Override
    public void treatFlRequest3(Boolean message) {
        if (message && !floorRequestList.contains(3)) {
            floorRequestList.add(3);
        }
        else {
            if (!message) {
                floorRequestList.remove(new Integer(3));
            }
        }
        
    }
    
    @Override
    public void treatFlRequest4(Boolean message) {
        if (message && !floorRequestList.contains(4)) {
            floorRequestList.add(4);
        }
        else {
            if (!message) {
                floorRequestList.remove(new Integer(4));
            }
        }
        
    }
    
    @Override
    public void treatFloor1(Boolean message) {
        if (message) {
            lastFloorSignal = 1;
        }
        
    }
    
    @Override
    public void treatFloor2(Boolean message) {
        if (message) {
            lastFloorSignal = 2;
        }
        
    }
    
    @Override
    public void treatFloor3(Boolean message) {
        if (message) {
            lastFloorSignal = 3;
        }
        
    }
    
    @Override
    public void treatFloor4(Boolean message) {
        if (message) {
            lastFloorSignal = 4;
        }
        
    }
    
    @Override
    public void treatDoorState(Boolean message) {
        doorState = message;
    }

    @Override
    protected void timeIncreased() {
        switch (state) {
            case INIT:
                if (lastFloorSignal == 1 && doorState) {
                    /*
                     * Transitions name: arrivedFloor1.
                     * The car is already in floor1 and the
                     * doorControl has ended up its initialisation
                     * (closing the door).
                     */
                    direction = 1;
                    idle = true;
                    sendMotorCom(0);
                    state = States.SEARCH_REQUEST;
                }
                else {
                    /*
                     * Transitions name: driveDown.
                     * The car is not in floor1,
                     * emit messages to drive the car down.
                     */
                    if (lastFloorSignal != 1 && doorState) {
                        // Wait until the door is closed.
                        sendMotorCom(2);
                    }
                }
                break;
            
            case SEARCH_REQUEST:
                if (floorRequestList.isEmpty()) {
                    /*
                     * Transitions name: idle.
                     * There is no request -> idle.
                     */

                    idle = true;
                }
                else {
                    if (!floorRequestList.isEmpty()
                        && requestForCurrentFloor() 
                        && stopNextFloor
                        ) 
                    {
                        /*
                         * Transitions name: openDoor.
                         * The floor where the elevator car stands
                         * was already requested in the last time
                         * slice, so open the door.
                         */
                        clearRequest(lastFloorSignal);
                        stopNextFloor = false;
                        idle = false;
                        state = States.SERVE_REQUEST;
                        sendClrFlRequest(lastFloorSignal);
                        sendDoorCom(true); 
                        sendMotorCom(0);
                    }
                    else {
                        if (!floorRequestList.isEmpty()
                            && requestForCurrentFloor()
                            && idle
                            ) 
                        {
                            /*
                             * Transitions name: 
                             *   serveReqForCurFloor.
                             * the floor where the elevator car
                             * stands is requested but was not
                             * in the last time unit and the
                             * control system idled before.
                             */
                            stopNextFloor = true;
                            idle = false;
                        }
                        else {
                            if (!floorRequestList.isEmpty()
                                && doorState 
                                && requestForNextFloor()
                                ) 
                            {
                                /*
                                 * Transitions name:
                                 *   nxtFlrInUpdDirReq.
                                 * The door is closed, the car is
                                 * ready to drive. Additionally
                                 * the next floor where the
                                 * elevator car is driving to is
                                 * requested.
                                 */
                                stopNextFloor = true;
                                idle = false;
                                sendMotorCom(direction);
                                sendStopNextFloor(true);
                            }
                            else {
                                if (!floorRequestList.isEmpty()
                                    && doorState 
                                    && !requestForNextFloor()
                                    ) 
                                {
                                    /*
                                     *  Transitions name:
                                     *    FlrInUpdDirReq.
                                     *  Any floor is requested.
                                     *  But the next floor is not
                                     *  requested. 
                                     *  The door is closed.  
                                     */
                                    idle = false;
                                    sendMotorCom(direction);
                                    sendStopNextFloor(false);
                                }
                            }
                            
                        }
                    }
                }
                break;
            
            case SERVE_REQUEST:
                if (!doorState) {
                    /*
                     * Transitions name:
                     *   doorOpen
                     */
                    state = States.SEARCH_REQUEST;
                }
                else {
                    if (doorState) {
                        /*
                         * Transitions name:
                         *   openDoor1.
                         * The door is closed, wait until
                         * it opened.
                         */                        
                        sendDoorCom(true);
                    }
                }
                break;
        }
        
    }
    
    private void clearRequest(int toClear) {
        floorRequestList.remove(new Integer(toClear));
        
    }
    
    /*
     * This method returns "true" if the floor, the elevator
     * control system lastly received a floor signal from,
     * is requested.
     */
    private boolean requestForCurrentFloor() {
        return floorRequestList.contains(lastFloorSignal);
    }
    
    /*
     * At first this method updates the priority moving direction.
     * It returns "true" if the next floor in the updated moving
     * direction is requested. Otherwise, it returns "false".
     */
    private boolean requestForNextFloor() {
        updateMovingDirection();
        if (direction == 1
            && floorRequestList.contains(lastFloorSignal + 1)
            ) 
        {
            return true;
        }
        if (direction == 2
            && floorRequestList.contains(lastFloorSignal - 1)
            ) 
        {
            return true;
        }
        
        return false;
    }
    
    /*
     * This method updates the priority moving direction.
     * If any floor in the current priority moving direction
     * is requested, this method lets the priority moving 
     * direction unchanged. Otherwise, it switches the priority
     * moving direction.
     */
    private void updateMovingDirection() {
        boolean changeDirection = true;
        for (Integer cur : floorRequestList) {          
            if (direction == 1 && cur > lastFloorSignal) {
                changeDirection = false;
            }
            else {
                if (direction == 2 && cur < lastFloorSignal) {
                    changeDirection = false;
                }
            }
            
        }
        
        if (changeDirection) {
            direction = direction == 1 ? 2 : 1;
        }
        
    }

    
}
