<cfscript>
server.spec = {}
server.spec.update = 'qlearn'; // qlearn | sarsa
server.spec.gamma = 0.9; // discount factor, [0, 1)
server.spec.epsilon = 0.2; // initial epsilon for epsilon-greedy policy, [0, 1)
server.spec.alpha = 0.005; // value function learning rate
server.spec.experience_add_every = 5; // number of time steps before we add another experience to replay memory
server.spec.experience_size = 10000; // size of experience
server.spec.learning_steps_per_iteration = 5;
server.spec.tderror_clamp = 1.0; // for robustness
server.spec.num_hidden_units = 100; // number of neurons in hidden layer

if (!isdefined("server.obj"))
{
  server.obj = new lib.cfreinforcerl();    
}

    // always reset agent for now
    //server.a = new lib.agent();
    //server.env = server.a;
    //server.a.brain = server.obj.DQNAgent(server.env, spec);
    //server.a.last_reward_arr = [];

if (!isdefined("server.a")) {
  server.a = new lib.agent();
}
if (!isdefined("server.env")) {
  server.env = server.a;
}
if (!isdefined("server.a.brain") or  IsSimpleValue(server.a.brain)) {
  server.a.brain = server.obj.DQNAgent(server.env, server.spec);
}
if (!isdefined("server.last_reward_arr")) {
    server.last_reward_arr = [];
}   

drawHeader();

// just to start tracking performance
server.last_reward_arr.append(server.a.last_reward);

//writedump(server.a.brain);

//server.a.brain.reset(); // clears the Agent's brain
//server.a.resetreward();

    server.a.forward();
    writeoutput('<div style="width:500; height:500; text-align: center; vertical-align: middle; line-height: 500px; font-size: 3em; display:block; background-color:#server.a.actions[server.a.action]#;">'); 
    //writeoutput(server.a.action); 
    writeoutput('<a href="javascript:forcereward(1)">LIKE</a> | <a href="javascript:forcereward(-1)">NO LIKE</a>');
    writeoutput('</div>');

    //server.a.forcereward(+1);
    //server.a.forcereward(+1);
    //server.a.forcereward(+1);
    //server.a.forcereward(+1);
    //server.a.forcereward(+1);
    //server.a.forcereward(+1);
    //server.a.backward(); // back-propagate (learn) from (state, action, reward)
    //writeoutput(server.a.last_reward); 

writedump(server.last_reward_arr);

//writeDump(server.a);
//writeDump(server.a.brain.toJSON());

drawFooter();

function drawHeader() {
  writeOutput('<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>'); 

  writeOutput('<script>');
  writeOutput('$(function() {');
  writeOutput('    forcereward = (amount) => {');
  writeOutput('      $.get("utils.cfc?method=forcereward&amount=" + amount);');
  writeOutput('      setTimeout(() => window.location.reload(), 1000);'); // waiting 1 second then refresh
  writeOutput('    };');
  writeOutput('    reseteverything = () => {');
  writeOutput('      $.get("utils.cfc?method=reseteverything");');
  writeOutput('    };');
  writeOutput('});');
  writeOutput('</script>');

  writeOutput('<body style="margin:0; padding:0">');
}

function drawFooter() {
  writeOutput('</body>');
}
</cfscript>
