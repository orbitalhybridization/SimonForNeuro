function [photodiode_rise, photodiode_fall, mic_rise, mic_fall,t_amplifier board_adc_data] = getstimtimes(file,i,width)

    % Get stimulus on/off times from .rhd file
    twu1 = 0; % counter for how many times ind(end) == 0 in main loop
    
    % read in test rhd file
    [amplifier_data,board_adc_data,t_amplifier,amplifier_channels] = ...
        read_Intan_RHD2000_file_path_update_EDIT_ELIM_OVERHEAD(file,1);
   
    thresholds = [0.20,0.1];
    rise_true = NaN(100,2); % padded estimate
    fall_true = NaN(100,2);
    
    for j = 1:2 % fill output matrix for audio and visual onsets
        thresh_cross = board_adc_data(j,1:end) > thresholds(j);
        dcross = diff(thresh_cross);
        rise = find(dcross>0)+1;
        fall = find(dcross<0);

        ind = diff(rise) > width(j); % find ones sufficiently far apart
        
        % trimming that seems to work
        if ind(end) == 0
            twu1 = twu1 + 1; % count how many times this happened
            rise = rise(1:end-1);
        end
        
        % further trimming needed if audio carries to next file (avoid
        % false positive fall detection)
        if ((numel(board_adc_data(j,1:end)) - fall(end) <= 28000) && (j == 2))
            fall = fall(1:end-1);
        end

        % get rises and falls, cut to width
        rise_cut = rise(circshift(diff(rise) > width(j),1));
        fall_cut = fall(diff(fall) > width(j));
        rise_true(2:numel(rise_cut)+1,j) = rise_cut; % find only ones sufficiently far apart 
        fall_true(1:numel(fall_cut),j) = fall_cut;

        % adjustments
        if (i == 1)

            if (j == 1) % visualfix
                rise_true(end,j) = rise(end);
                fall_true(end,j) = fall(end);
            
            else % audiofix
                rise_true(1,j) = rise(1);
            end
        end

        if (i == 2)

            if (j == 1) % visualfix
                rise_true(end,j) = rise(end);
                fall_true(end,j) = fall(end);
            
            else % audiofix
                %rise_true(1,j) = rise(1);
            end
        end

        if (i == 3)
            if (j == 1) % visual fix
                rise_true(end,j) = rise(end);
                fall_true(end,j) = fall(end);
            else % audiofix
            end
        end

        if (i == 4)
            if (j == 1) % visual fix
                rise_true(end,j) = rise(end);
                fall_true(end,j) = fall(end);                
            else % audiofix

            end
        end

        if (i == 5)
            if (j == 1) % visual fix
                rise_true(end,j) = rise(end);
                fall_true(end,j) = fall(end);           
            else % audiofix
            end
        end

        if (i == 6)
            if (j == 1) % visual fix
                rise_true(end,j) = rise(end);
                fall_true(end,j) = fall(end);           
            else % audiofix

            end
        end

        if (i == 7)
            if (j == 1) % visual fix
                rise_true(end,j) = rise(end);
                fall_true(end,j) = fall(end);           
            else % audiofix
                fall_true(end,j) = fall(end);
            end
        end
        %plot(board_adc_data(j,:))
        % plot(fall_true - rise_true) % might want to plot this
        %hold on
        %xline(fall_true(:,j));
        %xline(rise_true(:,j));
        %hold off

        %fprintf('While getting stimulus times, ind(end)==0 happened %d times\n',twu1);
        % get number of detected onsets/offsets: sum(~isnan(rise_true(:,j)))
    end

    % Clear NaN placeholders and convert to seconds (s)
    photodiode_rise = rise_true(~isnan(rise_true(:,1)),1);
    photodiode_fall = fall_true(~isnan(fall_true(:,1)),1);
    mic_rise = rise_true(~isnan(rise_true(:,2)),2);
    mic_fall = fall_true(~isnan(fall_true(:,2)),2);

    photodiode_rise = t_amplifier(photodiode_rise);
    mic_rise = t_amplifier(mic_rise);
    photodiode_fall = t_amplifier(photodiode_fall);
    mic_fall = t_amplifier(mic_fall); % \bp how it looking?

end