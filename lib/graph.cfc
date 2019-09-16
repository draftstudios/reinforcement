component name="graph" displayname="graph" output="false" { 

      public function init (needs_backprop=true) {
          this.needs_backprop = needs_backprop;

          this.backprop = [];
      }

      private function zeros(n) {
        if(isdefined(n) || !isnumeric(n)) { return []; }
        else {
            newArray = arrayNew(1);
            tmp = arraySet(newArray, 1, n, 0);
            return newArray;    
        }
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

    public function backward() {
      for(var i=this.backprop.length-1;i>=0;i--) {
        this.backprop[i](); // tick!
      }
    }

    public function rowPluck(m, ix) {
        // pluck a row of m with index ix and return it as col vector
      assert(ix >= 0 && ix < m.n);
      var d = m.d;
      var out = new mat(d, 1);
      var n = d;
      for(var i=0;i<n;i++){ out.w[i] = m.w[d * ix + i]; } // copy over the data

      if(this.needs_backprop) {
        var backward = function() {
            var n=d;
          for(var i=0;i<n;i++){ m.dw[d * ix + i] += out.dw[i]; }
        }
        this.backprop.push(backward);
      }
      return out;

    }

    public function tanh(m) {
      // tanh nonlinearity
      var out = new mat(m.n, m.d);
      var n = m.w.length;
      for(var i=0;i<n;i++) { 
        out.w[i] = createObject("java", "java.lang.Math").tanh( javacast("double", m.w[i]); 
        //out.w[i] = Math.tanh(m.w[i]);
      }

      if(this.needs_backprop) {
        var backward = function() {
          for(var i=0;i<n;i++) {
            var mwi = out.w[i];
            m.dw[i] += (1.0 - mwi * mwi) * out.dw[i];
          }
        }
        this.backprop.push(backward);
      }
      return out;
    }

    public function sigmoid(m) {
      // sigmoid nonlinearity
      var out = new mat(m.n, m.d);
      var n = m.w.length;
      for(var i=0;i<n;i++) { 
        out.w[i] = sig(m.w[i]);
      }

      if(this.needs_backprop) {
        var backward = function() {
          for(var i=0;i<n;i++) {
            var mwi = out.w[i];
            m.dw[i] += mwi * (1.0 - mwi) * out.dw[i];
          }
        }
        this.backprop.push(backward);
      }
      return out;
    }

    public function sig(x) {
        // helper function for computing sigmoid
        return 1.0/(1+Exp(-x));
    }

    public function relu(m) {
      var out = new mat(m.n, m.d);
      var n = m.w.length;
      for(var i=0;i<n;i++) { 
        out.w[i] = max(0, m.w[i]); // relu
      }
      if(this.needs_backprop) {
        var backward = function() {
          for(var i=0;i<n;i++) {
            m.dw[i] += m.w[i] > 0 ? out.dw[i] : 0.0;
          }
        }
        this.backprop.push(backward);
      }
      return out;
    }

    public function mul(m1, m2) {
      // multiply matrices m1 * m2
      assert(m1.d === m2.n, 'matmul dimensions misaligned');

      var n = m1.n;
      var d = m2.d;
      var out = new mat(n,d);
      for(var i=0;i<m1.n;i++) { // loop over rows of m1
        for(var j=0;j<m2.d;j++) { // loop over cols of m2
          var dot = 0.0;
          for(var k=0;k<m1.d;k++) { // dot product loop
            dot += m1.w[m1.d*i+k] * m2.w[m2.d*k+j];
          }
          out.w[d*i+j] = dot;
        }
      }

      if(this.needs_backprop) {
        var backward = function() {
          for(var i=0;i<m1.n;i++) { // loop over rows of m1
            for(var j=0;j<m2.d;j++) { // loop over cols of m2
              for(var k=0;k<m1.d;k++) { // dot product loop
                var b = out.dw[d*i+j];
                m1.dw[m1.d*i+k] += m2.w[m2.d*k+j] * b;
                m2.dw[m2.d*k+j] += m1.w[m1.d*i+k] * b;
              }
            }
          }
        }
        this.backprop.push(backward);
      }
      return out;
    }

    public function add(m1, m2) {
      assert(m1.w.length === m2.w.length);

      var out = new mat(m1.n, m1.d);
      var n = m1.w.length;
      for(var i=0;i<n;i++) {
        out.w[i] = m1.w[i] + m2.w[i];
      }
      if(this.needs_backprop) {
        var backward = function() {
            var n = m1.w.length;
          for(var i=0;i<n;i++) {
            m1.dw[i] += out.dw[i];
            m2.dw[i] += out.dw[i];
          }
        }
        this.backprop.push(backward);
      }
      return out;
    }

    public function dot(m1, m2) {
      // m1 m2 are both column vectors
      assert(m1.w.length === m2.w.length);
      var out = new mat(1,1);
      var dot = 0.0;
      var n = m1.w.length;
      for(var i=0;i<n;i++) {
        dot += m1.w[i] * m2.w[i];
      }
      out.w[0] = dot;
      if(this.needs_backprop) {
        var backward = function() {
        var n = m1.w.length;
          for(var i=0;i<n;i++) {
            m1.dw[i] += m2.w[i] * out.dw[0];
            m2.dw[i] += m1.w[i] * out.dw[0];
          }
        }
        this.backprop.push(backward);
      }
      return out;
    }     

    public function eltmul(m1, m2) {
      assert(m1.w.length === m2.w.length);

      var out = new mat(m1.n, m1.d);
      var n = m1.w.length;
      for(var i=0;i<n;i++) {
        out.w[i] = m1.w[i] * m2.w[i];
      }
      if(this.needs_backprop) {
        var backward = function() {
          var n = m1.w.length;
          for(var i=0;i<n;i++) {
            m1.dw[i] += m2.w[i] * out.dw[i];
            m2.dw[i] += m1.w[i] * out.dw[i];
          }
        }
        this.backprop.push(backward);
      }
      return out;
    }   
    
}
