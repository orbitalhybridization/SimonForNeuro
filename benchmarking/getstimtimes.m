function [rise_true fall_true t_amplifier board_adc_data] = getstimtimes(file,i,width)

    % Get stimulus on/off times from .rhd file
    twu1 = 0; % counter for how many times ind(end) == 0 in main loop
    % read in test rhd file
    [amplifier_data,board_adc_data,t_amplifier,amplifier_channels] = ...
        read_Intan_RHD2000_file_path_update_EDIT_ELIM_OVERHEAD(file,1);
   
    thresholds = [0.20,0.1];
    min_widths = [1000,0];
    audio_thresh = 0.1;
    audio_min_width = 0;
    rise_true = zeros(70,2); % padded but max should be 60/file
    fall_true = zeros(70,2);
    
    for i = 1:2 % fill output matrix for audio and visual onsets
        thresh_cross = board_adc_data(i,1:end) > thresholds(i);
        dcross = diff(thresh_cross);
        rise = find(dcross>0)+1;
        fall = find(dcross<0);

        ind = diff(rise) > width; % find ones sufficiently far apart
        
        if ind(end) == 0
            twu1 = twu1 + 1; % count how many times this happened
            rise = rise(1:end-1);
        end
        
        rise_cut = rise(circshift(diff(rise) > width,1));
        rise_true(2:numel(rise_cut),i) = rise_cut; % find only ones sufficiently far apart 
        rise_true(1) = rise(1); % add the first since it's getting cut off
        fall_cut = fall(diff(fall) > width);
        fall_true(1:numel(fall_cut),i) = fall_cut;
        plot(board_adc_data)
        % plot(fall_true - rise_true) % might want to plot this
        hold on
        xline(fall_true);
        xline(rise_true);
        rise_true = t_amplifier(rise_true);
        fall_true = t_amplifier(fall_true); % \bp how it looking?
        hold off
        fprintf('While getting stimulus times, ind(end)==0 happened %d times',twu1);
    end % \bp did int(end) happen?

end