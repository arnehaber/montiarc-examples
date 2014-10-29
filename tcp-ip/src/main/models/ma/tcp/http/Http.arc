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

import ma.tcp.TupelB;
import ma.tcp.TupelBPort;
import ma.tcp.simComp.*;
import ma.sim.*;

/**
 * @brief Component {@code Http} represents the HTTProtocol.
 *
 * Componente {@code Http} represents HTTP with its functionalities.
 * These include {@link ma.tcp.simComp.Dns}, {@link GenerateHttpRequest}, {@link Utf8Encode}, {@link Utf8Decode}, {@link Decider}, {@link Interpreter} and {@link GenerateHttpResponse}. 
 * By using the subcomponents, browser requests in form of an URL get translated into a datagram containing a HTTP-GET-Request which gets passed on to the {@link ma.tcp.layer.TransportLayer}.
 * Also the {@code Http} component answers to HTTP-GET-Requests it received by sending a html document back to the requester.
 * 
 * @hint Note that {@link ma.tcp.simComp.Dns} isn't really located on in the HTTProtocol, but because in this simulation it's a very drastic reduction of the real DNS functionalities, we put it here, because is makes things easier.
 * @author Stefan Schubert
 * @date
 */
component Http {
    port
        in String fromBrowser,
        in TupelB fromTransport,
        out TupelBPort toTransport,
        out String toBrowser;
        
        component Dns dns;
        component GenerateHttpRequest generateRequest;
        component Utf8Encode encode;
        component Utf8Decode decode;
        component Decider decide;
        component Interpreter interpret;
        component GenerateHttpResponse generateResponse;
        
        connect fromBrowser -> dns.url;
        connect dns.toGenerate -> generateRequest.fromDns;
        connect generateRequest.toUtf8Encode -> encode.fromGenerate;        
        connect encode.toTransport -> toTransport;
        connect fromTransport -> decode.fromTransport;
        connect decode.toDecide -> decide.fromUtf8Decode;        
        connect decide.toResponse -> generateResponse.fromDecider;
        connect generateResponse.toEncode -> encode.fromResponse;        
        connect decide.toInterpret -> interpret.inPort;
        connect interpret.outPort -> toBrowser;
        

}