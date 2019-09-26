<cfscript>
param url.gender = 1;
server.spec = {}
server.spec.update = 'qlearn'; // qlearn | sarsa
server.spec.gamma = 0.9; // discount factor, [0, 1)
server.spec.epsilon = 0.05; // initial epsilon for epsilon-greedy policy, [0, 1)
server.spec.alpha = 0.005; // value function learning rate
server.spec.experience_add_every = 5; // number of time steps before we add another experience to replay memory
server.spec.experience_size = 5000; // size of experience
server.spec.learning_steps_per_iteration = 5;
server.spec.tderror_clamp = 1.0; // for robustness
server.spec.num_hidden_units = 16; // number of neurons in hidden layer

if (!isdefined("server.obj"))
{
  server.obj = new lib.cfreinforcerl();    
}

    // always reset agent for now
    //server.a = new lib.agent();
    //server.env = server.a;
    //server.a.brain = server.obj.DQNAgent(server.env, spec);

if (!isdefined("server.a")) {
  server.a = new lib.agent();
}
if (!isdefined("server.env")) {
  server.env = server.a;
}
if (!isdefined("server.a.brain") or IsSimpleValue(server.a.brain)) {
  server.a.brain = server.obj.DQNAgent(server.env, server.spec);
}
//writedump(server.a.brain);

    //server.a.brain.reset();
if (isdefined("server.a.last_reward")) {
    writeoutput("Last Reward: #server.a.last_reward#");
}

server.a.resetreward();
server.a.forward(url.gender);

//server.a.forcereward(1);
//server.a.forcereward(1);
//server.a.forcereward(-1);
//server.a.forcereward(1);
//server.a.forcereward(1);
//server.a.forcereward(1);
//server.a.backward();
//server.a.forcereward(-1);
//server.a.forcereward(1);
//server.a.forcereward(1);
//server.a.forcereward(-1);
//server.a.forcereward(-1);
//server.a.forcereward(1);
//server.a.backward();
//writeDump(server.a);
//writeDump(server.a.brain.toJSON());

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
    for (i=1; i<=ArrayLen(server.a.actions[server.a.action]); i++){

        if (gender eq 1) { //if male lets put preference to darker colors
            if (listcontainsnocase("dodgerblue,green,gray,black", server.a.actions[server.a.action][i].color)) 
            {
                writeOutput('<div style="background-color:#server.a.actions[server.a.action][i].color#; height:400px;"><a href="javascript:forcereward(1);" style="background-color:white;">Click Me</a></div>');
            }
            else 
            {
                writeOutput('<div style="background-color:#server.a.actions[server.a.action][i].color#; height:400px;"><a href="javascript:forcereward(-1);" style="background-color:white;">Click Me</a></div>');
            }
        } else {
            if (listcontainsnocase("yellow,pink,magenta,violet", server.a.actions[server.a.action][i].color)) 
            {
                writeOutput('<div style="background-color:#server.a.actions[server.a.action][i].color#; height:400px;"><a href="javascript:forcereward(1);" style="background-color:white;">Click Me</a></div>');
            }
            else 
            {
                writeOutput('<div style="background-color:#server.a.actions[server.a.action][i].color#; height:400px;"><a href="javascript:forcereward(-1);" style="background-color:white;">Click Me</a></div>');
            }
        }
    }
    writeOutput('</body>');


    writeOutput('<input type="button" onclick="javascript:reseteverything();" style="position:absolute; top: 0; right: 0;" value="RESET EVERYTHING">');
    if (url.gender eq 1) {
        writeOutput('<input type="button" onclick="javascript:location.href=''index.cfm?gender=2'';" style="position:absolute; top: 0; right: 200;" value="MALE">');
    } else {
        writeOutput('<input type="button" onclick="javascript:location.href=''index.cfm?gender=1'';" style="position:absolute; top: 0; right: 200;" value="FEMALE">');
    }

    savedBrain = '{"NA":5,"NS":2,"NH":16,"NET":{"B2":"{\"d\":1,\"w\":[-0.8508570323165319,-1.5676030162516248,-1.31922038965531,-0.6086907822846829,-1.2919671426157857],\"n\":5}","W1":"{\"d\":2,\"w\":[-0.622503606454278,8.540924692537498E-4,-0.4887126828310525,0.011153629506698952,0.46344414105507903,-0.017767822915801364,-0.4380987823366665,-5.564293965220106E-4,0.1207431622635359,-0.014719620066068716,-0.6556134532394723,9.391625438032429E-4,0.6364579530839675,0.006678358651767523,0.6279436347234831,-0.009246392779657346,-0.6204414072265123,-0.006654736537973909,-0.6434091027502693,-0.003305929810362855,0.7002735029001914,-0.002563763739896491,0.697543022962412,7.482233025075001E-4,-0.48032443161956945,-0.0041327315787639705,-0.65191858183432,0.0075933106262883725,0.1397337086255937,-0.013213320293183615,-0.3857071347188645,-0.011936881327167968],\"n\":16}","W2":"{\"d\":16,\"w\":[0.4252051522656901,0.25085654982836403,-0.2084460638553484,0.1948652675535968,0.012007929530043024,0.4484338842859586,-0.4257806235999408,-0.3964901804518372,0.3974763483733045,0.43630600843844863,-0.5112601578910068,-0.5127122909792229,0.22500409698602697,0.43471683885742723,0.007429570542070398,0.1294424531989237,0.5931114513847675,0.4397782667402053,-0.4061430449377698,0.37683857573217494,-0.0746318111734581,0.6540006380061609,-0.6330473127507643,-0.6135569804469357,0.6009562411380989,0.6225781667335101,-0.7198448931158,-0.6993767302456195,0.43910363756273896,0.6490275135836324,-0.09893682133392627,0.3387956144775493,0.4376400157985378,0.3059923813086189,-0.2678738252943094,0.2671161019708355,-0.03155720733736272,0.4875039376522542,-0.4524777982973068,-0.44993686618020173,0.4651696258128343,0.49322975197555396,-0.5318220549195144,-0.5149732759718592,0.3019181612255852,0.504696412692245,0.0015201690380978244,0.20871505680792737,0.008804026524535402,-0.11080194923967984,0.14856203986378563,-0.16447590935278084,0.12092858464806854,0.07081193302998957,-0.034144925558809665,-0.03437255787808454,0.013636472557505603,0.053249824869143654,-0.13286943496287423,-0.13108864466881823,-0.14208428122037217,0.05973396011164112,0.1367087398530183,-0.20040365159687876,0.4756020962994214,0.3305167875837758,-0.32239973422637497,0.28255612945538244,-0.028770363490377888,0.5156201496505746,-0.4689429387273701,-0.48156541250511764,0.4622924510640277,0.5032384080454319,-0.5775208316933372,-0.5776540670461047,0.3174699752412573,0.5092184910264688,-0.024194699948284146,0.2183462872728405],\"n\":5}","B1":"{\"d\":1,\"w\":[-0.324967818530195,-0.2637640023475084,0.24392214887828167,-0.24127547295782395,0.06496522233235533,-0.3464969874900615,0.32601349516176137,0.324912799501932,-0.3315022503062098,-0.3465357411512636,0.3626029333650026,0.3519748325606555,-0.26301215046416937,-0.351247347512914,0.06686826195662401,-0.21127987177241284],\"n\":16}"}}';

    //server.a.brain.fromJSON(savedBrain);

    writeDump(server.a.brain.toJSON());

</cfscript>
