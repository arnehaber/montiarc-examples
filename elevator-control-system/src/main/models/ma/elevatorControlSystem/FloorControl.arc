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
* The component FloorControl manages requests for a single floor. <br> <br>
* Initially the continous signal "false" is send via the outgoing channels {@link light} and {@link flRequest}. <br>
*
* If "true" is received on the incoming port {@link button} ,
* and thus a request is comming in for the floor this component manages,
* it sends the continuous signal "true" via the outgoing channels {@link light} and {@link flRequest}. <br>
* Once this component receives the message "true" over the port {@link clrReq}, so the request received earlier is solved,
* the continuous message "false" will transmitted via its outgoing channels {@link light} and {@link flRequest}.
*/
component FloorControl {
  timing instant;

  port 
    in Boolean clrReq,
    in Boolean button,
    
    out Boolean light,
    out Boolean flRequest;
}