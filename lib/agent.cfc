component name="agent" displayname="agent" output="true" { 
    public function init () { 
        // positional information
        this.p = 0;
        this.op = this.p; // old position
        
        this.actions = [
            [
                {position:1, color:"blue"},
                {position:2, color:"green"},
                {position:3, color:"yellow"},
                {position:4, color:"purple"}
            ],
            [
                {position:1, color:"pink"},
                {position:2, color:"brown"},
                {position:3, color:"black"},
                {position:4, color:"magenta"}
            ]
        ];
        
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
  public function forward(gender) { // 1: male, 2: female
    // in forward pass the agent simply behaves in the environment
    // create input to brain
        //var a = 0;
        //var b = 0;
        //var c = 0; 
        //var d = 0; 
        
        //if (this.p eq 0) a = 1.0;
        //if (this.p eq 1) b = 1.0;
        //if (this.p eq 2) c = 1.0;
        //if (this.p eq 3) d = 1.0;
    
    var input_array = [gender];

    if (isdefined("this.brain.act")) this.action = this.brain.act(input_array);

    //if (this.action eq 1) this.digestion_signal += 1.0;
    //if (this.action eq 2) this.digestion_signal += -1.0;
    //if (this.action eq 3) this.digestion_signal += -1.0;
    //if (this.action eq 4) this.digestion_signal += -1.0;

    //writeOutput('my action:');
    //writeDump(this.actions[this.action]);

    writeOutput('<body style="margin:0; padding:0">');
    for (var i=1; i<=ArrayLen(this.actions[this.action]); i++){
        //writeDump(this.actions[this.action][i].color);
        //writeDump(this.actions[this.action][i].position);
        if (gender eq 1) {
            if (listcontainsnocase("blue,green,brown,black", this.actions[this.action][i].color)) 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="forcereward.cfm?amount=1" style="background-color:white;">Click Me</a></div>');
            }
            else 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="forcereward.cfm?amount=-1" style="background-color:white;">Click Me</a></div>');
            }
        } else {
            if (listcontainsnocase("yellow,pink,magenta,purple", this.actions[this.action][i].color)) 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="forcereward.cfm?amount=1" style="background-color:white;">Click Me</a></div>');
            }
            else 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="forcereward.cfm?amount=-1" style="background-color:white;">Click Me</a></div>');
            }
        }
    }
    writeOutput('</body>');

  }

  public function forcereward(amount) {
    this.digestion_signal += amount;
  }

  public function backward() {
    var reward = this.digestion_signal;

    this.last_reward = reward; // for vis
    
    if (isdefined("this.brain.learn")) this.brain.learn(reward);
  }
}
