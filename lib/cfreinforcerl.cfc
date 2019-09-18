component name="cfreinforcerl" displayname="cfreinforcerl" output="false" { 

    RL = {};

    public function out (test) { 
        writeOutput(test);
    }

public function getopt(opt, field_name, default_value) {
    if (!isdefined("opt")) { return default_value }
    return structkeyexists(opt, field_name) ? opt[field_name] : default_value;
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


public function setConst(arr, c) {
    var n=ArrayLen(arr);
  for(var i=1;i<=n;i++) {
    arr[i] = c;
  }
}

public function sampleWeighted(p) {
  var r = Rand();
  var c = 0.0;
  var n = ArrayLen(p);
  for(var i=1;i<=n;i++) {
    c += p[i];
    if(c >= r) { return i; }
  }
  assert(false, 'wtf');
}

public function DQNAgent(env, opt) {
    return new dqnagent(env, opt);
} 
}