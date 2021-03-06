var x = 3.14159;
var y = 2.71828;

println("x = {x}");
println("y = {y}");

println("x + y = {x + y}");
println("x - y = {x - y}");
println("x * y = {x * y}");
println("x / y = {x / y}");
println("x mod y = {x mod y}");

var max = java.lang.Float.MAX_VALUE;
var min = java.lang.Float.MIN_VALUE;

println("max = {max}");
println("min = {min}");

println("max * 2 will overflow to {max * 2}");
println("min / 2 will underflow to {min / 2}");

var inf = max * max;

println("inf = {inf}");
println("inf.isInfinite() = {inf.isInfinite()}");
println("inf / inf = {inf / inf}");

var nan = inf / inf;

println("nan = {nan}");
println("nan.isNaN() = {nan.isNaN()}");
