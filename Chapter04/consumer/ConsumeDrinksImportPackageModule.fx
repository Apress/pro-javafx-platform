// ConsumeDrinksImportPackageModule.fx
package consumer;

import food.Drinks;

var coffee = Drinks.getCoffee();
println("Good coffee.  It's {coffee.brand}.");
var tea = Drinks.getTea();
println("Good tea.  It's {tea.kind} tea.");
println("Number of drinks offered = {Drinks.numberOfDrinksOffered()}.");
