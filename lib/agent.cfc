component name="agent" displayname="agent" output="true" { 
    public function init () { 
        // positional information

/*
        this.fullarrays = [
                [{color:"dodgerblue"},{color:"pink"}],
                [{color:"green"},{color:"yellow"}],
                [{color:"black"},{color:"violet"}],
                [{color:"gray"},{color:"magenta"}]
            ];

        this.actions = arrayCartesianProduct(this.fullarrays);
*/
        
            this.actions = [
                [
                    {position:1, color:"dodgerblue"},
                    {position:2, color:"green"},
                    {position:3, color:"yellow"},
                    {position:4, color:"violet"}
                ],
                [
                    {position:1, color:"yellow"},
                    {position:2, color:"green"},
                    {position:3, color:"pink"},
                    {position:4, color:"black"}
                ],
                [
                    {position:1, color:"dodgerblue"},
                    {position:2, color:"green"},
                    {position:3, color:"black"},
                    {position:4, color:"gray"}
                ],
                [
                    {position:1, color:"pink"},
                    {position:2, color:"yellow"},
                    {position:3, color:"violet"},
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
        this.num_states = 2; // should match number of inputs
    }

    public array function arrayCartesianProduct(required array arrays) {
        var result = [];
        var arraysLen = arrayLen(arguments.arrays);
        var size = (arraysLen) ? 1 : 0;
        var array = '';
        var x = 0;
        var i = 0;
        var j = 0;
        var current = [];

        for (x=1; x <= arraysLen; x++) {
            size = size * arrayLen(arguments.arrays[x]);
            current[x] = 1;
        }
        for (i=1; i <= size; i++) {
            result[i] = [];
            for (j=1; j <= arraysLen; j++) {
                arrayAppend(result[i], arguments.arrays[j][current[j]]);
            }
            for (j=arraysLen; j > 0; j--) {
                if (arrayLen(arguments.arrays[j]) > current[j])  {
                    current[j]++;
                    break;
                }
                else {
                    current[j] = 1;
                }
            }
        }

        return result;
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
    
    var input_array = [gender]; //what is observed?

    if (isdefined("this.brain.act")) this.action = this.brain.act(input_array);

    //if (this.action eq 1) this.digestion_signal += 1.0;
    //if (this.action eq 2) this.digestion_signal += -1.0;
    //if (this.action eq 3) this.digestion_signal += -1.0;
    //if (this.action eq 4) this.digestion_signal += -1.0;

    //writeOutput('my action:');
    //writeDump(this.actions[this.action]);

  //is this the most legible place to put this code? in agent.cfc?

  writeOutput('<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>'); 

  writeOutput('<script>');
  writeOutput('$(function() {');
  writeOutput('    forcereward = (amount) => {');
  writeOutput('      $.get("utils.cfc?method=forcereward&amount=" + amount);');
  writeOutput('    };');
  writeOutput('    reseteverything = () => {');
  writeOutput('      $.get("utils.cfc?method=reseteverything");');
  writeOutput('    };');
  writeOutput('    loadbrain = () => {');
  writeOutput('      $(''a'').click();');
  writeOutput('    };');
  writeOutput('    clickandgo= () => {');
  writeOutput('      $(''a'').click();');
  writeOutput('    };');
  writeOutput('});');
  writeOutput('</script>');

    writeOutput('<body style="margin:0; padding:0">');
    for (i=1; i<=ArrayLen(this.actions[this.action]); i++){

        if (gender eq 1) { //if male lets put preference to darker colors
            if (listcontainsnocase("dodgerblue,green,gray,black", this.actions[this.action][i].color)) 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="javascript:forcereward(1);" style="background-color:white;">Click Me</a></div>');
            }
            else 
            {
                writeOutput('<div style="background-color:#this.actions[this.action][i].color#; height:400px;"><a href="javascript:forcereward(-1);" style="background-color:white;">Click Me</a></div>');
            }
        } else {
            if (listcontainsnocase("yellow,pink,magenta,violet", this.actions[this.action][i].color)) 
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

  public function resetreward() {
    this.digestion_signal = 0;
  }

  public function backward() {
    var reward = this.digestion_signal;
    this.last_reward = reward; // for vis
    if (isdefined("this.brain.learn")) this.brain.learn(reward);
  }
}
