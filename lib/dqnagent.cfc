component name="dqnagent" displayname="dqnagent" output="false" { 

    RL = {};

public function getopt(opt, field_name, default_value) {
    if (!isdefined("opt")) { return default_value }
    return structkeyexists(opt, field_name) ? opt[field_name] : default_value;
}

    public function init (env, opt) { 
        this.gamma = getopt(opt, 'gamma', 0.75); // future reward discount factor
        this.epsilon = getopt(opt, 'epsilon', 0.1); // for epsilon-greedy policy
        this.alpha = getopt(opt, 'alpha', 0.01); // value function learning rate

        this.experience_add_every = getopt(opt, 'experience_add_every', 25); // number of time steps before we add another experience to replay memory
        this.experience_size = getopt(opt, 'experience_size', 5000); // size of experience replay
        this.learning_steps_per_iteration = getopt(opt, 'learning_steps_per_iteration', 10);
        this.tderror_clamp = getopt(opt, 'tderror_clamp', 1.0); 

        this.num_hidden_units =  getopt(opt, 'num_hidden_units', 100); 

        this.env = env;
        this.reset();
    }

    R = new cfreinforce();

 public function zeros(n) {
     return R.zeros(n); // inherit these
 } 
 public function assert(condition, message) { 
     return R.assert(condition, message);
 }
 public function randi(a,b){
    return R.randi(a,b);
 } 
 public function randf(a,b){ 
    return R.randf(a,b);
 }


    public function reset() {
        this.nh = this.num_hidden_units; // number of hidden units
        this.ns = this.env.getNumStates();
        this.na = this.env.getMaxNumActions();
        //writedump(this.na);

        // nets are hardcoded for now as key (str) -> Mat
        // not proud of this. better solution is to have a whole Net object
        // on top of Mats, but for now sticking with this
        this.net = {};
        this.net.W1 = R.RandMat(this.nh, this.ns, 0, 0.01);
        this.net.b1 = new mat(this.nh, 1, 0, 0.01);
        this.net.W2 = R.RandMat(this.na, this.nh, 0, 0.01);
        this.net.b2 = new mat(this.na, 1, 0, 0.01);

        this.exp = []; // experience
        this.expi = 0; // where to insert

        this.t = 0;

        this.r0 = "";
        this.s0 = "";
        this.s1 = "";
        this.a0 = "";
        this.a1 = "";

        this.tderror = 0; // for visualization only...
    }

    public function  toJSON() {
        // save function
        var j = {};
        j.nh = this.nh;
        j.ns = this.ns;
        j.na = this.na;
        j.net = R.netToJSON(this.net);
        return SerializeJSON(j);
    }

    public function fromJSON(i) {
        j = DeserializeJSON(i);
        // writeDump(j);
        // load function
        this.nh = j.nh;
        this.ns = j.ns;
        this.na = j.na;
        this.net = R.netFromJSON(j.net);
    }

    public function forwardQ(net, s, needs_backprop) {
        var G = R.Graph(needs_backprop);
        var a1mat = G.add(G.mul(net.W1, s), net.b1);
        var h1mat = G.tanh(a1mat);
        var a2mat = G.add(G.mul(net.W2, h1mat), net.b2);
        this.lastG = G; // back this up. Kind of hacky isn't it
        return a2mat;
    }

    public function act(slist) {
        // convert to a Mat column vector
        var s = new mat(this.ns, 1);
        s.setFrom(slist);

        // epsilon greedy policy
        if(Rand() < this.epsilon) {
        var a = randi(1, this.na+1);
        } else {
        // greedy wrt Q function
        var amat = this.forwardQ(this.net, s, false);
        var a = R.maxi(amat.w); // returns index of argmax action
        }

        // shift state memory
        this.s0 = this.s1;
        this.a0 = this.a1;
        this.s1 = s;
        this.a1 = a;

        return a;
    }

    public function learn(r1) {
        // perform an update on Q function
        if(!(this.r0 is "") && this.alpha > 0) {

        // learn from this tuple to get a sense of how "surprising" it is to the agent
        var tderror = this.learnFromTuple(this.s0, this.a0, this.r0, this.s1, this.a1);
        this.tderror = tderror; // a measure of surprise

        // decide if we should keep this experience in the replay
        if(this.t mod this.experience_add_every eq 0) {
            this.exp[this.expi+1] = [this.s0, this.a0, this.r0, this.s1, this.a1];
            this.expi += 1;
            if(this.expi > this.experience_size) { this.expi = 0; } // roll over when we run out
        }
        this.t += 1;

        // sample some additional experience from replay memory and learn from it
        for(var k=0;k<this.learning_steps_per_iteration;k++) {
            var ri = randi(1, ArrayLen(this.exp)+1); // todo: priority sweeps?
            var e = this.exp[ri];
            this.learnFromTuple(e[1], e[2], e[3], e[4], e[5])
        }
        }
        this.r0 = r1; // store for next update
    }

    public function learnFromTuple(s0, a0, r0, s1, a1) {
    // want: Q(s,a) = r + gamma * max_a' Q(s',a')

    // compute the target Q value
    var tmat = this.forwardQ(this.net, s1, false);
    //writeoutput(r0);
    //writeoutput('||');
    //writeoutput(this.gamma);
    //writeoutput('||');
    //writedump(tmat.w);
    //writeoutput('||');
    //writeoutput(R.maxi(tmat.w));
    //writeoutput('||');
    
    var qmax = r0 + this.gamma * tmat.w[R.maxi(tmat.w)];

    // now predict
    var pred = this.forwardQ(this.net, s0, true);

    var tderror = pred.w[a0] - qmax;
    var clamp = this.tderror_clamp;
    if(abs(tderror) > clamp) {  // huber loss to robustify
      if(tderror > clamp) tderror = clamp;
      if(tderror < -clamp) tderror = -clamp;
    }
    pred.dw[a0] = tderror;
    this.lastG.backward(); // compute gradients on net params

    // update net
    R.updateNet(this.net, this.alpha);
    return tderror;
  }
}
