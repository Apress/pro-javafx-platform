println("Initializing seq...");
var seq = [1, 3, 5, 7, 9] on replace oldValue[lo..hi] = newSlice {
  print("  Variable seq changed from ");
  print(oldValue);
  print(" to ");
  println(seq);
  println("  The change occurred at low indexe {lo} and high index {hi}.");
  print("  The new slice is ");
  println(newSlice);
};

println('Executing "insert [2, 4, 6] before seq[3]"...');
insert [2, 4, 6] before seq[3];

println('Executing "delete seq [1..2]"...');
delete seq [1..2];

println('Executing "seq[4..5] = [8, 10]"...');
seq[4..5] = [8, 10];
