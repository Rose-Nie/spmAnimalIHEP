function IHEP_ROI_value_extraction(ResultOutPath,EnlargeTimes)
%IHEP_ROI_VALUE_EXTRACTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
File = spm_select(Inf,'image','Select Files to extract Mean value in ROIs .....');
n = size(File,1);
Outname1 = strcat(ResultOutPath,'inSIGMAatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % �޸��ļ����·��?
Outname2 = strcat(ResultOutPath,'inIHEPPaxinosatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % �޸��ļ����·��?
Outname3 = strcat(ResultOutPath,'inIHEPPaxinosatlasWhitematter_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % �޸��ļ����·��?
%-------------------------------------------
%ͼ��Ϊ��������ȡ����
load('SIGMA_Region.mat');
load('ROI.mat');
load('ROIWhite.mat');
OutA(1,1) = {'RegionName'};
OutB(1,1) = {'RegionName'};
OutC(1,1) = {'RegionName'};

for i = 1:n
    tic
    Y = spm_read_vols(spm_vol(File(i,:)));
    [Indipath,Indname1,~] = fileparts(File(i,:));
    temp = find(Indipath == 92);
    V = spm_vol(File(i,:));
    ScaleFactor = V.pinfo;

%     [IndiPath,~,~] = fileparts(File(i,:));
%     Indname= IndiPath(41:end);
%   
    if(length(temp) == 1)
        Indname = strcat(Indipath(temp+1:end),'_',Indname1);
    else
    Indname = strcat(Indipath(temp(end-1):end),'_',Indname1);
    end
    OutA(i+1,1) = cellstr(Indname);
    OutB(i+1,1) = cellstr(Indname);
    OutC(i+1,1) = cellstr(Indname);
    Fcount = 2;
    striii = num2str(i);
    disp([striii 'Extracting ' Indname ' ROIs from SIGMA ATLAS .................']);
    for j = 1:117
        if(i == 1)
            OutA(1,Fcount) = cellstr(strcat(char(RegionName(j)),'_Left'));
            OutA(1,Fcount+1) = cellstr(strcat(char(RegionName(j)),'_Right'));
        end
%         OutA(i+1,Fcount) = cellstr(num2str(nanmean(Y(MIP_left(j).temp))*EnlargeTimes/ ScaleFactor(1)));
%         OutA(i+1,Fcount+1) = cellstr(num2str(nanmean(Y(MIP_right(j).temp))*EnlargeTimes/ ScaleFactor(1)));

        OutA(i+1,Fcount) = cellstr(num2str(nanmean(Y(MIP_left(j).temp))*EnlargeTimes));
        OutA(i+1,Fcount+1) = cellstr(num2str(nanmean(Y(MIP_right(j).temp))*EnlargeTimes));
        Fcount = Fcount + 2;
    end
    disp([striii 'Extracting ' Indname ' ROIs from IHEPPaxinos ATLAS .................']);
    for k = 1:131
        if(i == 1)
            OutB(1,k+1) = cellstr(strcat(char(ROI(k).name)));
        end
%         OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes/ ScaleFactor(1)));

        OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes));
    end
    disp([striii 'Extracting ' Indname ' ROIs from IHEPPaxinos Whitematter ATLAS .................']);
    for k = 1:22
        if(i == 1)
            OutC(1,k+1) = cellstr(strcat(char(ROIWhite(k).name)));
        end
        OutC(i+1,k+1) = cellstr(num2str(nanmean(Y(ROIWhite(k).temp))*EnlargeTimes/ ScaleFactor(1)));
    end
    toc
end
xlswrite(Outname1,OutA);
xlswrite(Outname2,OutB);
xlswrite(Outname3,OutC);

end

