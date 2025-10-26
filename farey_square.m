clear;

# Plots scatter plot of x = m / n, y = 1 / n, with gcd(m, n) = 1
# Pattern of straight line can be visible
# which is in fact square representation of Farey numberes
# See Chapter 1 of A. Hatcher, Topology of Numbers

N = 60; # >= 2

numerators = [0 1 zeros(1, N - 2)];
denominators = [1 1 zeros(1, N - 2)];

for d = 2:N
  ns = [];
  ds = [];
  for j = 1:d - 1
    if (gcd(j, d) == 1)
      ns = [ns j];
      ds = [ds d];
    endif
  endfor
  numerators(end + 1, :) = [ns zeros(1, N - length(ns))];
  denominators(end + 1, :) = [ds zeros(1, N - length(ds))];
endfor

scatter(numerators ./ denominators, 1 ./ denominators, 4, "b", "s");

axis equal;
grid on;
grid minor;

