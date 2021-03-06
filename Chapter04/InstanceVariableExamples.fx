class A {
  var i: Integer = 1024 on replace {
    println("Trigger in class definition: i = {i}.");
  }
}

var a1 = A {};
var a2 = A { i: 2048 };
var a3 = A {
  override var i = 3072 on replace {
    println("Trigger in object literal override: i = {i}.");
  }
};
var a4 = A {
  override var i = 4096 on replace {
    println("Trigger in object literal override: i = {i}.");
  }
  i: 5120
};

println("a1.i = {a1.i}");
println("a2.i = {a2.i}");
println("a3.i = {a3.i}");
println("a4.i = {a4.i}");
