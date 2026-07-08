function IHEPNANtest(files)
% files = spm_select(Inf,'nii$','Input the result images..');
% files = spm_select(Inf,'image','Input the result images..');
n = size(files,1);
for i = 1:n
    V = spm_vol(files(i,:));
    Y = spm_read_vols(V);
    Y(isnan(Y)) = 0;
    Y(isinf(Y)) = 0;
    V.descrip = '';
    V = spm_create_vol(V);
    spm_write_plane(V,Y,':');
end
fclose all;

