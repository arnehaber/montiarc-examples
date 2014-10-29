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


import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.EtherFrame;
import ma.tcp.EtherJam;
import ma.tcp.EtherMsg;
import ma.tcp.ethernet.gen.ACsmaCd;

/**
 * This represents the Implementation of the Carrier Sense Multiple Access with Collision Detection.
 * For a more detailed description see the component documentation of the CsmaCd component. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class CsmaCdImpl extends ACsmaCd {
    
    private Queue<EtherFrame> send;
    
    private Queue<EtherMsg> receive;
    
    private Queue<EtherFrame> sendSaver;
    
    private Queue<EtherFrame> receiveSaver;
    
    private int ifs; // time between frames
    
    private int checkTime; // time to wait after one send
    
    private int waitCount; // counter for ifs
    
    private int sendCount; // counter for checktime
    
    // the state n which we are
    private boolean sending;
    
    // The minimum listening and sending times
    public final int MIN_LISTENTIME = 1;
    
    public final int MIN_SENDTIME = 2;
    
    public CsmaCdImpl(int listenTime, int sendTime) {
        super(listenTime, sendTime);
        
        send = new LinkedList<EtherFrame>();
        receive = new LinkedList<EtherMsg>();
        sendSaver = new LinkedList<EtherFrame>();
        receiveSaver = new LinkedList<EtherFrame>();
        
        if (listenTime < MIN_LISTENTIME) {
            ifs = MIN_LISTENTIME;
        }
        else {
            ifs = listenTime;
        }
        
        if (sendTime < MIN_SENDTIME) {
            checkTime = MIN_LISTENTIME;
        }
        else {
            checkTime = sendTime;
        }
        
        waitCount = 0;
        sendCount = 0;
        sending = false;
    }
    
    // Helping method, to check, if a payload represents a jam
    public boolean jam(byte[] pay) {
        if (pay.length == 4) {
            for (int i = 0; i < pay.length; i++) {
                if (pay[i] != -86) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }
    
    @Override
    public void treatFromLlc(EtherFrame message) {
        send.offer(message);
    }
    
    @Override
    public void treatFromPs(EtherMsg message) {
        receive.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        // First we check, if we are already sending
        if (sending) {
            // If we send, we check if we also receive, because this would mean a jam
            if (!receive.isEmpty()) {
                // If theres a jam, we signal it, by sending the jam signal
                EtherJam jam = new EtherJam();
                EtherMsg msg = new EtherMsg();
                msg.setPayload(jam.getPayload());
                sendToPs(msg);
                receive.remove(); // Forget the last received, because it is corrupted
                sendCount = 0;
                waitCount = 0;
                sending = false;
            }
            else {
                // If there is no collision, we wait, until we have reached the nessessary time to
                // send again
                if (sendCount < checkTime) {
                    sendCount++;
                }
                else {
                    // we waited long enough to know, that the last frame arrived ok.
                    // Now we can "forget" the last on we saved
                    sendSaver.clear();
                    // if there still is something to send, we send
                    if (!send.isEmpty()) {
                        EtherFrame f = send.remove();
                        sendSaver.add(f); // save, what we are going to send
                        EtherMsg msg = new EtherMsg();
                        msg.setPayload(f.getPayload());
                        sendToPs(msg); // send next one
                    }
                    // if theres nothing to send anymore, we swith states to not sending and reset
                    // the station
                    else {
                        sending = false;
                    }
                    waitCount = 0;
                    sendCount = 0;
                }
            }
        }
        // if we're not sending, we check, if we can receive something
        // if so, we need to check, if its a jam or if we can pass it on.
        // we keep received frames until we know the next one is no jam
        else {
            if (!receive.isEmpty()) {
                if (jam(receive.peek().getPayload())) {
                    receive.remove();
                    receiveSaver.clear(); // Forget the last receive, because it is corrupted
                }
                else {
                    if (!receiveSaver.isEmpty()) {
                        sendToLlc(receiveSaver.remove()); // pass on the last saved
                        EtherMsg msg = receive.remove(); // Explicit cast here, because implicid
                                                         // seems to cause problems with the tests
                        EtherFrame f = new EtherFrame();
                        f.setPayload(msg.getPayload());
                        receiveSaver.add(f);
                    }
                    else {
                        EtherMsg msg = receive.remove();
                        EtherFrame f = new EtherFrame();
                        f.setPayload(msg.getPayload());
                        receiveSaver.add(f);
                    }
                }
            }
            else {
                if (!receiveSaver.isEmpty()) { // Last one received properly. we know this, because
                                               // no jam arrived
                    sendToLlc(receiveSaver.remove()); // pass on the last saved receive
                }
                // if there is something to send, while there is nothing to receive, we listen for
                // the listenTime and send afterwards
                if (!send.isEmpty()) {
                    if (waitCount < ifs) {
                        waitCount++;
                    }
                    else {
                        // beeing here with something in the saver means, there was a jam last time,
                        // so, we send it again
                        if (!sendSaver.isEmpty()) {
                            EtherMsg msg = new EtherMsg();
                            EtherFrame f = sendSaver.remove();
                            msg.setPayload(f.getPayload());
                            sendToPs(msg);
                        }
                        // nothing in the saver means, last send finished normally or transmission
                        // is just starting
                        else {
                            sendSaver.add(send.peek()); // save, what we want to send now
                            EtherFrame f = send.remove();
                            EtherMsg msg = new EtherMsg();
                            msg.setPayload(f.getPayload());
                            sendToPs(msg); // send
                        }
                        sendCount = 0;
                        waitCount = 0;
                        sending = true;
                    }
                }
                else { // nothing to send
                    if (!sendSaver.isEmpty()) {
                        while (!sendSaver.isEmpty()) {
                            send.add(sendSaver.remove());
                        }
                    }
                    sendCount = 0;
                    waitCount = 0;
                    sending = false;
                }
            }
        }
    }
    
    /**
     * @see sim.generic.ATimedComponent#timeIncreased()
     */
    @Override
    protected void timeIncreased() {
        // TODO Auto-generated method stub
        
    }
}
