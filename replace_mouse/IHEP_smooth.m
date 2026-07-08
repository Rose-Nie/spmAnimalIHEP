function IHEP_smooth(Files)
% List of open inputs
% Smooth: Images to smooth - cfg_files
nrun = size(Files,1); % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','replace_mouse','IHEP_smooth_job.m');
jobfile = {Fullpath};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(Files(crun,:)); % Smooth: Images to smooth - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
