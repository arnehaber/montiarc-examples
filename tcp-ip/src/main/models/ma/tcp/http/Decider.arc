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

import ma.tcp.TupelS;
 
/**
 * @brief Component {@code Decider} is used for deciding, wether the message is a Respond or Request.
 *
 * Componente {@code Decider} is used to decider, wether a message, we received in the HTTP-Protocol is
 * a HTTP-GET-Request or HTTP-RESPONSE-Response.
 * Requests get passed on to the {@link GenerateHttpResponse} component and Responses get passed to the {@link Interpreter} component.
 *
 * @author Stefan Schubert
 * @date
 */
component Decider {
    port
        in TupelS fromUtf8Decode,
        out TupelS toResponse,
        out String toInterpret;

}