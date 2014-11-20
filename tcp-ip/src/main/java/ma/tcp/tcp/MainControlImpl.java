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


import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.HelpCollection;
import ma.tcp.TcpFrame;
import ma.tcp.TimedTupelT;
import ma.tcp.TupelT;
import ma.tcp.tcp.gen.AMainControl;

/**
 * This implementation is the implementation of the MainControl, the main component of the Tcp
 * component. It establishes a Three-Way-Handshake for connection and disconnection and is used to
 * send datablock for which an acknowledge hasn't arrived after a expected period of time. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class MainControlImpl extends AMainControl {
    
    // We collect incoming segments in the datablock queue, because segments
    // between each tick represent a whole block
    private Queue<TupelT> datablock;
    
    // We collect all datablocks in the allBlock queue, to iterate over it when we
    // want to send
    private Queue<Queue<TupelT>> allBlocks;
    
    // Incoming Tupels get collected in the receive queue
    private Queue<TupelT> receive;
    
    // Even if it is basically possible in tcp, to be connected to multiple
    // stations, we reduce it to one connection for modelling purpose
    private Connection status;
    
    // finally, we need to save tupels that have been sended as TimedTupels to
    // watch there aging
    private Queue<TimedTupelT> saved;
    
    // we always save the last TupelT we send, to generate a fin if nessesary
    private TupelT lastSend;
    
    // The min Time, we send a block again
    public final long MIN_RESENDTIME = 1;
    
    private long resendT;
    
    /**
     * @param resendTime The pre-given time after which we want to re-send an un-acknowledged frame.
     */
    public MainControlImpl(long resendTime) {
        super(resendTime);
        if (resendTime < MIN_RESENDTIME) {
            resendT = MIN_RESENDTIME;
        }
        else {
            resendT = resendTime;
        }
        
        datablock = new LinkedList<TupelT>();
        allBlocks = new LinkedList<Queue<TupelT>>();
        receive = new LinkedList<TupelT>();
        status = Connection.NOT_CONNECTED;
        saved = new LinkedList<TimedTupelT>();
    }
    
    @Override
    public void treatFromFragment(TupelT message) {
        datablock.offer(message);
    }
    
    @Override
    public void treatFromCs(TupelT message) {
        receive.offer(message);
    }
    
    /**
     * This is a method to handle our receive. it responds to SYN with SYN-ACK to FIN with FIN-ACK
     * to SYN-ACK with ACK to FIN-ACK with ACK to ACKs with removing TimedTupels.
     * 
     * @return Returns the Type, such as ACK, FIN, etc, of the handled Message, so we can react
     * further to it outside of this method
     */
    public Type receive() {
        if (!receive.isEmpty()) {
            // peek the Tuple and get its flag
            TupelT rec = receive.peek();
            byte flag = rec.getPayload().getPayload()[13];
            String sFlag = HelpCollection.convertToBinary(flag).substring(2);
            
            if (sFlag.charAt(4) == '1') { // SYN
                if (sFlag.charAt(1) == '1') { // SYN-ACK
                    // Remove Syn-Ack
                    receive.remove();
                    // Generate Ack for the SYN-ACK
                    TupelT tAck = generateAck(rec);
                    // send ack
                    sendToCs(tAck);
                    return Type.SYN_ACK;
                }
                else { // SYN
                    // Remove Syn
                    receive.remove();
                    // generate SYN-ACK for the SYN and send it
                    TupelT synAck = generateSynAck(rec);
                    // Sende Syn-Ack
                    sendToCs(synAck);
                    return Type.SYN;
                }
            }
            else if (sFlag.charAt(5) == '1') { // FIN
                if (sFlag.charAt(1) == '1') { // FIN-ACK
                    // Remove FIN-Ack
                    receive.remove();
                    // Generate Ack for the FIN-ACK
                    TupelT tAck = generateAck(rec);
                    // send ack
                    sendToCs(tAck);
                    return Type.FIN_ACK;
                }
                else { // FIN
                    // Remove FIN
                    receive.remove();
                    // Generate FIN-ACK for the FIN
                    TupelT finAck = generateFinAck(rec);
                    // Send FIN-ACK
                    sendToCs(finAck);
                    return Type.FIN;
                }
            }
            else if (sFlag.charAt(1) == '1') { // it's an ack
                // remove ack
                receive.remove();
                // remove from saved TimedTupelTs
                if (!saved.isEmpty()) {
                    saved.remove();
                }
                return Type.ACK;
            }
            else { // is data
                // Remove data
                receive.remove();
                // pass data on
                sendToPortD(rec);
                // generate ACK for the data
                TupelT ack = generateAck(rec);
                // send ack
                sendToCs(ack);
                return Type.NONE;
            }
        }
        return Type.NONE;
    }
    
    private long inc(long l) {
        if (l == (long) Math.pow(2, 32)) {
            l = 0;
        }
        else {
            l = l + 1;
        }
        return l;
    }
    
    public TupelT generateSyn(TupelT from) {
        // To generate the syn, we copy ip and the payload-header (the first 20
        // bytes)
        TupelT syn = new TupelT();
        syn.setIp(from.getIp());
        byte[] synPay = new byte[20];
        /* we really COPY. if we would say "synPay = toConnect.getPayload.getPayload" every change
         * in synPay would result in changes in toConnect */
        for (int i = 0; i < synPay.length; i++) {
            synPay[i] = from.getPayload().getPayload()[i];
        }
        // Set the syn bit
        String flag = "00000010";
        byte resFlag = Byte.parseByte(flag, 2);
        synPay[13] = resFlag;
        TcpFrame synFrame = new TcpFrame();
        synFrame.setPayload(synPay);
        syn.setPayload(synFrame);
        return syn;
    }
    
    public TupelT generateSynAck(TupelT from) {
        // Generiere Syn-Ack
        TupelT synAck = new TupelT();
        byte[] destIp = from.getIp();
        byte[] synAckPay = new byte[20];
        // SourcePort is destPort from the syn
        synAckPay[0] = from.getPayload().getPayload()[2];
        synAckPay[1] = from.getPayload().getPayload()[3];
        // DestPort is sourceport from the syn
        synAckPay[2] = from.getPayload().getPayload()[0];
        synAckPay[3] = from.getPayload().getPayload()[1];
        /* Seq number is irrelevant, because in this convention, syn,fin and acks don't contain
         * data, so we set it to 0 */
        for (int i = 0; i < 4; i++) {
            synAckPay[4 + i] = 0;
        }
        // Acknowledge number is sequence number from syn + 1
        byte[] ackNr = new byte[4];
        byte[] seqNr = new byte[4];
        // Get the seq nr
        for (int i = 0; i < 4; i++) {
            seqNr[i] = from.getPayload().getPayload()[4 + 1];
        }
        long lSeqNr = Long.parseLong(HelpCollection.convertToBinary(seqNr), 2);
        // increase seq nr
        lSeqNr = inc(lSeqNr);
        ackNr = HelpCollection.convertToByteArray(HelpCollection.convertToBinary(lSeqNr), 4);
        for (int i = 0; i < 4; i++) {
            synAckPay[8 + i] = ackNr[i];
        }
        // pad the rest with zeros
        for (int i = 12; i < synAckPay.length; i++) {
            synAckPay[i] = 0;
        }
        // Set flag
        String synAckFlag = "00010010";
        byte bSynAckFlag = Byte.parseByte(synAckFlag, 2);
        synAckPay[13] = bSynAckFlag;
        // generate complete syn-ack
        TcpFrame tcpSynAck = new TcpFrame();
        tcpSynAck.setPayload(synAckPay);
        synAck.setPayload(tcpSynAck);
        synAck.setIp(destIp);
        return synAck;
    }
    
    public TupelT generateFin(TupelT from) {
        // generate FIN and send it
        TupelT fin = new TupelT();
        TcpFrame tcpFin = new TcpFrame();
        byte[] tcpFinPay = new byte[20];
        // the source port is the sourcePOrt from the lastSend
        tcpFinPay[0] = from.getPayload().getPayload()[0];
        tcpFinPay[1] = from.getPayload().getPayload()[1];
        // the destport is the destPort from the lastSend
        tcpFinPay[2] = from.getPayload().getPayload()[2];
        tcpFinPay[3] = from.getPayload().getPayload()[3];
        // the seq number is irrelevant, because our syn, fin, acks don't
        // contain data, so we set it to 0
        for (int i = 0; i < 4; i++) {
            tcpFinPay[4 + i] = 0;
        }
        // its no ack, so we set the ackNr to 0
        // set ack nr
        for (int i = 0; i < 4; i++) {
            tcpFinPay[8 + i] = 0;
        }
        // pad the rest with zeros
        for (int i = 12; i < tcpFinPay.length; i++) {
            tcpFinPay[i] = 0;
        }
        // set the flag
        String finFlag = "00000001";
        byte bFinFlag = Byte.parseByte(finFlag, 2);
        tcpFinPay[13] = bFinFlag;
        // generate the complete fin
        tcpFin.setPayload(tcpFinPay);
        // dest ip is the dest ip from the lastSend
        fin.setIp(from.getIp());
        fin.setPayload(tcpFin);
        return fin;
    }
    
    public TupelT generateFinAck(TupelT from) {
        // Generate Fin-Ack
        TupelT finAck = new TupelT();
        TcpFrame tcpFinAck = new TcpFrame();
        byte[] tcpFinAckPay = new byte[20];
        // the source port is the destport from the fin
        tcpFinAckPay[0] = from.getPayload().getPayload()[2];
        tcpFinAckPay[1] = from.getPayload().getPayload()[3];
        // the destport is the sourceport from the fin
        tcpFinAckPay[2] = from.getPayload().getPayload()[0];
        tcpFinAckPay[3] = from.getPayload().getPayload()[1];
        // the seq number is irrelevant, because out syn, fin, acks don't
        // contain data, so we set it to 0
        for (int i = 0; i < 4; i++) {
            tcpFinAckPay[4 + i] = 0;
        }
        // the ack nr is the seq nr from the fin +1
        byte[] seqNr = new byte[4];
        for (int i = 0; i < seqNr.length; i++) {
            seqNr[i] = from.getPayload().getPayload()[4 + i];
        }
        long lSeqNr = Long.parseLong(HelpCollection.convertToBinary(seqNr), 2);
        // increase ack nr
        lSeqNr = inc(lSeqNr);
        byte[] ackNr = HelpCollection.convertToByteArray(HelpCollection.convertToBinary(lSeqNr), 4);
        // set ack nr
        for (int i = 0; i < ackNr.length; i++) {
            tcpFinAckPay[8 + i] = ackNr[i];
        }
        // pad the rest with zeros
        for (int i = 12; i < tcpFinAckPay.length; i++) {
            tcpFinAckPay[i] = 0;
        }
        // set the flag
        String finAckFlag = "00010001";
        byte bFinAckFlag = Byte.parseByte(finAckFlag, 2);
        tcpFinAckPay[13] = bFinAckFlag;
        // generate the complete fin ack
        tcpFinAck.setPayload(tcpFinAckPay);
        // dest ip is the source ip from the fin
        finAck.setIp(from.getIp());
        finAck.setPayload(tcpFinAck);
        return finAck;
    }
    
    public TupelT generateAck(TupelT from) {
        // Generate Ack for the just received SYN-Ack
        byte[] ack = new byte[20];
        byte[] seqNr = new byte[4];
        byte[] ackNr = new byte[4];
        // Source Port is the dest port from the syn-ack
        ack[0] = from.getPayload().getPayload()[2];
        ack[1] = from.getPayload().getPayload()[3];
        // Dest Port of this Ack is the Source Port of the received
        // Syn-Ack
        ack[2] = from.getPayload().getPayload()[0];
        ack[3] = from.getPayload().getPayload()[1];
        
        // Sequence Number is the ack number of the just received syn-ack
        for (int i = 0; i < 4; i++) {
            ack[4 + i] = from.getPayload().getPayload()[8 + 1];
        }
        // Acknowledge number is the seq number+1 of the syn ack
        for (int i = 0; i < 4; i++) {
            seqNr[i] = from.getPayload().getPayload()[4 + i];
        }
        // Get the Seq Nr
        long lAckNr = Long.parseLong(HelpCollection.convertToBinary(seqNr), 2);
        // Increase the seq nr
        lAckNr = inc(lAckNr);
        ackNr = HelpCollection.convertToByteArray(HelpCollection.convertToBinary(lAckNr), 4);
        for (int i = 0; i < 4; i++) {
            ack[8 + 1] = ackNr[i];
        }
        // Pad the rest with 0s
        for (int i = 12; i < ack.length; i++) {
            ack[i] = 0;
        }
        // Set the flag
        String ackFlag = "00010000";
        byte bAckFlag = Byte.parseByte(ackFlag, 2);
        ack[13] = bAckFlag;
        // Generate complete Ack
        TupelT tAck = new TupelT();
        tAck.setIp(from.getIp());
        TcpFrame tcpAck = new TcpFrame();
        tcpAck.setPayload(ack);
        tAck.setPayload(tcpAck);
        return tAck;
    }
    
    @Override
    public void preTimeIncreased() {
        /* For sending, there first has to be something to send. Data to send means, we have a
         * datablock to send, because from the Application Layer we always get whole datablocks,
         * that get segmented in the fragmentation We receive them in the form of
         * (segment_of_block1, segment_of_block1, segment_of_block1, Tk, segment_of_block2,
         * segment_of_block2, Tk, and so on) So, if we have TupelTs in the datablock queue when
         * receiving a tick, we put a copy of the datablock queue in the allBlocks queue */
        
        if (!datablock.isEmpty()) {
            allBlocks.offer(datablock);
            datablock = new LinkedList<TupelT>();
        }
        
        /* Until here, allBlocks contains all received data in form of queues of the segments. If
         * allBlocks isn't empty, we now check, if we are connected (variable status): if
         * NOT_CONNECTED: we send a syn and switch to WAIT_FOR_CONNECTION. if WAIT_FOR_CONNECTION:
         * wait for the syn ack, send an ack an switch to CONNECTED. if CONNECTED: check, if current
         * datablock still contains segments: if so: send TupelT from the current. if not: send fin
         * and switch to WAIT_FOR_DISCONNECT. if WAIT_FOR_DISCONNECT: wait for fin ack, send ack and
         * switch to NOT_CONNECTED */
        
        if (!allBlocks.isEmpty()) {
            if (status == Connection.NOT_CONNECTED) {
                /* We're not connected and want to send something this means we have to open a
                 * connection by sending a syn since were trying to estalish a connection we switch
                 * status to WAITING_FOR_CONNECTION */
                
                TupelT toConnect = allBlocks.peek().peek();
                TupelT syn = generateSyn(toConnect);
                // Send syn-ack and change status
                sendToCs(syn);
                status = Connection.WAITING_FOR_CONNECTION;
                receive();
            }
            
            // ------------------------------------------------------------------------------
            
            else if (status == Connection.WAITING_FOR_CONNECTION) {
                /* Here, we wait for an arriving SYN-ACK if we get it, we change status to connected */
                
                Type t = receive();
                if (t == Type.SYN_ACK) {
                    status = Connection.CONNECTED;
                }
            }
            
            // ------------------------------------------------------------------------------
            
            else if (status == Connection.CONNECTED) {
                /* Here, we send one segment each tick. every segment is saved as a TimedTupel to
                 * watch it age. */
                
                if (!allBlocks.peek().isEmpty()) {
                    // fetch data to send
                    TupelT toSend = allBlocks.peek().remove();
                    // generate TimedTupel
                    TimedTupelT timedToSend = new TimedTupelT(resendT);
                    timedToSend.setTupel(toSend);
                    // send data
                    sendToCs(toSend);
                    // Save TimedTupel
                    saved.add(timedToSend);
                    // We also save the last send Tupel, to generate the FIN, if there isn't anymore
                    // to send
                    lastSend = toSend;
                }
                
                else {
                    /* if there are no more Tupels to send, we send a FIN and switch to
                     * WAIT_FOR_DISCONNECT */
                    TupelT fin = generateFin(lastSend);
                    // send fin
                    sendToCs(fin);
                    // remove the empty queue from the allblocks queue
                    allBlocks.remove();
                    status = Connection.WAIT_FOR_DISCONNECT;
                }
                
                receive();
                
            }
            
            // ------------------------------------------------------------------------------
            
            else if (status == Connection.WAIT_FOR_DISCONNECT) {
                /* Here, we wait for the FIN-ACK. if we receive it, we send an ack and switch to the
                 * NOT_CONNECTED state */
                
                Type t = receive();
                if (t == Type.FIN_ACK) {
                    status = Connection.NOT_CONNECTED;
                }
            }
        }
        
        else {
            /* If there is nothing to send, we switch into the NOT_CONNECTED state, which is equal
             * to a listening state. */
            status = Connection.NOT_CONNECTED;
            receive();
        }
        
        /* At the end, we check all saved TimedTupels, if they decayed. if so, we enqueue them in
         * the sending queue again */
        
        if (!saved.isEmpty()) {
            Queue<TimedTupelT> newSaved = new LinkedList<TimedTupelT>();
            
            for (TimedTupelT t : saved) {
                t.update();
                if (t.getTimer() == 0) {
                    Queue<TupelT> temp = new LinkedList<TupelT>();
                    temp.offer(t.getTupel());
                    allBlocks.offer(temp);
                }
                else {
                    newSaved.offer(t);
                }
            }
            saved = newSaved;
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
