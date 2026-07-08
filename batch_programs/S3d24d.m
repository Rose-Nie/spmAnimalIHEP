function S3d24d(Files,Outpathname)
% List of open inputs
% 3D to 4D File Conversion: 3D Volumes - cfg_files
% 3D to 4D File Conversion: Output Filename - cfg_entry
nrun = 1; % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','batch_programs','S3d24d_job.m');
jobfile = {Fullpath};
% jobfile = {'D:\data\20230510_T2\LK\LK\S3d24d_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = Files; % 3D to 4D File Conversion: 3D Volumes - cfg_files
    inputs{2, crun} = Outpathname; % 3D to 4D File Conversion: Output Filename - cfg_entry
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
