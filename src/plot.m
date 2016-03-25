function [] = plot(data, crimes)
% PLOT Plot the data in X
   h = scatter(data(:,5), data(:,6), [], data(:,2), ".");
   axis([1, 2], "square");
   axis([-122.52 -122.36 37.68 37.84]);
   %legend(get(h, 'children'), crimes, "location", "south");
end
