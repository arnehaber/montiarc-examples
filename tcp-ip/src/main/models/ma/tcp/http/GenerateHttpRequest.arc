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
 * @brief Component {@code GenerateHttpRequest} generates a HTTP-GET-Request.
 *
 * Componente {@code GenerateHttpRequest} generates a HTTP-GET-Request from requested URL in String form.
 * This is done by putting the specific GET-Header on the front of the requested URL and seperating the URL into location and requested ressource.
 *
 * @author Stefan Schubert
 * @date
 * @hint Until now this only works for requested .html documents
 */
component GenerateHttpRequest {
    
    port
        in TupelS fromDns,
        out TupelS toUtf8Encode;

}