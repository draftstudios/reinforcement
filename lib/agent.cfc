component name="agent" displayname="agent" output="true" { 
  public function init () { 
      
      this.actions = [
          "green",
          "yellow",
          "blueviolet",
          "pink",
          "black",
          "gray",
          "magenta"
      ];
      
      this.brain = ""; // set from outside

      this.reward_bonus = 0.0;
      this.digestion_signal = 0.0;
      
      // outputs on world
      this.action = 0;
      
      this.num_states = 1; // set this
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

    var input_array = [];
    this.resetreward(); 

    if (isdefined("this.brain.act")) this.action = this.brain.act(input_array);

  }

  public function forcereward(amount) {
    this.digestion_signal += amount;
  }

  public function resetreward() {
    this.digestion_signal = 0;
  }

  public function backward() {
    var reward = this.digestion_signal;
    this.last_reward = reward; // for visualization in the future
    if (isdefined("this.brain.learn")) this.brain.learn(reward);
  }
}
