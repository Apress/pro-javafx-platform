// ConsumeDrinksImportModuleEntities.fx
package consumer;

import food.Drinks.getCoffee;
import food.Drinks.getTea;
import food.Drinks.numberOfDrinksOffered;

var coffee = getCoffee();
println("Good coffee.  It's {coffee.brand}.");
var tea = getTea();
println("Good tea.  It's {tea.kind} tea.");
println("Number of drinks offered = {numberOfDrinksOffered()}.");
