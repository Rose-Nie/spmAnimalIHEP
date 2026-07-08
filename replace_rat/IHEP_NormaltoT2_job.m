%-----------------------------------------------------------------------
% Job saved on 25-Jul-2024 11:49:08 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.coreg.estwrite.ref = '<UNDEFINED>';
matlabbatch{1}.spm.spatial.coreg.estwrite.source = '<UNDEFINED>';
matlabbatch{1}.spm.spatial.coreg.estwrite.other = '<UNDEFINED>';
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
matlabbatch{2}.spm.tools.oldnorm.estwrite.subj.source = '<UNDEFINED>';
matlabbatch{2}.spm.tools.oldnorm.estwrite.subj.wtsrc = '';
matlabbatch{2}.spm.tools.oldnorm.estwrite.subj.resample(1) = cfg_dep('Coregister: Estimate & Reslice: Resliced Images', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rfiles'));
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.template = '<UNDEFINED>';
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.weight = '';
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.smosrc = 3;
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.smoref = 3;
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.regtype = 'mni';
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.cutoff = 25;
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.nits = 16;
matlabbatch{2}.spm.tools.oldnorm.estwrite.eoptions.reg = 1;
matlabbatch{2}.spm.tools.oldnorm.estwrite.roptions.preserve = 0;
matlabbatch{2}.spm.tools.oldnorm.estwrite.roptions.bb = [-70 -40 -73.5
                                                         69 49 72];
matlabbatch{2}.spm.tools.oldnorm.estwrite.roptions.vox = [1 1 1.5];
matlabbatch{2}.spm.tools.oldnorm.estwrite.roptions.interp = 1;
matlabbatch{2}.spm.tools.oldnorm.estwrite.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.tools.oldnorm.estwrite.roptions.prefix = 'w';
