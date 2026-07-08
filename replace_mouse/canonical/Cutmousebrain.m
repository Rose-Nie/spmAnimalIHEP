V = spm_vol('mask_mouse_new.nii');
Y = spm_read_vols(V);

Y(:,1:35,:) = 0;
Y(:,101:137,:) = 0;

V.fname = 'cutmask_mouse_new.nii';
V = spm_create_vol(V);
spm_write_plane(V,Y,':');