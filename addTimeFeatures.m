function [features] = addTimeFeatures(epochTimes)
%ADDTIMEFEATURES Given a vector of times in seconds since epoch, return a set of
%time features where each day, month, and year have their own indicator variable
%and the hour is a magnitude value with 0 as midnight and 23 as 11PM.
   % 7 days, 12 months, and 12 years from 2003 through 2015
   % features: 12AM, 1AM, ..., 11PM, sunday, ..., saturday, jan, ..., dec, 2003, ..., 2015
   features = zeros(length(epochTimes), 24 + 7 + 12 + 13);
   hourOffset = 1;
   dayOffset = hourOffset + 24;
   monthOffset = dayOffset + 7;
   yearOffset = monthOffset + 12;
   for i = 1:length(epochTimes)
      timeStruct = localtime(epochTimes(i));
      features(i, hourOffset + timeStruct.hour) = 1;       % assign hour
      features(i, dayOffset + timeStruct.wday) = 1;        % assign day
      features(i, monthOffset + timeStruct.mon) = 1;       % assign month
      features(i, yearOffset + timeStruct.year - 103) = 1; % assign month
   end
end

