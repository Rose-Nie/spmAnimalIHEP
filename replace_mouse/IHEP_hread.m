function [DIM,VOX,SCALE,TYPE,OFFSET,ORIGIN] = IHEP_hread(vargin)
%IHEP_HREAD Summary of this function goes here
%   Detailed explanation goes here
% 用于读取图像文件的头文件信息
% 若vargin为图像文件，V = spm_vol(vargin); 可以得到图像的头文件信息
% DIM: V.dim;
% VOX: [abs(V.mat(1,1)) abs(V.mat(2,2)) abs(V.mat(3,3))];
% SCALE: V.pinfo(1,:);
% TYPE: V.dt(1);
% OFFSET: V.pinfo(3,:);
% ORIGIN: [abs(V.mat(1,4)) abs(V.mat(2,4)) abs(V.mat(3,4))];
% nbb ---- 2011.11.17

if ischar(vargin), vargin = spm_vol(vargin); end
V = vargin;

DIM = V.dim;
VOX = [abs(V.mat(1,1)) abs(V.mat(2,2)) abs(V.mat(3,3))];
SCALE = V.pinfo(1,:);
TYPE = V.dt(1);
OFFSET = V.pinfo(3,:);
ORIGIN = [abs(V.mat(1,4))/abs(V.mat(1,1)) abs(V.mat(2,4))/abs(V.mat(2,2)) abs(V.mat(3,4))/abs(V.mat(3,3))];

return;