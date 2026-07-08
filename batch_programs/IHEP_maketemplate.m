function IHEP_maketemplate(Template,SourceImage)
% List of open inputs
% Old Normalise: Estimate & Write: Source Image - cfg_files
% Old Normalise: Estimate & Write: Images to Write - cfg_files
% Old Normalise: Estimate & Write: Template Image - cfg_files
nrun = size(SourceImage,1); % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','batch_programs','IHEP_maketemplate_job.m');
jobfile = {Fullpath};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(3, nrun);
for crun = 1:nrun
%     inputs{1, crun} = cellstr(SourceImage(crun,:)); % Old Normalise: Estimate & Write: Source Image - cfg_files
%     inputs{2, crun} = cellstr(SourceImage(crun,:)); % Old Normalise: Estimate & Write: Images to Write - cfg_files
    inputs{1, crun} = cellstr(strcat(SourceImage(crun,:),',1')); % Old Normalise: Estimate & Write: Source Image - cfg_files
%     Filename = SourceImage(crun,:);
%     t = find(Filename == 92);
%     Filenew = strcat(SourceImage(crun,1:t(end)),SourceImage(crun,t(end)+2:end));
%     inputs{2, crun} = cellstr([{strcat(SourceImage(crun,:),',1')}; {strcat(Filenew,',1')}]); 
    inputs{2, crun} = cellstr(strcat(SourceImage(crun,:),',1'));% Old Normalise: Estimate & Write: Images to Write - cfg_files
    inputs{3, crun} = cellstr(Template); % Old Normalise: Estimate & Write: Template Image - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
