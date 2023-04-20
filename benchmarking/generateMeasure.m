function [expected,mean,std,min,max] = generateMeasure(measure,intan_onsets,intan_offsets,csv_onsets)

    % switch depending on measurement

    switch measure

        case "Intervals"
        
        case "Lengths"

        case "Concurrency"

        case "Frame Rate"
        
        otherwise
            fprintf('Unknown analysis type %s',measure)
        
    end


end