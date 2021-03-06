class A {
  var b: Boolean;
  function f() {
    println("A.f() called: b is {b}.");
  }
}

mixin class B {
  var i: Integer;
  function g() {
    println("B.g() called: i is {i}");
  }
}

class C extends A, B {
  var n: Number;
  function h() {
    println("C.h() called: b = {b}, i = {i}, n = {n}.");
  }
}

var c = C { b: true, i: 1024, n: 3.14 };
c.f();
c.g();
c.h();
