% Select CSV file
[current_csv,path] = uigetfile('.csv','Select CSV File for Analysis');
csv = readtable(strcat(path,current_csv));
csv = readtable(csv);
csv_onsets = csv.Var2; % \bp need to cut off first row?
csv_onsets = csv_onsets(2:end); % chop the first header

% Init Containers
intan_onsets = zeros(numel(csv_onsets),2);
intan_offsets = zeros(numel(csv_onsets),2);
bdatas = []; % all session data from intan concatenated and stored here
ts = []; % all times from intan

% Process Intan Data
selpath = uigetdir("C:\Users\iljac\Documents\Cogan\game_stimulus_testing\test_windows\4-20",'Select Data Folder for Analysis');
files = dir(selpath);
files = files(3:end); % ignore '.' and '..'
nfiles = numel(files);

for i = 1:nfiles % find onsets/offsets from each file
    filepath = strcat(selpath,files(i).name);
    [onsets, offsets, t, bdata] = getstimtimes(filepath,i,5000);
    bdatas = [bdatas bdata];
    ts = [ts t];
    intan_onsets(1:numel(onsets),:) = onsets;
    intan_offsets(1:numel(offsets),:) = offsets;
end

% Need util functions for extracting only certain visual or auditory stim
% Calculate Measures
measures = ["Intervals","Lengths","Concurrency","Frame Rate"];
for i = 1:numel(measures)
    [expected,mean,sd,min,max] = generateMeasure(measures(i),intan_onsets,intan_offsets,csv_onsets);
    fprintf('%s \n -------------- \n ',measures(i))
    fprintf('Expected: %.2f, Mean: %.2f, SD: %.2f, Min: %.2f, Max: %.2f',expected,mean,sd,min,max)
end

%{
skip = 1;
curr = 0;
data_cut = [intan(1) intan(2) intan(3) intan(4)];
skipping = false;
for i = 5:numel(intan)
    if curr < skip && ~skipping
        data_cut = [data_cut intan(i)];
        curr=curr+1;
    else
        skipping = true;
        curr=curr-1;
        if curr == 0
            skip = skip+1;
            skipping = false;
        end
    end
end
%}

%{
What we want to spit out (expected,mean,sd,min,max):
    - Audio interval
    - Visual interval
    - Audio length
    - Visual length
    - Concurrency
    - Frame rate
%}
;
% Don't wanna hibernate!