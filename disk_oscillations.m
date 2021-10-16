## Copyright (c) 2021 Batzhargal Ulzutuev
## See https://en.wikipedia.org/wiki/Vibrations_of_a_circular_membrane for math details

## In order to use heaviside(x) function, type in Octave command line:
## pkg load symbolic

clear;

## Source: https://mathworld.wolfram.com/BesselFunctionZeros.html
besselZeros = [2.4048, 5.5201, 8.6537, 11.7915, 14.9309;
               3.8317, 7.0156, 10.1735, 13.3237, 16.4706;
               5.1356, 8.4172, 11.6198, 14.7960, 17.9598;
               6.3802, 9.7610, 13.0152, 16.2235, 19.4094;
               7.5883, 11.0647, 14.3725, 17.6160, 20.8269;
               8.7715, 12.3386, 15.7002, 18.9801, 22.2178;];

N = 70; # number of nodes in one grid dimension

xs = linspace(-1, 1, N); # x coordinates of nodes
ys = xs; # y coordinates of nodes
A = 1.0; # oscillations amplitude
k = 3; # order of bessel function
l = 2; # index number of bessel zero
mu = besselZeros(k+1, l);

oldt = 0;
t = 0;
dt = 0.005; # increasing leads to faster animation speed and vice versa

hf = figure();
[X, Y] = meshgrid(xs, ys);

Z = A * heaviside(1.0 - (X.*X + Y.*Y)) .* cos(k * atan2(Y, X)) .* ...
    besselj(k, mu * sqrt(X.*X + Y.*Y)); # Initial z coordinates on mesh

handle = mesh(X, Y, Z);
axis vis3d; # fix viewpoint
axis([-1 1 -1 1 -1 1]); # coordinates of start and end of a view direction vector

hw = waitbar(0, '', 'CreateCancelBtn', 'delete(gcbf)'); # waitbar with cancel button
while 1
  t = t + dt;

  Z = A * heaviside(1.0 - (X.*X + Y.*Y)) .* ...
      (cos(mu * t) .* cos(k * atan2(Y, X)) .* besselj(k, mu * sqrt(X.*X + Y.*Y)));
  
  set(handle, 'ZData', Z);
  drawnow;
  
  if t - oldt > 10 * dt # avoid too frequent calls to run smoothly
    if ~ishandle(hw)
        #stop
        printf("Stopped\n");
        break;
    else
        #update
        oldt = t;
        waitbar(0, hw, cstrcat("t = ", num2str(t)));
    endif
  endif
endwhile
