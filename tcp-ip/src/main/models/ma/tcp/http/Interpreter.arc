package ma.tcp.http;

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
 * @brief Component {@code Interpreter} interprets a HTTP-RESPONSE.
 *
 * Componente {@code Interpreter} interprets a HTTP-RESPONSe containing a html document by dropping the specific HTTP-RESPONSE header.
 * This is simply done by cutting the string containing the response at the \n\n position.
 *
 * @author Stefan Schubert
 * @date
 */
component Interpreter {
    port
        in String inPort,
        out String outPort;
}