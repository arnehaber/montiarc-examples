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
* The component MotorControl controls the moving direction of the elevator car. <br> <br>
* 
* The moving direction of the elevator car depends on the non- continuous message
* this component receives on the incoming port {@link motorCom} . It transforms this signal to a continuous signal. <br>
*
*    motorCom    motorUp    motorDown <br>
*       0        false       false    <br>
*       1        true        false    <br>
*       2        false       true     <br>
*/

component MotorControl {
  behavior timed;
  
  port
    in Integer motorCom,
    
    out Boolean motorUp,
    out Boolean motorDown;
}