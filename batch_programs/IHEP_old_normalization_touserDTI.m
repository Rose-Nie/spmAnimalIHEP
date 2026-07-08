function IHEP_old_normalization_touserDTI(Template,SourceImage,ImagetoWrite)
% List of open inputs
% Old Normalise: Estimate & Write: Source Image - cfg_files
% Old Normalise: Estimate & Write: Images to Write - cfg_files
% Old Normalise: Estimate & Write: Template Image - cfg_files
nrun = size(SourceImage,1); % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','batch_programs','IHEP_old_normalization_touser_job.m');
jobfile = {Fullpath};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(3, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(SourceImage(crun,:)); % Old Normalise: Estimate & Write: Source Image - cfg_files
    inputs{2, crun} = cellstr(ImagetoWrite); % Old Normalise: Estimate & Write: Images to Write - cfg_files
    inputs{3, crun} = cellstr(Template); % Old Normalise: Estimate & Write: Template Image - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
