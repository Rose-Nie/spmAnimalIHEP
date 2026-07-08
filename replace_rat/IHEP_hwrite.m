function [V] = IHEP_hwrite(fname,DIM,VOX,SCALE,TYPE,OFFSET,ORIGIN)
%IHEP_HWRITE Summary of this function goes here
%   Detailed explanation goes here
% 用于写图像文件的头文件信息
% 若vargin为图像文件，V = spm_vol(vargin); 可以得到图像的头文件信息
% fname: 写出的图像文件，如‘test.img’
% DIM: V.dim;
% VOX: [abs(V.mat(1,1)) abs(V.mat(2,2)) abs(V.mat(3,3))];
% SCALE: V.pinfo(1,:);
% TYPE: V.dt(1);
% OFFSET: V.pinfo(3,:);
% ORIGIN: [abs(V.mat(1,4)) abs(V.mat(2,4)) abs(V.mat(3,4))];
% nbb ---- 2011.11.17

if ~ischar(fname), error('Out file name is not correct!!'); end

V.fname = fname;
V.dim = DIM;
V.pinfo = [SCALE; 0; OFFSET];
V.dt = [TYPE 0];
V.n = [1 1];

V.mat = zeros(4,4);
V.mat(4,4) = 1;
% Voxel size
V.mat(1,1) = -VOX(1);
V.mat(2,2) = VOX(2);
V.mat(3,3) = VOX(3);
% Origin
V.mat(1,4) = ORIGIN(1) * VOX(1);
V.mat(2,4) = -ORIGIN(2) * VOX(2);
V.mat(3,4) = -ORIGIN(3) * VOX(3);

V = spm_create_vol(V);
Y = spm_read_vols(V);
V = spm_write_plane(V,Y,':');
return;