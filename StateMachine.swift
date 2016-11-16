//
//  StateMachine.swift
//
//
//  Created by Jordan Trana on 11/14/16.
//  Copyright © 2016 Jordan Trana. All rights reserved.
//

import GameplayKit




class State : NSObject{
    
    public var key:String? = nil
    
    private var enterCallback:(() -> ())? = nil
    private var updateCallback:(() -> ())? = nil
    private var playCallback:(() -> ())? = nil
    private var pauseCallback:(() -> ())? = nil
    private var exitCallback:(() -> ())? = nil
    
    
    init(key:String){
        self.key = key
    }
    
    init(key:String, enter:(() -> ())?, update:(() -> ())?, exit:(() -> ())?){
        self.key = key
        self.enterCallback = enter
        self.updateCallback = update
        self.exitCallback = exit
    }
    
    init(key:String, enter:(() -> ())?, update:(() -> ())?, play:(() -> ())?, pause:(() -> ())?, exit:(() -> ())?){
        self.key = key
        self.enterCallback = enter
        self.updateCallback = update
        self.playCallback = play
        self.pauseCallback = pause
        self.exitCallback = exit
    }
    
    func enter(){
        if(enterCallback != nil){
            enterCallback!()
        }
    }
    
    func update(){
        if(updateCallback != nil){
            updateCallback!()
        }
    }
    
    func play(){
        if(playCallback != nil){
            playCallback!()
        }
    }
    
    func pause(){
        if(pauseCallback != nil){
            pauseCallback!()
        }
    }
    
    func exit(){
        if(exitCallback != nil){
            exitCallback!()
        }
    }
}


class StateMachine : NSObject {
    
    var states:[String:State] = [String:State]()
    var currentState:State? = nil
    var paused:Bool = false
    var delegate:AnyObject? = nil
    var ticks:Int = 0
    
    init(delegate:AnyObject){
        self.delegate = delegate
    }
    
    func initState(key:String){
        let newState = State(key: key)
        states[key] = newState
    }
    
    func initState(key:String, enter:(() -> ())?, update:(() -> ())?, exit:(() -> ())?){
        let newState = State(key: key, enter: enter, update: update, exit: exit)
        states[key] = newState
    }
    
    func initState(key:String, enter:(() -> ())?, update:(() -> ())?, play:(() -> ())?, pause:(() -> ())?, exit:(() -> ())?){
        let newState = State(key: key, enter: enter, update: update, play: play, pause: pause, exit: exit)
        states[key] = newState
    }
    
    func setState(key:String){
        let state:State? = states[key]
        if(state != nil && currentState != state){
            // Exit Old State
            if(currentState != nil){
                currentState!.exit()
            }
            
            // Reset Ticks
            ticks = 0
            
            // Set New State
            currentState = state
            currentState?.enter()
        }
    }
    
    func getState(key:String) -> State?{
        return states[key]
    }
    
    func update(){
        
        if(paused){
            return
        }
        
        currentState?.update()
        ticks += 1
    }
    
    func play(){
        paused = false
    }
    
    func pause(){
        paused = true
    }
    
    
}
