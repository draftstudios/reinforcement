<!--- 
<cfscript>

    R = {};

    start = function(global) { 
        function assert(condition, message) {
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
      var return_v = false;
      var v_val = 0.0;
      var gaussRandom = function() {
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
      var randf = function(a, b) { return rand()*(b-a)+a; }
      var randi = function(a, b) { return floor(rand()*(b-a)+a); }
      var randn = function(mu, std){ return mu+gaussRandom()*std; }

      // helper function returns array of zeros of length n
      // and uses typed arrays if available
      var zeros = function(n) {
        if(isdefined(n) || !isnumeric(n)) { return []; }
        else {
            newArray = arrayNew(1);
            tmp = arraySet(newArray, 1, n, 0);
            return newArray;    
        }
      }

      // Mat holds a matrix
      var Mat = function(n,d) {
        // n is number of rows d is number of columns
        this.n = n;
        this.d = d;
        this.w = zeros(n * d);
        this.dw = zeros(n * d);

        this.get = function(row, col) { 
          // slow but careful accessor function
          // we want row-major order
          var ix = (this.d * row) + col;
          assert(ix >= 0 && ix < this.w.length);
          return this.w[ix];
        }

        this.set = function(row, col, v) {
          // slow but careful accessor function
          var ix = (this.d * row) + col;
          assert(ix >= 0 && ix < this.w.length);
          this.w[ix] = v; 
        }

        this.setFrom = function(arr) {
          var n = ArrayLen(arr);
          for(var i=1;i<=n;i++) {
            this.w[i] = arr[i]; 
          }
        }

        this.setColumn = function(m, i) {
          var n = ArrayLen(m.w);
          for(var q=1;q<=n;q++) {
            this.w[(this.d * q) + i] = m.w[q];
          }
        }

        this.toJSON = function() {
          var json = {};
          json['n'] = this.n;
          json['d'] = this.d;
          json['w'] = this.w;
          return SerializeJSON(json);
        }

        this.fromJSON = function(json) {
          var obj_json = DeserializeJSON(json);     
          this.n = obj_json.n;
          this.d = obj_json.d;
          this.w = zeros(this.n * this.d);
          this.dw = zeros(this.n * this.d);
          var n = this.n * this.d;
          for(var i=0;i<n;i++) {
            this.w[i] = obj_json.w[i]; // copy over weights
          }
        }

        return this;
      }

      var copyMat = function(b) {
        var a = Mat(b.n, b.d);
        a.setFrom(b.w);
        return a;
      }

      var copyNet = function(net) {
        // nets are (k,v) pairs with k = string key, v = Mat()
        var new_net = {};
        for(var p in net) {
          if(structkeyexists(net, p)){
            new_net[p] = copyMat(net[p]);
          }
        }
        return new_net;
      }

      var updateMat = function(m, alpha) {
        // updates in place
        var n = m.n * m.d;
        for(var i=0;i<n;i++) {
          if(m.dw[i] neq 0) {
            m.w[i] += - alpha * m.dw[i];
            m.dw[i] = 0;
          }
        }
      }

      var updateNet = function(net, alpha) {
        for(var p in net) {
          if(structkeyexists(net,p)){
            updateMat(net[p], alpha);
          }
        }
      }

      // various utils
      global.assert = assert;
      global.zeros = zeros;

      // classes
      global.Mat = Mat;

      // more utils
      global.copyMat = copyMat;
      global.copyNet = copyNet;
      global.updateMat = updateMat;
      global.updateNet = updateNet;
    };

    start(R);
    writeDump(R);
    writeDump(R.Mat(2,2));
    yoo = R.Mat(2,2);
    writeDump(yoo);

    yaa = R.Mat(3,3);
    writeOutput(yaa.toJSON());

    writeOutput(yoo.toJSON());
    

</cfscript>
--->

<cfscript>
obj = new lib.cfreinforce();    
obj.out("123");    
obj.assert(true,"233");
writeDump(obj.Mat(2,2));
test = obj.Mat(5,5);
test2 = obj.copyMat(test);
writedump(test2);
writedump(test);

</cfscript>