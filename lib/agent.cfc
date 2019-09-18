component name="agent" displayname="agent" output="true" { 
    public function init () { 
        // positional information
        this.p = 0;
        this.op = this.p; // old position
        
        this.actions = [0,1,2,3];
        
        this.brain = "";// set from outside

        this.reward_bonus = 0.0;
        this.digestion_signal = 0.0;
        
        // outputs on world
        this.action = 0;
        
        this.prevactionix = -1;
        this.num_states = ArrayLen(this.actions);
    }
  
  public function getNumStates() {
    return this.num_states;
  }
  public function getMaxNumActions() {
    return ArrayLen(this.actions);
  }
  public function forward() {
    // in forward pass the agent simply behaves in the environment
    // create input to brain
    var a = 0;
    var b = 0;
    var c = 0; 
    var d = 0; 
    
    if (this.p eq 0) a = 1.0;
    if (this.p eq 1) b = 1.0;
    if (this.p eq 2) c = 1.0;
    if (this.p eq 3) d = 1.0;
    
    var input_array = [a,b,c,d];

    if (isdefined("this.brain.act")) this.action = this.brain.act(input_array);


    if (this.action eq 1) this.digestion_signal += 1.0;
    if (this.action eq 2) this.digestion_signal += -1.0;
    if (this.action eq 3) this.digestion_signal += -1.0;
    if (this.action eq 4) this.digestion_signal += -1.0;

    writeOutput('my action:');
    writeDump(this.action);
  }

  public function backward() {
    var reward = this.digestion_signal;

    this.last_reward = reward; // for vis
    
    if (isdefined("this.brain.learn")) this.brain.learn(reward);
}
}