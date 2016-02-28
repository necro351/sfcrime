function [distances] = addLandmarkFeatures(gpsCoordinates)
%ADDLANDMARKFEATURES Given a vector of N gps coordinates, convert each
%coordinate into a set of 10 distances to landmarks where the landmarks are the
%GPS coordinates of the police stations in San Francisco.
   stationGPS = [
      % Vallejo St
      -122.409963, 37.798659;
      % 3rd St
      -122.389412, 37.77238;
      % Williams Ave
      -122.397903, 37.729751;
      % Valencia St
      -122.422005, 37.762849;
      % Fillmore St
      -122.432445, 37.78019;
      % Waller St
      -122.455287, 37.767797;
      % 6th Ave
      -122.464467, 37.779928;
      % Sgt John V Young St
      -122.446215, 37.724676;
      % 24th Ave
      -122.4815, 37.743734;
      % Eddy St
      -122.412904, 37.783665;
   ];
   distances = zeros(length(gpsCoordinates), length(stationGPS));
   for i = 1:length(stationGPS)
      componentDist = stationGPS(i, :) .- gpsCoordinates(:, :);
      componentDist = componentDist .* componentDist;
      distances(:, i) = sum(componentDist')';
      distances(:, i) = distances(:, i) .* 0.5;
   end
end

