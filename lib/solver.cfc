component name="graph" displayname="graph" output="false" { 

      public function init () {
            this.decay_rate = 0.999;
            this.smooth_eps = 1e-8;
            this.step_cache = {};
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

    public function step(model, step_size, regc, clipval) {
      // perform parameter update
      var solver_stats = {};
      var num_clipped = 0;
      var num_tot = 0;
      for(var k in model) {
        if(structkeyexists(model,k)) {
          var m = model[k]; // mat ref
          if(!(k in this.step_cache)) { this.step_cache[k] = new mat(m.n, m.d); }
          var s = this.step_cache[k];
          var n = m.w.length;
          for(var i=0;i<n;i++) {

            // rmsprop adaptive learning rate
            var mdwi = m.dw[i];
            s.w[i] = s.w[i] * this.decay_rate + (1.0 - this.decay_rate) * mdwi * mdwi;

            // gradient clip
            if(mdwi > clipval) {
              mdwi = clipval;
              num_clipped++;
            }
            if(mdwi < -clipval) {
              mdwi = -clipval;
              num_clipped++;
            }
            num_tot++;

            // update (and regularize)
            m.w[i] += - step_size * mdwi / Sqr(s.w[i] + this.smooth_eps) - regc * m.w[i];
            m.dw[i] = 0; // reset gradients for next iteration
          }
        }
      }
      solver_stats['ratio_clipped'] = num_clipped*1.0/num_tot;
      return solver_stats;
    }

}
