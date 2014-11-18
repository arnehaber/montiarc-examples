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


import ma.elevatorControlSystem.gen.AMotorControl;

public class MotorControlImpl extends AMotorControl {
    
    protected int direction;
    
    public MotorControlImpl() {
        super();
        direction = 0;
    }
    
    @Override
    public void treatMotorCom(Integer message) {
        direction = message;
    }
    
    @Override
    protected void timeIncreased() {
        if (direction == 0) {
            sendMotorDown(false);
            sendMotorUp(false);
        }
        
        if (direction == 1) {
            sendMotorDown(false);
            sendMotorUp(true);
        }
        
        if (direction == 2) {
            sendMotorDown(true);
            sendMotorUp(false);
        }
        
    }
    
}
