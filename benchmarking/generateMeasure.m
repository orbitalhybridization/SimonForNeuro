function [mean_,std_,min_,max_] = generateMeasure(dataset_id,measure,intan_onsets,intan_offsets,csv_onsets,frame_rates)

    % get stats for a given measurement
    [mean_,std_,min_,max_] = deal([-1,-1]);
    %assert(numel(intan_onsets) == numel(intan_offsets))
    %assert(numel(csv_onsets) == numel(intan_onsets(:,1)))

    % switch depending on measurement type
    switch measure
        case "Intervals"
            dffsv = diff(intan_onsets(:,1))';
            dffsa = diff(intan_onsets(:,2))';
            %ind = find(dffsv,)
            dffsv = dffsv(dffsv < 3); % only intervals
            dffsa = dffsa(dffsa < 3); % only intervals
            measures = [dffsv;dffsa]';

        case "Lengths"
            measures = intan_offsets - intan_onsets;
        case "Audio-Visual Concurrency"
            measures = [intan_onsets(:,1)' - intan_onsets(:,2)';intan_onsets(:,1)' - intan_onsets(:,2)']';
        case "Frame Rate"
            measures = frame_rates;
        case "Game Time vs. DAQ Time"
            offset = intan_onsets(1) - csv_onsets(1); % must align them
            csv_onsets = csv_onsets + offset;
            measures = (csv_onsets - intan_onsets(:,1));
        otherwise
            fprintf('Unknown analysis type %s',measure)
            return;        
    end

    % plot the measures quietly
    figure('visible','off');
    hold on
    v = measures(:,1);
    a = measures(:,2);
    plot(v)
    if v ~= a % only plot
        plot(a)
        legend(['Photoidode','Mic'])
    end
    title("")
    xlabel("Stimulus Index")
    ylabel("Seconds (s)")
    filename = strcat(pwd,dataset_id,' - ',measure,'.png');
    saveas(gcf,filename) % save the plot
    close(gcf)

    % populate the measures
    mean_ = [mean(v),mean(a)];
    std_ = [std(v),std(a)];
    min_ = [min(v),min(a)];
    max_ = [max(v),max(a)];


end