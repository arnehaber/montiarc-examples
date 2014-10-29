package ma.tcp.ethernet;

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

import ma.tcp.EtherMsg;
import ma.tcp.ManchesterSignal;

/**
 * @brief Component {@code ManchesterEncode} realises translation into Manchester-Signals.
 *
 * Componente {@code ManchesterEncode} translates datagrams into Manchester-Signals to transfer them over the physical medium.
 * This is done by interpreting the datagram as a byte-array converted into a binary string, where each 0 is replaced by a Falling-Edge and
 * each 1 bye a Rising-Edge.
 *
 * @author Stefan Schubert
 * @date
 * @hint Manchester-Signals are represented by the Enum ManchesterSignal.
 */
component ManchesterEncode {
     
     port
         in EtherMsg fromMac,
         out ManchesterSignal toBus;

}