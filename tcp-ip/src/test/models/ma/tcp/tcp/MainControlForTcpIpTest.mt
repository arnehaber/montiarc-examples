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


import ma.tcp.TupelT;

testsuite MainControlForTcpIpTest for MainControl(30000000) {
    
     TupelT encapsed;
     TupelT syn;
     TupelT synAck;
     TupelT ack1;
     TupelT fin;
     TupelT finAck;
     TupelT ack2;
     TupelT ack;
    
     ma.tcp.TransportFrame tEncapsed;
     ma.tcp.TransportFrame tSyn;
     ma.tcp.TransportFrame tSynAck;
     ma.tcp.TransportFrame tAck1;
     ma.tcp.TransportFrame tFin;
     ma.tcp.TransportFrame tFinAck;
     ma.tcp.TransportFrame tAck2;
     ma.tcp.TransportFrame tAck;
    
    @Before {
        encapsed = new TupelT();
        encapsed.setIp(new byte[]{100,100,100,100});
        tEncapsed = new ma.tcp.TransportFrame();
        tEncapsed.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
        encapsed.setPayload(tEncapsed); 
        
        syn = new TupelT();
        tSyn = new ma.tcp.TransportFrame();
        tSyn.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,0,0,0,0});
        syn.setIp(new byte[]{100,100,100,100});
        syn.setPayload(tSyn);
        
        synAck = new TupelT();
        tSynAck = new ma.tcp.TransportFrame();
        tSynAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,18,0,0,0,0,0,0});
        synAck.setIp(new byte[]{100,100,100,100});
        synAck.setPayload(tSynAck);
        
        ack1 = new TupelT();
        tAck1 = new ma.tcp.TransportFrame();
        tAck1.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0});
        ack1.setIp(new byte[]{100,100,100,100});
        ack1.setPayload(tAck1);
        
        fin = new TupelT();
        tFin = new ma.tcp.TransportFrame();
        tFin.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0});
        fin.setIp(new byte[]{100,100,100,100});
        fin.setPayload(tFin);
        
        finAck = new TupelT();
        tFinAck = new ma.tcp.TransportFrame();
        tFinAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,17,0,0,0,0,0,0});
        finAck.setIp(new byte[]{100,100,100,100});
        finAck.setPayload(tFinAck);
        
        ack2 = new TupelT();
        tAck2 = new ma.tcp.TransportFrame();
        tAck2.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0});
        ack2.setIp(new byte[]{100,100,100,100});
        ack2.setPayload(tAck2);
        
        ack = new TupelT();
        tAck = new ma.tcp.TransportFrame();
        tAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0});
        ack.setIp(new byte[]{100,100,100,100});
        ack.setPayload(tAck);
            
    }
    
    test empty{
        input{
            fromFragment: <100*Tk>;
            fromCs: <100*Tk>;
        }
        expect{
            toCs: <100*Tk>;
            toPortD: <100*Tk>;
        }
    }
    
    test threeWayHandshake{
        input{
            fromFragment: <encapsed, 5*Tk>;
            fromCs: <Tk, synAck, Tk, Tk, Tk, finAck, Tk>;
        }
        expect{
            toCs: <syn, Tk, ack1, Tk, encapsed, Tk, fin, Tk, ack2, Tk>;
            toPortD: <5*Tk>;
        }
    }
    
    test receiveandAckSingle{
        input{
            fromFragment: <Tk>;
            fromCs: <encapsed, Tk>;
        }
        expect{
            toCs: <ack, Tk>;
            toPortD: <encapsed, Tk>;
        }
    }
    
    test receiveandAckMultiple{
        input{
            fromFragment: <5*Tk>;
            fromCs: <5*(encapsed, Tk)>;
        }
        expect{
            toCs: <5* (ack, Tk)>;
            toPortD: <5* (encapsed, Tk)>;
        }
    }    
    
    test reactToConnectAttempt{
        input{
            fromFragment: <5*Tk>;
            fromCs: <syn, Tk, ack1, Tk, encapsed, Tk, fin, Tk, ack2, Tk>;
        }
        expect{
            toCs: <synAck, Tk, Tk, ack, Tk, finAck, Tk, Tk>;
            toPortD: <Tk, Tk, encapsed, Tk, Tk, Tk>;
        }
    }
    
}