component name="cfreinforce" displayname="cfreinforce" output="false" { 

    R = {};

    public function out (test) { 
        writeOutput(test);
    }

    public function assert(condition, message) {
        if (!condition) {
            try {
                message = message || "Assertion failed";
            } catch (any e) {
                throw(message="Oops", detail="xyz"); 
            } finally { 
                throw message; // Fallback
            }
        }
    }

    // Random numbers utils
       return_v = false;
       v_val = 0.0;

       public function gaussRandom() {
        if(return_v) { 
          return_v = false;
          return v_val; 
        }

        var u = 2*rand()-1;
        var v = 2*rand()-1;
        var r = u*u + v*v;
        if(r == 0 || r > 1) return gaussRandom();
        var c = sqr(-2*log(r)/r);
        v_val = v*c; // cache this
        return_v = true;
        return u*c;
      }
       public function randf(a, b) { return rand()*(b-a)+a; }
       public function randi(a, b) { return floor(rand()*(b-a)+a); }
       public function randn(mu, std){ return mu+gaussRandom()*std; }

      // helper function returns array of zeros of length n
      // and uses typed arrays if available
       public function zeros(n) {
        if(isdefined(n) || !isnumeric(n)) { return []; }
        else {
            newArray = arrayNew(1);
            tmp = arraySet(newArray, 1, n, 0);
            return newArray;    
        }
      }

      // Mat holds a matrix
       public function Mat(n, d) {
           var a = new mat(n, d);
           return a;
       }

       public function copyMat(b) {
        var a = new mat(b.n, b.d);
        a.setFrom(b.w);
        return a;
       }

       public function copyNet(net) {
        // nets are (k,v) pairs with k = string key, v = Mat()
        var new_net = {};
        for(var p in net) {
          if(structkeyexists(net, p)){
            new_net[p] = copyMat(net[p]);
          }
        }
        return new_net;
      }

       public function updateMat(m, alpha) {
        // updates in place
        var n = m.n * m.d;
        for(var i=0;i<n;i++) {
          if(m.dw[i] neq 0) {
            m.w[i] += - alpha * m.dw[i];
            m.dw[i] = 0;
          }
        }
      }

       public function updateNet(net, alpha) {
        for(var p in net) {
          if(structkeyexists(net,p)){
            updateMat(net[p], alpha);
          }
        }
      }


  public function netToJSON(net) {
    var j = {};
    for(var p in net) {
      if(structkeyexists(net,p)){
        j[p] = net[p].toJSON();
      }
    }
    return j;
  }
  public function netFromJSON(j) {
    var net = {};
    for(var p in j) {
      if(structkeyexists(j,p)){
        net[p] = new mat(1,1); // not proud of this
        net[p].fromJSON(j[p]);
      }
    }
    return net;
  }

  public function netZeroGrads(net) {
    for(var p in net) {
      if(structkeyexists(net,p)){
        var mat = net[p];
        gradFillConst(mat, 0);
      }
    }
  }
  
public function netFlattenGrads(net) {
    var n = 0;
    for(var p in net) { if(structkeyexists(net,p)){ var mat = net[p]; n += mat.dw.length; } }
    var g = new mat(n, 1);
    var ix = 0;
    for(var p in net) {
      if(structkeyexists(net,p)){
        var mat = net[p];
        var m = mat.dw.length;
        for(var i=0;i<m;i++) {
          g.w[ix] = mat.dw[i];
          ix++;
        }
      }
    }
    return g;
  }


// return Mat but filled with random numbers from gaussian
  public function RandMat (n,d,mu,std) {
    var m = new mat(n, d);
    fillRandn(m,mu,std);
    return m;
  }

  // Mat utils
  // fill matrix with random gaussian numbers
  public function fillRandn(m, mu, std) { 
      var n=m.w.length;
      for(var i=0;i<n;i++) { m.w[i] = randn(mu, std); } }
  public function fillRand(m, lo, hi) { 
      var n=m.w.length;
      for(var i=0;i<n;i++) { m.w[i] = randf(lo, hi); } }
  public function gradFillConst(m, c) { 
      var n=m.dw.length;
      for(var i=0;i<n;i++) { m.dw[i] = c } }

public function Graph(needs_backprop) {
           var a = new graph(needs_backprop);
           return a;
       }

public function softmax(m) {
      var out = new mat(m.n, m.d); // probability volume
      var maxval = -999999;
      var n = m.w.length;
      for(var i=0;i<n;i++) { if(m.w[i] > maxval) maxval = m.w[i]; }

      var s = 0.0;
      var n=m.w.length;
      for(var i=0;i<n;i++) { 
        out.w[i] = Exp(m.w[i] - maxval);
        s += out.w[i];
      }

      for(var i=0;i<n;i++) { out.w[i] /= s; }

      // no backward pass here needed
      // since we will use the computed probabilities outside
      // to set gradients directly on m
      return out;
    }

}
        
