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
        if(isdefined("n") || !isnumeric(n)) { return []; }
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
        for(var i=1;i<=n;i++) {
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
        var m = ArrayLen(mat.dw);
        for(var i=1;i<=m;i++) {
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
      var n=ArrayLen(m.w);
      for(var i=1;i<=n;i++) { m.w[i] = randn(mu, std); } }
  public function fillRand(m, lo, hi) { 
      var n=ArrayLen(m.w);
      for(var i=1;i<=n;i++) { m.w[i] = randf(lo, hi); } }
  public function gradFillConst(m, c) { 
      var n=ArrayLen(m.dw);
      for(var i=1;i<=n;i++) { m.dw[i] = c } }

public function Graph(needs_backprop) {
    var a = new graph(needs_backprop);
    return a;
}

public function softmax(m) {
      var out = new mat(m.n, m.d); // probability volume
      var maxval = -999999;
      var n = ArrayLen(m.w);
      for(var i=1;i<=n;i++) { if(m.w[i] > maxval) maxval = m.w[i]; }

      var s = 0.0;
      var n=ArrayLen(m.w);
      for(var i=1;i<=n;i++) { 
        out.w[i] = Exp(m.w[i] - maxval);
        s += out.w[i];
      }

      for(var i=1;i<=n;i++) { out.w[i] /= s; }

      // no backward pass here needed
      // since we will use the computed probabilities outside
      // to set gradients directly on m
      return out;
    }

public function initLSTM(input_size, hidden_sizes, output_size) {
    // hidden size should be a list

    var model = {};
    for(var d=1;d<=ArrayLen(hidden_sizes);d++) { // loop over depths
      var prev_size = d eq 0 ? input_size : hidden_sizes[d - 1];
      var hidden_size = hidden_sizes[d];

      // gates parameters
      model['Wix'+d] = RandMat(hidden_size, prev_size , 0, 0.08);  
      model['Wih'+d] = RandMat(hidden_size, hidden_size , 0, 0.08);
      model['bi'+d] = new mat(hidden_size, 1);
      model['Wfx'+d] = RandMat(hidden_size, prev_size , 0, 0.08);  
      model['Wfh'+d] = RandMat(hidden_size, hidden_size , 0, 0.08);
      model['bf'+d] = new mat(hidden_size, 1);
      model['Wox'+d] = RandMat(hidden_size, prev_size , 0, 0.08);  
      model['Woh'+d] = RandMat(hidden_size, hidden_size , 0, 0.08);
      model['bo'+d] = new mat(hidden_size, 1);
      // cell write params
      model['Wcx'+d] = RandMat(hidden_size, prev_size , 0, 0.08);  
      model['Wch'+d] = RandMat(hidden_size, hidden_size , 0, 0.08);
      model['bc'+d] = new mat(hidden_size, 1);
    }
    // decoder params
    model['Whd'] = RandMat(output_size, hidden_size, 0, 0.08);
    model['bd'] = new mat(output_size, 1);
    return model;
  }



  public function forwardLSTM (G, model, hidden_sizes, x, prev) {
    // forward prop for a single tick of LSTM
    // G is graph to append ops to
    // model contains LSTM parameters
    // x is 1D column vector with observation
    // prev is a struct containing hidden and cell
    // from previous iteration

    if(isnull(prev) || !isdefined("prev.h")) {
      var hidden_prevs = [];
      var cell_prevs = [];
      for(var d=1;d<=ArrayLen(hidden_sizes);d++) {
        hidden_prevs.push(new mat(hidden_sizes[d],1)); 
        cell_prevs.push(new mat(hidden_sizes[d],1)); 
      }
    } else {
      var hidden_prevs = prev.h;
      var cell_prevs = prev.c;
    }

    var hidden = [];
    var cell = [];
    for(var d=1;d<=ArrayLen(hidden_sizes);d++) {

      var input_vector = d eq 0 ? x : hidden[d-1];
      var hidden_prev = hidden_prevs[d];
      var cell_prev = cell_prevs[d];

      // input gate
      var h0 = G.mul(model['Wix'+d], input_vector);
      var h1 = G.mul(model['Wih'+d], hidden_prev);
      var input_gate = G.sigmoid(G.add(G.add(h0,h1),model['bi'+d]));

      // forget gate
      var h2 = G.mul(model['Wfx'+d], input_vector);
      var h3 = G.mul(model['Wfh'+d], hidden_prev);
      var forget_gate = G.sigmoid(G.add(G.add(h2, h3),model['bf'+d]));

      // output gate
      var h4 = G.mul(model['Wox'+d], input_vector);
      var h5 = G.mul(model['Woh'+d], hidden_prev);
      var output_gate = G.sigmoid(G.add(G.add(h4, h5),model['bo'+d]));

      // write operation on cells
      var h6 = G.mul(model['Wcx'+d], input_vector);
      var h7 = G.mul(model['Wch'+d], hidden_prev);
      var cell_write = G.tanh(G.add(G.add(h6, h7),model['bc'+d]));

      // compute new cell activation
      var retain_cell = G.eltmul(forget_gate, cell_prev); // what do we keep from cell
      var write_cell = G.eltmul(input_gate, cell_write); // what do we write to cell
      var cell_d = G.add(retain_cell, write_cell); // new cell contents

      // compute hidden state as gated, saturated cell activations
      var hidden_d = G.eltmul(output_gate, G.tanh(cell_d));

      hidden.push(hidden_d);
      cell.push(cell_d);
    }

    // one decoder to outputs at end
    var output = G.add(G.mul(model['Whd'], hidden[hidden.length - 1]),model['bd']);

    // return cell memory, hidden representation and output
    return {'h':hidden, 'c':cell, 'o' : output};
  }

public function maxi(w) {

      // argmax of array w
    var maxv = w[1];
    var maxix = 1;
    var n = ArrayLen(w);
    for(var i=1;i<=n;i++) {
      var v = w[i];
      if(v > maxv) {
        maxix = i;
        maxv = v;
      }
    }
    return maxix;
}


  public function samplei(w) {
    // sample argmax from w, assuming w are 
    // probabilities that sum to one
    var r = randf(0,1);
    var x = 0.0;
    var i = 0;
    while(true) {
      x += w[i];
      if(x > r) { return i; }
      i++;
    }
    return w.length - 1; // pretty sure we should never get here?
  }
}
        
