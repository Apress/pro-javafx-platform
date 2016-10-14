// ConsumeDrinks.fx
package consumer;

var coffee = food.Drinks.getCoffee();
println("Good coffee.  It's {coffee.brand}.");
var tea = food.Drinks.getTea();
println("Good tea.  It's {tea.kind} tea.");
println("Number of drinks offered = {food.Drinks.numberOfDrinksOffered()}.");
