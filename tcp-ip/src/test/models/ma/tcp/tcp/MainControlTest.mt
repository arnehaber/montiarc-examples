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

testsuite MainControlTest for MainControl(30000000) {
    
     TupelT f;
     TupelT syn;
     TupelT synAck;
     TupelT ack1;
     TupelT fin;
     TupelT finAck;
     TupelT ack2;
     TupelT ackF;
    
     ma.tcp.TransportFrame fT;
     ma.tcp.TransportFrame synT;
     ma.tcp.TransportFrame synAckT;
     ma.tcp.TransportFrame ack1T;
     ma.tcp.TransportFrame finT;
     ma.tcp.TransportFrame finAckT;
     ma.tcp.TransportFrame ack2T;
     ma.tcp.TransportFrame ackFT;
    
     byte[] ip;
     byte[] fPay;
     byte[] synPay;
     byte[] synAckPay;
     byte[] ack1Pay;
     byte[] finPay;
     byte[] finAckPay;
     byte[] ack2Pay;
     byte[] ackFPay;
    
    @Before {
        f = new TupelT();
        syn = new TupelT();
        synAck = new TupelT();
        ack1 = new TupelT();
        fin = new TupelT();
        finAck = new TupelT();
        ack2 = new TupelT();
        ackF = new TupelT();
        
        fT = new ma.tcp.TransportFrame();
        synT = new ma.tcp.TransportFrame();
        synAckT = new ma.tcp.TransportFrame();
        ack1T = new ma.tcp.TransportFrame();
        finT = new ma.tcp.TransportFrame();
        finAckT = new ma.tcp.TransportFrame();
        ack2T = new ma.tcp.TransportFrame();
        ackFT = new ma.tcp.TransportFrame();
        
        ip = new byte[]{10,11,12,13};
        
        fPay = new byte[]{0,100,0,100,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,1,1,1};
        fT.setPayload(fPay);
        f.setIp(ip);
        f.setPayload(fT);
        
        synPay = new byte[]{0,100,0,100,0,0,0,0,0,0,0,0,80,2,0,1,0,0,0,0};
        synT.setPayload(synPay);
        syn.setIp(ip);
        syn.setPayload(synT);
        
        synAckPay = new byte[]{0,100,0,100,0,0,0,0,0,0,0,1,0,18,0,0,0,0,0,0};
        synAckT.setPayload(synAckPay);
        synAck.setIp(ip);
        synAck.setPayload(synAckT);
        
        ack1Pay = new byte[]{0,100,0,100,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0};
        ack1T.setPayload(ack1Pay);
        ack1.setIp(ip);
        ack1.setPayload(ack1T);
        
        finPay = new byte[]{0,100,0,100,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0};
        finT.setPayload(finPay);
        fin.setIp(ip);
        fin.setPayload(finT);
        
        finAckPay = new byte[]{0,100,0,100,0,0,0,0,0,0,0,1,0,17,0,0,0,0,0,0};
        finAckT.setPayload(finAckPay);
        finAck.setIp(ip);
        finAck.setPayload(finAckT);
        
        ack2Pay = new byte[]{0,100,0,100,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0};
        ack2T.setPayload(ack2Pay);
        ack2.setIp(ip);
        ack2.setPayload(ack2T);
        
        ackFPay = new byte[]{0,100,0,100,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0};
        ackFT.setPayload(ackFPay);
        ackF.setIp(ip);
        ackF.setPayload(ackFT);
            
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
            fromFragment: <f, 5*Tk>;
            fromCs: <Tk, synAck, Tk, Tk, Tk, finAck, Tk>;
        }
        expect{
            toCs: <syn, Tk, ack1, Tk, f, Tk, fin, Tk, ack2, Tk>;
            toPortD: <5*Tk>;
        }
    }
    
    test receiveandAckSingle{
        input{
            fromFragment: <Tk>;
            fromCs: <f, Tk>;
        }
        expect{
            toCs: <ackF, Tk>;
            toPortD: <f, Tk>;
        }
    }
    
    test receiveandAckMultiple{
        input{
            fromFragment: <5*Tk>;
            fromCs: <5*(f, Tk)>;
        }
        expect{
            toCs: <5* (ackF, Tk)>;
            toPortD: <5* (f, Tk)>;
        }
    }    
    
    test reactToConnectAttempt{
        input{
            fromFragment: <5*Tk>;
            fromCs: <syn, Tk, ack1, Tk, f, Tk, fin, Tk, ack2, Tk>;
        }
        expect{
            toCs: <synAck, Tk, Tk, ackF, Tk, finAck, Tk, Tk>;
            toPortD: <Tk, Tk, f, Tk, Tk, Tk>;
        }
    }
    
}