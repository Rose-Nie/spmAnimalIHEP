function IHEP_ROI_value_extraction(ResultOutPath,EnlargeTimes)
%IHEP_ROI_VALUE_EXTRACTION 此处显示有关此函数的摘要
%   此处显示详细说明
File = spm_select(Inf,'nii$','Select Files to extract Mean value in ROIs .....');
n = size(File,1);
Outname1 = strcat(ResultOutPath,'inIHEPAatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
% Outname2 = strcat(ResultOutPath,'inIHEPPaxinosatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
% Outname3 = strcat(ResultOutPath,'inIHEPPaxinosatlas_WhiteMatter_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
%-------------------------------------------
%图谱为整个的提取方法
% load('TMBTA_Region.mat');
load('ROI.mat');
% load('ROIWhiteIHEP.mat');
% OutA(1,1) = {'RegionName'};
OutB(1,1) = {'RegionName'};
% OutC(1,1) = {'RegionName'};

for i = 1:n
    tic
    Y = spm_read_vols(spm_vol(File(i,:)));
    [Indipath,Indname1,~] = fileparts(File(i,:));
    temp = find(Indipath == 92);
    V = spm_vol(File(i,:));
    ScaleFactor = V.pinfo;
    
%     [Indipath,~,~] = fileparts(File(i,:));
%     Indname = Indipath(39:end);
%   
    Indname = strcat(Indipath(temp(end-1):end),'_',Indname1);
    OutB(i+1,1) = cellstr(Indname);

    striii = num2str(i);

    disp([striii 'Extracting ' Indname ' ROIs from IHEPZF ATLAS .................']);
    for k = 1:26
        if(i == 1)
            OutB(1,k+1) = cellstr(strcat(char(ROI(k).name)));
        end
        OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes / ScaleFactor(1)));
    end

    toc
end

xlswrite(Outname1,OutB);


end

