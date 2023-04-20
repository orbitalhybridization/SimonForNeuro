% Select CSV file
[current_csv,path] = uigetfile('.csv','Select CSV File for Analysis');
csv = readtable(strcat(path,current_csv));
csv(1,:) = []; % chop header
csv_onsets = csv.Var2; % \bp need to cut off first row?
%csv_onsets = csv_onsets(2:end); % chop the first header
ind = strfind(current_csv,'.');
id = current_csv(1:ind-1); % \bp check id (ind+1 or ?)
frame_rates = [csv.Var8';csv.Var8']';

% Init Containers
pd_onsets = [];
pd_offsets = [];
mic_onsets = [];
mic_offsets = [];
bdatas = []; % all session data from intan concatenated and stored here
ts = []; % all times from intan

% Process Intan Data
selpath = uigetdir("C:\Users\iljac\Documents\Cogan\game_stimulus_testing\test_windows\4-20",'Select Data Folder for Analysis');
files = dir(selpath);
files = files(3:end); % ignore '.' and '..'
nfiles = numel(files);

for i = 1:nfiles % find onsets/offsets from each file
    filepath = strcat(selpath,'\',files(i).name);
    [pd_on, pd_off, mic_on, mic_off, t, bdata] = getstimtimes(filepath,i,[5000,4000]);
    bdatas = [bdatas bdata];

    ts = [ts t];
    pd_onsets = [pd_onsets pd_on];
    pd_offsets = [pd_offsets, pd_off];
    mic_onsets = [mic_onsets mic_on];
    mic_offsets = [mic_offsets mic_off];
end

% Cut down intan (audio) data as they are not equivalent
keep_i = [1:4];
current = 5;
seq_len = 0;
for j = 2:2:27
    keep_i = [keep_i current:current+seq_len];
    seq_len = seq_len+1;
    current = current+j;
end
mic_onsets = mic_onsets(keep_i);
mic_offsets = mic_offsets(keep_i);

% Calculate Measures
measures = ["Intervals","Lengths","Frame Rate","Game Time vs. DAQ Time","Audio-Visual Concurrency"];
expected_values = [[0.1600,0.1600];[0.1613,0.1400];[31,31];[0,0];[0,0]];
for i = 1:numel(measures)
    [mean_,sd_,min_,max_] = generateMeasure(id,measures(i),[pd_onsets;mic_onsets]',[pd_offsets;mic_offsets]',csv_onsets,frame_rates);
    fprintf('%s \n ---------------- \n ',measures(i))
    fprintf('Visual\n')
    expected = expected_values(i,:);
    fprintf('Expected: %.6f, Mean: %.6f, SD: %.6f, Min: %.6f, Max: %.6f \n\n',expected(1),mean_(1),sd_(1),min_(1),max_(1))
    fprintf('Audio\n')
    fprintf('Expected: %.6f, Mean: %.6f, SD: %.6f, Min: %.6f, Max: %.6f \n\n',expected(2),mean_(2),sd_(2),min_(2),max_(2))

end
;