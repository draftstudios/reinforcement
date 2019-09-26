component name="utils" displayname="utils" output="true" { 
    remote void function forcereward(numeric amount=0) { 
        server.a.forcereward(amount);
        server.a.backward();
    }
    remote void function reseteverything() { 
        server.a = new lib.agent();
        server.env = server.a;
        server.a.brain = server.obj.DQNAgent(server.env, server.spec);
        server.a.resetreward();
        server.a.forward(1);
        server.a.forward(2);
        server.a.backward();
    }
}
