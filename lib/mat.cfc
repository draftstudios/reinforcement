component name="mat" displayname="mat" output="false" { 
      // Mat holds a matrix
      public function init (n,d) {
        // n is number of rows d is number of columns
        this.n = n;
        this.d = d;
        this.w = zeros(n * d);
        this.dw = zeros(n * d);
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

        this.get = function(row, col) { 
          // slow but careful accessor function
          // we want row-major order
          var ix = (this.d * row) + col;
          assert(ix > 0 && ix <= this.w.length);
          return this.w[ix];
        }

        this.set = function(row, col, v) {
          // slow but careful accessor function
          var ix = (this.d * row) + col;
          assert(ix > 0 && ix <= this.w.length);
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
          for(var i=1;i<=n;i++) {
            this.w[i] = obj_json.w[i]; // copy over weights
          }
        }
}
