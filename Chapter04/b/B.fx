// b/B.fx
package b;

import a.A;

public class B extends A {
  public function adjustI(adj: Integer) {
    i += adj;  // OK.
  }
  public function adjustI(a: A, adj: Integer) {
    // a.i += adj; // Not allowed
  }
}
