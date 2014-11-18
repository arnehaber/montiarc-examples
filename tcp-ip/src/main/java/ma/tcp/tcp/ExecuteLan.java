/*
 * Copyright (c) 2014 RWTH Aachen. All rights reserved.
 *
 * http://www.se-rwth.de/
 */
package ma.tcp.tcp;

import java.util.Observable;
import java.util.Observer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import sim.IScheduler;
import sim.error.SimpleErrorHandler;
import sim.generic.Tick;
import sim.port.LoggingPortFactory;
import sim.port.ObservablePort;
import sim.sched.SchedulerFactory;
import ma.tcp.tcpIpStack.gen.factories.LanFactory;
import ma.tcp.tcpIpStack.gen.interfaces.ILan;

/**
 * TODO: Write me!
 *
 * @author  (last commit) $Author$
 * @version $Revision$,
 *          $Date$
 * @since   TODO: add version number
 *
 */
public class ExecuteLan {
    
    public static void main(String[] args) {
        ILan lan = LanFactory.create();
        IScheduler s = SchedulerFactory.createDefaultScheduler();
        Logger logger = LoggerFactory.getLogger(ExecuteLan.class);
        s.setPortFactory(new LoggingPortFactory(logger, false));
        lan.setup(s, new SimpleErrorHandler());
        
        ObservablePort<String> p1 = new ObservablePort<String>();
        p1.addObserver(new Observer() {
            
            @Override
            public void update(Observable o, Object arg) {
                System.out.println("p1" + arg);
            }
        });
        lan.setTo1(p1);
        ObservablePort<String> p2 = new ObservablePort<String>();
        p2.addObserver(new Observer() {
            
            @Override
            public void update(Observable o, Object arg) {
                System.out.println("p2" + arg);
            }
        });
        lan.setTo1(p2);
        Tick<String> tick = new Tick<String>();
        
        lan.getFrom1().accept("www.bsp.de/a.html");
        lan.getFrom2().accept("www.bsp.de/test.html");
        while (true) {
            lan.getFrom1().accept(tick);
            lan.getFrom2().accept(tick);
            
            
        }
    }
    
}
