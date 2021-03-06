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
* The component Split relays messages received on the incoming port {@link clrFlRequest}. <br>
* If this component receives a floor number (1-4) over port {@link clrFlRequest}, it sends "true" via the corresponding
* outgoing clrReq{1-4} channel. <br> <br>
* E.g. in case of receiving "2" on port {@link clrFlRequest} this component forwards the message "true" via the channel {@link clrReq2} .
*/

component Split {
  timing instant;
  
  port
    in Integer clrFlRequest,
    
    out Boolean clrReq1,
    out Boolean clrReq2,
    out Boolean clrReq3,
    out Boolean clrReq4;
    
}