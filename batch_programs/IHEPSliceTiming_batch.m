function IHEPSliceTiming_batch(File,TR)
% List of open inputs
% Slice Timing: Data - cfg_repeat
% Slice Timing: Number of Slices - cfg_entry
% Slice Timing: TR - cfg_entry
% Slice Timing: TA - cfg_entry
% Slice Timing: Slice order - cfg_entry
nrun = size(File,1); % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','batch_programs','IHEPSliceTiming_batch_job.m');
jobfile = {Fullpath};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(5, nrun);
for crun = 1:nrun
    V = spm_vol(File(crun,:));
    numV = length(V);
    for i = 1:numV
        Files(i,1) = cellstr(strcat(File(crun,:),',',num2str(i))); % Slice Timing: Data - cfg_repeat
    end
    inputs{1, crun} = cellstr(Files(:,1));
    V = spm_vol(File(crun,:));
    DIM = V(1).dim;
    inputs{2, crun} = DIM(3); % Slice Timing: Number of Slices - cfg_entry
    inputs{3, crun} = TR; % Slice Timing: TR - cfg_entry
    inputs{4, crun} = TR-(TR/DIM(3)); % Slice Timing: TA - cfg_entry
    inputs{5, crun} = [1:2:DIM(3) 2:2:DIM(3)]; % Slice Timing: Slice order - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
return;
