# SwiftStateMachine
Swift 3.0 StateMachine for Games and Animation

Enter - Callback for a State after it has replaced another
Update - Callback for when the StateMachine recieves the Update call
Play - Callback for when a State has Unpaused the Update Callback (allowing the update callback to be called)
Pause - Callback for when a State has Paused the Update Callback (preventing the update callback from being called)
Exit - Callback for a State before it is replaced by another
