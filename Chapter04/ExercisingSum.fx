// ExercisingSum.fx
var fxSum = FXSum {};
var sumClient = new SumClient(fxSum);
var sumOfInts = sumClient.addUpInts([1, 3, 5, 7, 9]);
var sumOfDoubles = sumClient.addUpDoubles([3.14159, 2.71828]);
println("sumOfInts={sumOfInts}.");
println("sumOfDoubles={sumOfDoubles}.");
