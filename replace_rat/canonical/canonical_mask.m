% files = spm_select(Inf,'img$','Input the images..');
% maskfile = spm_read_vols(spm_vol('brainmask.img'));
% 
% temp = find(maskfile < 5);
% 
% m = size(files,1);
% for i = 1:m
%     [path,name,ext] = fileparts(files(i,:));
%     imagename = strcat(path,'\',name,ext);
%     V = spm_vol(imagename);
%     Y = spm_read_vols(V);
%     Y(temp) = 0;
%     V.descrip = '';
%     V = spm_create_vol(V);
%     spm_write_plane(V,Y,':');
% end
V = spm_vol('brainmask.img');
maskfile = spm_read_vols(V);
maskfile(:,1:23,:) = 0;

V.fname = 'Cere.img';

V = spm_create_vol(V);
spm_write_plane(V,maskfile,':');
