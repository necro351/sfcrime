fprintf('Feature scaling data\n\tComputing means\n');
fflush(stdout);
means = mean(data);
fprintf('\tComputing standard deviations\n');
fflush(stdout);
stds = std(data);
fprintf('\tDoing zero-meaning\n');
fflush(stdout);
scaledData = data;
for i = 1:numFeatures
   scaledData(:,i) = scaledData(:,i) .- means(:,i);
end
fprintf('\tDoing standard deviation range scaling\n');
fflush(stdout);
for i = 1:numFeatures
   scaledData(:,i) = scaledData(:,i) ./ stds(:,i);
end
