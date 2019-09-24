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

if (!isdefined("server.a")) {
  server.a = new lib.agent();
}
if (!isdefined("server.env")) {
  server.env = server.a;
}
if (!isdefined("server.a.brain") or  IsSimpleValue(server.a.brain)) {
  server.a.brain = server.obj.DQNAgent(server.env, server.spec);
}
//writedump(server.a.brain);

    //server.a.brain.reset();
server.a.resetreward();
server.a.forward(1);
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

</cfscript>