// CreatingInstance.fx
import javafx.reflect.*;

public class Point {
  public var x: Number;
  public var y: Number;
  public override function toString() {
    "Point \{ x: {x}, y: {y} \}"
  }
}

public function run() {
  var context = FXLocal.getContext();
  var classType = context.findClass("CreatingInstance.Point");
  var classValue = classType.allocate();
  classValue.initVar("x", context.mirrorOf(3.0));
  classValue.initVar("y", context.mirrorOf(4.0));
  classValue.initialize();
  var p = (classValue as FXLocal.ObjectValue).asObject();
  println(p);
}
