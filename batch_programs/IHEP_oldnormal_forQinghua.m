function IHEP_oldnormal_forQinghua(SourceFile,WriteFile,TemplateFile)
% List of open inputs
% Old Normalise: Estimate & Write: Source Image - cfg_files
% Old Normalise: Estimate & Write: Images to Write - cfg_files
% Old Normalise: Estimate & Write: Template Image - cfg_files
nrun = 1; % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','batch_programs','IHEP_oldnormal_forQinghua_job.m');
jobfile = {Fullpath};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(3, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(SourceFile); % Old Normalise: Estimate & Write: Source Image - cfg_files
    inputs{2, crun} = cellstr(WriteFile); % Old Normalise: Estimate & Write: Images to Write - cfg_files
    inputs{3, crun} = cellstr(TemplateFile); % Old Normalise: Estimate & Write: Template Image - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
