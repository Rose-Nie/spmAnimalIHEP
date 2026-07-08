function IHEPNetConstraction
%IHEPNETCONSTRACTION 此处显示有关此函数的摘要
%   此处显示详细说明

load('ROINetIHEPnbb.mat');

Indi = spm_select(Inf,'nii$','Select the Images to Construct NetWork .....');
n = size(Indi,1);

for i = 1:n
    tic
    V = spm_vol(Indi(i,:));
    Y = spm_read_vols(V);
    [Path,name,~] = fileparts(V(1).fname);
    clear OutA;
    for j = 1:length(V)
        Ytemp = Y(:,:,:,j);
        countA = 1;
        for m = 1:68
            OutA(j,countA) = mean(Ytemp(ROINetIHEPnbb(m).temp));
            countA = countA+1;
            clear temp;
        end
        clear Ytemp;
    end
        tt = find(Path == 92);
        Outpath1 = strcat(Path(1:tt(end-1)),'TimeCouse_Wholebrain\');
        mkdir(Outpath1);
        Outpath2 = strcat(Path(1:tt(end-1)),'Rmatrix_Wholebrain\');
        mkdir(Outpath2);
        outfile3 = strcat(Outpath1,Path(tt(end)+1:end),name,'.txt');
        outfile4 = strcat(Outpath2,'r',Path(tt(end)+1:end),name,'.txt');
        save(outfile3,'OutA','-ascii');
        RHO11 = corr(OutA);
        save(outfile4,'RHO11','-ascii');
        toc
end

