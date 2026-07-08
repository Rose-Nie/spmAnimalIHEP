function IHEPRealign_batch(Files)

% List of open inputs
% Realign: Estimate & Reslice: Session - cfg_files
nrun = size(Files,1); % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','batch_programs','IHEPRealign_batch_job.m');
jobfile = {Fullpath};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(Files(crun,:)); % Realign: Estimate & Reslice: Session - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
