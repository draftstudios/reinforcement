component name="cfreinforce" displayname="cfreinforce" output="false" { 

    R = {};

    var init = function init (public function(global) { 
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
    })(R);

}
        
