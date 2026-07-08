function processed_data = IHEPpreprocess_fMRI(nii_path, TR, output_path)
% PREPROCESS_FMRI 执行4D fMRI数据预处�?

%% 1. ReadData
[bold_4d, hdr] = read_nii(nii_path);
bold_4d = double(bold_4d);
validate_data(bold_4d);

%% 2. Detrend
bold_detrend = detrend_data(bold_4d);

%% 3. Bandpass
Fs = 1/TR; % Fre
bold_filtered = bandpass_filter(bold_detrend, Fs);

% % %% 4. Z-score
% bold_zscore = normalize_data(bold_filtered);

%% 5. shujubaocun
if exist('output_path', 'var')
    save_nii(bold_filtered, hdr, output_path);
end
processed_data = bold_filtered;

function [data, hdr] = read_nii(path)
    validateattributes(path, {'char'}, {'nonempty'});
    if ~exist(path, 'file')
        error('There is no data file? %s', path);
    end
    hdr = niftiinfo(path);
    data = niftiread(hdr);
    if ndims(data) ~= 4
        error('File is not a 4D data');
    end
end

function validate_data(data)
    % 验证数据类型和范�?
    if ~isa(data, 'double')
        error('The data should be double');
    end
    if max(data(:)) > 1e4 || min(data(:)) < -1e4
        warning('The data is too small..');
    end
end

function detrended = detrend_data(data)
    [X,Y,Z,T] = size(data);
    detrended = zeros(size(data), 'like', data);
    for z = 1:Z
        slice_data = reshape(data(:,:,z,:), [], T);
        detrended(:,:,z,:) = reshape(detrend(slice_data, 1), X,Y,1,T);
    end
    fprintf('Detrend Done\n');
end

function filtered = bandpass_filter(data, Fs)
    nyq = Fs/2;
    bp_range = [0.01 0.1]/nyq; % lvbo
    
    [b, a] = butter(4, bp_range, 'bandpass');
    
    filtered = zeros(size(data), 'like', data);
    parfor t = 1:size(data,4)
        vol = data(:,:,:,t);
        filtered(:,:,:,t) = filtfilt(b, a, double(vol));
    end
    fprintf('Band pass Done\n', bp_range(1)*nyq, bp_range(2)*nyq);
end

% function normalized = normalize_data(data)
%     mu = mean(data, 4);
%     sigma = std(data, 0, 4);
%     normalized = (data - mu) ./ sigma;
%     normalized(isnan(normalized)) = 0;
%     fprintf('Z-score Dond\n');
% end

function save_nii(data, hdr, path)
    hdr.Datatype = 'double';
    hdr.ImageSize = size(data);
    niftiwrite(data, path, hdr);
    fprintf('Save Filtered data Done %s\n', path);
end

end