import java.lang.Exception;

function weekday(i:Integer):String {
  if (i == 0) then "Sunday" else
  if (i == 1) then "Monday" else
  if (i == 2) then "Tuesday" else
  if (i == 3) then "Wendesday" else
  if (i == 4) then "Thursday" else
  if (i == 5) then "Friday" else
  if (i == 6) then "Saturday" else
  throw new Exception("Invalid weekday: {i}.");
}

for (i in [0..7]) {
  println("weekday({i}) = {weekday(i)}.");
}
