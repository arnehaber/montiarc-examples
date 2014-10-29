package ma.tcp.tcp;

/*
 * #%L
 * tcp-ip
 * %%
 * Copyright (C) 2013 - 2014 Software Engineering, RWTH Aachen University
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
 * This Enum represents the different "types" of the frames, we can receive and read in the TCP
 * component. Of cource the frames don't really have a type, but we can differ between Acknowledged,
 * synchronises, finishes and their acknowledgeds. ACK stands for Acknowledge, a frame with set
 * ACK-Bit, but with not set FIN- or SYN-Bit. SYN stands for a Synchronise, a frame without the
 * ACK-Bit, but with the SYN-Bit. SYN_ACK stands for the synchonise acknowledge, where the SYN- and
 * the ACK- bit are set. FIN stands for the finish request, where the only set flag is the FIN-Bit
 * FIN_ACK stands for the Finish acknowledge, where both FIN- and ACK-Bit are set. NONE means the
 * frame has no set SYN-, FIN- or ACK-Bit, meaning it is data and doesn't concern out attempts to
 * connect or disconnect. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public enum Type {
    ACK,
    SYN,
    SYN_ACK,
    FIN,
    FIN_ACK,
    NONE;
    
}
