function IHEP_to_use_write_old_normalization(Matfile,ImagetoWrite)
% List of open inputs
% Old Normalise: Write: Parameter File - cfg_files
% Old Normalise: Write: Images to Write - cfg_files
nrun = size(ImagetoWrite,1); % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','replace_ZebraFinch','IHEP_to_use_write_old_normalization_job.m');
jobfile = {Fullpath};
% jobfile = {'E:\Program Files\MATLAB\spm12\toolbox\spmAnimalIHEP\replace_mouse\IHEP_to_use_write_old_normalization_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(Matfile); % Old Normalise: Write: Parameter File - cfg_files
    inputs{2, crun} = cellstr(ImagetoWrite(crun,:)); % Old Normalise: Write: Images to Write - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
