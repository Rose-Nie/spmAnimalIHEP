function IHEP_ROI_value_extraction_automaticNBBBeiyisanyuan
%IHEP_ROI_VALUE_EXTRACTION 此处显示有关此函数的摘要
%   此处显示详细说明
% ResultFiles = [{'FA'};{'MD'};{'AD'};{'RD'};{'ReHo'};{'ALFF'};{'fALFF'};{'FC_Hyp'};{'Gray'};{'White'}];
% ResultFiles = [{'ReHo'};{'ALFF'};{'fALFF'};{'FC_Ent'};{'FC_Hip'};{'FC_PFC'}];
ResultFiles = [{'FA'};{'MD'};{'AD'};{'RD'}];
% ResultFiles = [{'ReHo'};{'ALFF'};{'fALFF'};{'FC_PVN'}];
EnlargeTimes = 1000;

for kk = 1:length(ResultFiles)
    load(strcat('G:\20240318_beiyisanyuan\DTI\',char(ResultFiles(kk)),'.mat'));
    ResultOutPath = strcat('G:\20240318_beiyisanyuan\DTI\ROIn241103\');
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
   
    Outname2 = strcat(ResultOutPath,'\Mean',char(ResultFiles(kk)),'_inIHEPPaxinosatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % 修改文件输出路径
    
  

%-------------------------------------------
%图谱为整个的提取方法

load('ROIBeiyisanyuan.mat');


OutB(1,1) = {'RegionName'};




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


    disp([striii 'Extracting ' Indname ' ROIs from IHEPPaxinos ATLAS .................']);
    for k = 1:20
        if(i == 1)
            OutB(1,k+1) = cellstr(strcat(char(ROI(k).name)));
        end
        OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes / ScaleFactor(1)));
    end
    

    toc
end

xlswrite(Outname2,OutB);

disp(strcat('       Extracting  ',char(ResultFiles(kk)),'Done!!' ));
end
disp('All Extraction Done!');
end
