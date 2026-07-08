function IHEP_NormaltoT2(T2File,MeanImage,RaImage,Template)
% List of open inputs
% Coregister: Estimate & Reslice: Reference Image - cfg_files
% Coregister: Estimate & Reslice: Source Image - cfg_files
% Coregister: Estimate & Reslice: Other Images - cfg_files
% Old Normalise: Estimate & Write: Source Image - cfg_files
% Old Normalise: Estimate & Write: Template Image - cfg_files
nrun = size(T2File,1); % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','replace_rat','IHEP_NormaltoT2_job.m');
jobfile = {Fullpath};
% jobfile = {'E:\Program Files\MATLAB\spm12\toolbox\spmAnimalIHEP\replace_rat\IHEP_NormaltoT2_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(5, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(T2File(crun,:)); % Coregister: Estimate & Reslice: Reference Image - cfg_files
    inputs{2, crun} = cellstr(MeanImage(crun,:)); % Coregister: Estimate & Reslice: Source Image - cfg_files
    inputs{3, crun} = cellstr(RaImage(crun,:)); % Coregister: Estimate & Reslice: Other Images - cfg_files
    inputs{4, crun} = cellstr(T2File(crun,:)); % Old Normalise: Estimate & Write: Source Image - cfg_files
    inputs{5, crun} = cellstr(Template); % Old Normalise: Estimate & Write: Template Image - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
