// GettingSettingVariables.fx
import javafx.reflect.*;

public class Point {
  public var x: Number;
  public var y: Number;
}

public var a:String;

public function run() {
  var p = Point { x: 3, y: 4 };

  // Working with instance variable x
  var context = FXLocal.getContext();
  var classType = context.findClass("GettingSettingVariables.Point");
  var xVar = classType.getVariable("x");
  xVar.setValue(context.mirrorOf(p), context.mirrorOf(7.0));
  println("p.x={p.x}.");

  // Working with script variable a
  var moduleType = context.findClass("GettingSettingVariables");
  var aVar = moduleType.getVariable("a");
  aVar.setValue(context.mirrorOf(p), context.mirrorOf("Hello, World"));
  println("a={a}.");
}
