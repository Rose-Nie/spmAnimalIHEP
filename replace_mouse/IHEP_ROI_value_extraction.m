function IHEP_ROI_value_extraction(ResultOutPath,EnlargeTimes)
%IHEP_ROI_VALUE_EXTRACTION 此处显示有关此函数的摘要
%   此处显示详细说明
File = spm_select(Inf,'nii$','Select Files to extract Mean value in ROIs .....');
n = size(File,1);
Outname1 = strcat(ResultOutPath,'inTMBTAAatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
Outname2 = strcat(ResultOutPath,'inIHEPPaxinosatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
Outname3 = strcat(ResultOutPath,'inIHEPPaxinosatlas_WhiteMatter_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
Outname4 = strcat(ResultOutPath,'inTMBTAAatlas2026version_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
Outname5 = strcat(ResultOutPath,'inTMBTAAatlas2026Bi_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
%-------------------------------------------
%图谱为整个的提取方法
load('TMBTA_Region.mat');
load('ROI.mat');
load('ROIWhiteIHEP.mat');
load('ROInew2026.mat')
load('ROInew2026Bi.mat')
OutA(1,1) = {'RegionName'};
OutB(1,1) = {'RegionName'};
OutC(1,1) = {'RegionName'};
OutD(1,1) = {'RegionName'};
OutE(1,1) = {'RegionName'};

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
    OutA(1,i+1) = cellstr(Indname);
    OutB(i+1,1) = cellstr(Indname);
    OutC(i+1,1) = cellstr(Indname);
    OutD(i+1,1) = cellstr(Indname);
    OutE(i+1,1) = cellstr(Indname);
    striii = num2str(i);
    disp([striii 'Extracting ' Indname ' ROIs from TMBTA ATLAS .................']);
    for j = 1:1287
        if(i == 1)
            OutA(j+1,1) = cellstr(strcat(char(TMBTname(j))));
        end
        OutA(j+1,i+1) = cellstr(num2str(nanmean(Y(MIP(j).temp))*EnlargeTimes / ScaleFactor(1)));
%          OutA(j+1,i+1) = cellstr(num2str(nanmean(Y(MIP(j).temp))*EnlargeTimes));
    end

    disp([striii 'Extracting ' Indname ' ROIs from IHEPPaxinos ATLAS .................']);
    for k = 1:120
        if(i == 1)
            OutB(1,k+1) = cellstr(strcat(char(ROI(k).name)));
        end
        OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes / ScaleFactor(1)));
%         OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes));
    end
    
    disp([striii 'Extracting ' Indname ' ROIs from IHEPPaxinos White Matter ATLAS .................']);
    for mm = 1:74
        if(i == 1)
            OutC(1,mm+1) = cellstr(strcat(char(ROIWhiteIHEP(mm).name)));
        end
        OutC(i+1,mm+1) = cellstr(num2str(nanmean(Y(ROIWhiteIHEP(mm).temp))*EnlargeTimes / ScaleFactor(1)));
%         OutC(i+1,mm+1) = cellstr(num2str(nanmean(Y(ROIWhiteIHEP(mm).temp))*EnlargeTimes));
    end
    
    disp([striii 'Extracting ' Indname ' ROIs from TMBTAAatlas2026version ATLAS .................']);
    for k = 1:488
        if(i == 1)
            OutD(1,k+1) = cellstr(strcat(char(ROI2026(k).name)));
        end
        OutD(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI2026(k).temp))*EnlargeTimes / ScaleFactor(1)));
%         OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes));
    end
%     
    disp([striii 'Extracting ' Indname ' ROIs from TMBTAAatlas2026Biversion ATLAS .................']);
    for k = 1:244
        if(i == 1)
            OutE(1,k+1) = cellstr(strcat(char(ROI2026Bi(k).name)));
        end
        OutE(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI2026Bi(k).temp))*EnlargeTimes / ScaleFactor(1)));
%         OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes));
    end
    toc
end
xlswrite(Outname1,OutA);
xlswrite(Outname2,OutB);
xlswrite(Outname3,OutC);
xlswrite(Outname4,OutD);
xlswrite(Outname5,OutE);

end

