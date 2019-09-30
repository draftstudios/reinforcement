component name="agent" displayname="agent" output="true" { 
    public function init () { 
        
        this.actions = [
            [
                {position:1, color:"blue"},
                {position:2, color:"green"},
                {position:3, color:"yellow"},
                {position:4, color:"blueviolet"}
            ],
            [
                {position:1, color:"yellow"},
                {position:2, color:"green"},
                {position:3, color:"pink"},
                {position:4, color:"black"}
            ],
            [
                {position:1, color:"blue"},
                {position:2, color:"green"},
                {position:3, color:"black"},
                {position:4, color:"gray"}
            ],
            [
                {position:1, color:"pink"},
                {position:2, color:"yellow"},
                {position:3, color:"blueviolet"},
                {position:4, color:"magenta"}
            ],
            [
                {position:1, color:"pink"},
                {position:2, color:"gray"},
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
        this.num_states = 1;
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


    writeOutput('<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>'); 

  writeOutput('<script>');
  writeOutput('$(function() {');
  writeOutput('    forcereward = (amount) => {');
  writeOutput('      $.get("utils.cfc?method=forcereward&amount=" + amount);');
  writeOutput('    };');
  writeOutput('    reseteverything = () => {');
  writeOutput('      $.get("utils.cfc?method=reseteverything");');
  writeOutput('    };');
  writeOutput('});');
  writeOutput('</script>');

    writeOutput('<body style="margin:0; padding:0">');
    writeOutput('<input type="button" onclick="javascript:reseteverything();" style="position:absolute; top: 0; right: 0;" value="RESET EVERYTHING">');
    for (var i=1; i<=ArrayLen(this.actions[this.action]); i++){
        //writeDump(this.actions[this.action][i].color);
        //writeDump(this.actions[this.action][i].position);

        if (gender eq 1) { //if male lets put preference to darker colors
            if (listcontainsnocase("blue,green,gray,black", this.actions[this.action][i].color)) 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="javascript:forcereward(1);" style="background-color:white;">Click Me</a></div>');
            }
            else 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="javascript:forcereward(-1);" style="background-color:white;">Click Me</a></div>');
            }
        } else {
            if (listcontainsnocase("yellow,pink,magenta,blueviolet", this.actions[this.action][i].color)) 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="javascript:forcereward(1);" style="background-color:white;">Click Me</a></div>');
            }
            else 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="javascript:forcereward(-1);" style="background-color:white;">Click Me</a></div>');
            }
        }
    }
    writeOutput('</body>');

  }

  public function forcereward(amount) {
    this.digestion_signal += amount;
  }

  public function resetreward(amount) {
    this.digestion_signal = 0;
  }

  public function backward() {
    var reward = this.digestion_signal;
    this.last_reward = reward; // for vis
    if (isdefined("this.brain.learn")) this.brain.learn(reward);
  }
}
