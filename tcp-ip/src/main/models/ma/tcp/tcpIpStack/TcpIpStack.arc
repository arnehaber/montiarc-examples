package ma.tcp.tcpIpStack;

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

import ma.tcp.ManchesterSignal;
import ma.tcp.TupelBPort;
import ma.tcp.TupelB;
import ma.tcp.TupelT;
import ma.tcp.IpFrame;
import ma.tcp.DataLinkFrame;

import ma.tcp.layer.*;
import ma.sim.FixDelay;

/**
 * @brief Component {@code TcpIpStack} represents the TCP/IP-Stack.
 *
 * The component {@code TcpIpStack} represents the whole TCP/IP-Stack with it's four Layers.
 * These are represented by {@link ma.tcp.layer.ApplicationLayer}, {@link ma.tcp.layer.TransportLayer}, {@link ma.tcp.layer.InternetLayer} and {@link ma.tcp.layer.DataLinkLayer}.
 * These layers each contain the functionalities of their main protocol and possibly supporting reduced components like {@link ma.tcp.simComp.Arp}.
 * These main protocols are {@link ma.tcp.http.Http}, {@link ma.tcp.tcp.Tcp}, {@link ma.tcp.internetProtocol.Ip} and {@link ma.tcp.ethernet.Ethernet}.
 *
 * We use the datatypes {@code ma.tcp.DataLinkFrame}, {@code ma.tcp.IpFrame}, {@code ma.tcp.TcpFrame} and {@code ma.tcp.TupelB} mostly for communication between the layers.
 * {@code ma.tcp.DataLinkFrame} represent frames for or from the Data-Link Layer, {@code ma.tcp.IpFrame} for or from the Internet-Layer, 
 * {@code ma.tcp.TcpFrame} for or from the Transport Layer and {@code ma.tcp.TupelB} for or from the Application Layer.
 * There are also frames, we use when we are in a protocol, like {@code ma.tcp.EtherMsg} for ethernet and and {@code ma.tcp.IpFrame} for IP.
 *
 * For calculating operations concering bits or the changing from a byte array into a string, we use the {@code ma.tcp.HelpCollection}, containing methods for simplifing
 * the handling of bits and byte arrays. 
 *
 * @hint Use two of these to simulate the smallest possible LAN.
 * @author Stefan Schubert
 * @date
 */
component TcpIpStack {

    autoconnect port;

    port
        in String fromBrowser,
        in ManchesterSignal fromBus,
        out String toBrowser,
        out ManchesterSignal toBus;
        
    component ApplicationLayer applicationLayer;
    component TransportLayer transportLayer;
    component InternetLayer internetLayer;
    component DataLinkLayer datalinkLayer;
    component FixDelay<TupelBPort>(1) appTran;
    component FixDelay<TupelB>(1) tranApp;
    component FixDelay<TupelT>(1) tranIp, ipTran;
    component FixDelay<IpFrame>(1) ipData;
    component FixDelay<DataLinkFrame>(1) dataIp;
    
    
    connect applicationLayer.toTransport -> appTran.portIn;
    connect appTran.portOut -> transportLayer.fromApp;
    connect transportLayer.toApp -> tranApp.portIn;
    connect tranApp.portOut -> applicationLayer.fromTransport;
    connect transportLayer.toInternet -> tranIp.portIn;
    connect tranIp.portOut -> internetLayer.fromTransport;
    connect internetLayer.toTransport -> ipTran.portIn;
    connect ipTran.portOut -> transportLayer.fromInternet;
    connect internetLayer.toDataLink -> ipData.portIn;
    connect ipData.portOut -> datalinkLayer.fromIp;
    connect datalinkLayer.toIp -> dataIp.portIn;
    connect dataIp.portOut -> internetLayer.fromDataLink;    
    

}