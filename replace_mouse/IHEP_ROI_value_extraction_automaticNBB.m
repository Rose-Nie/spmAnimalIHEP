function IHEP_ROI_value_extraction_automaticNBB
%IHEP_ROI_VALUE_EXTRACTION 此处显示有关此函数的摘要
%   此处显示详细说明
% ResultFiles = [{'FA'};{'MD'};{'AD'};{'RD'};{'ReHo'};{'ALFF'};{'fALFF'};{'FC_Hyp'};{'Gray'};{'White'}];
% ResultFiles = [{'ReHo'};{'ALFF'};{'fALFF'};{'FC_Ent'};{'FC_Hip'};{'FC_PFC'}];
% ResultFiles = [{'FA'};{'MD'};{'AD'};{'RD'}];
% ResultFiles = [{'FA'};{'MD'};{'AD'};{'RD'};{'Gray'};{'White'}];
% ResultFiles = [{'ReHo'};{'ALFF'};{'fALFF'};{'FC_PVN'}];
% ResultFiles = [{'ReHo'};{'ALFF'};{'fALFF'};{'Gray'}];
% ResultFiles = [{'ReHo'};{'ALFF'};{'fALFF'};{'FC_HIP'};{'FC_DG'}];
ResultFiles = [{'VMHC'}];
% ResultFiles = [{'Gray'};{'White'};{'CSF'}];
% ResultFiles =[{'ReHo'};{'ALFF'};{'fALFF'};{'FC_Amy'};{'FC_Hip'};{'FC_Hypo'};{'Gray'};{'MD'};{'AD'};{'RD'};{'FA'};{'White'}];
% ResultFiles =[{'ReHo'};{'ALFF'};{'fALFF'};{'Gray'};{'MD'};{'AD'};{'RD'};{'FA'};{'White'}];
% ResultFiles = [{'ReHo'};{'ALFF'};{'fALFF'};{'FC_DG'};{'FC_HIP'}];
EnlargeTimes = 1000;

for kk = 1:length(ResultFiles)
    load(strcat('J:\20260615_ertongyiyuan_liuchen\Results\',char(ResultFiles(kk)),'.mat'));
    ResultOutPath = strcat('J:\20260615_ertongyiyuan_liuchen\Results\ROI\');
    mkdir(ResultOutPath);
    for subjnnnn = 1:length(subj)
        if(subjnnnn == 1)
            file_group2_ntt = [{subj(subjnnnn).file}];
        else
            file_group2_ntt = [file_group2_ntt;{subj(subjnnnn).file}];
        end
    end
    File = char(file_group2_ntt);
%     File = spm_select(Inf,'nii$','Select Files to extract Mean value in ROIs .....');
    n = size(File,1);
    Outname1 = strcat(ResultOutPath,'\Mean',char(ResultFiles(kk)),'_inTMBTAAatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
    Outname2 = strcat(ResultOutPath,'\Mean',char(ResultFiles(kk)),'_inIHEPPaxinosatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
    Outname3 = strcat(ResultOutPath,'\Mean',char(ResultFiles(kk)),'_inIHEPPaxinosatlas_WhiteMatter_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
    
  
%-------------------------------------------
%图谱为整个的提取方法
load('TMBTA_Region.mat');
load('ROI.mat');
load('ROIWhiteIHEP.mat');
OutA(1,1) = {'RegionName'};
OutB(1,1) = {'RegionName'};
OutC(1,1) = {'RegionName'};



for i = 1:n
    tic
%     Y = spm_read_vols(spm_vol(strcat('G',File(i,2:end))));
%     [Indipath,Indname1,~] = fileparts(strcat('G',File(i,2:end)));
%     temp = find(Indipath == 92);
%     V = spm_vol(strcat('G',File(i,2:end)));
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
    striii = num2str(i);
    disp([striii 'Extracting ' Indname ' ROIs from TMBTA ATLAS .................']);
    for j = 1:1287
        if(i == 1)
            OutA(j+1,1) = cellstr(strcat(char(TMBTname(j))));
        end
        OutA(j+1,i+1) = cellstr(num2str(nanmean(Y(MIP(j).temp))*EnlargeTimes / ScaleFactor(1)));
    end

    disp([striii 'Extracting ' Indname ' ROIs from IHEPPaxinos ATLAS .................']);
    for k = 1:120
        if(i == 1)
            OutB(1,k+1) = cellstr(strcat(char(ROI(k).name)));
        end
        OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes / ScaleFactor(1)));
    end
    
    disp([striii 'Extracting ' Indname ' ROIs from IHEPPaxinos White Matter ATLAS .................']);
    for mm = 1:74
        if(i == 1)
            OutC(1,mm+1) = cellstr(strcat(char(ROIWhiteIHEP(mm).name)));
        end
        OutC(i+1,mm+1) = cellstr(num2str(nanmean(Y(ROIWhiteIHEP(mm).temp))*EnlargeTimes / ScaleFactor(1)));
    end    
    toc
end
xlswrite(Outname1,OutA);
xlswrite(Outname2,OutB);
xlswrite(Outname3,OutC);
disp(strcat('       Extracting  ',char(ResultFiles(kk)),'Done!!' ));
end
disp('All Extraction Done!');
end
