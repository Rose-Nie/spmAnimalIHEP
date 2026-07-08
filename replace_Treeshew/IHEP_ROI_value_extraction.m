function IHEP_ROI_value_extraction(ResultOutPath,EnlargeTimes)
%IHEP_ROI_VALUE_EXTRACTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
File = spm_select(Inf,'image','Select Files to extract Mean value in ROIs .....');
n = size(File,1);
Outname1 = strcat(ResultOutPath,'inIHEPTreeShreeatlas_Enlarge',num2str(EnlargeTimes),'Times.xlsx'); % �޸��ļ����·��?
%-------------------------------------------
%ͼ��Ϊ��������ȡ����
load('ROITreeShewIHEP.mat');
OutB(1,1) = {'RegionName'};


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
  
    OutB(i+1,1) = cellstr(Indname);
    Fcount = 2;
    striii = num2str(i);
    disp([striii 'Extracting ' Indname ' ROIs from IHEP ATLAS .................']);

    for k = 1:84
        if(i == 1)
            OutB(1,k+1) = cellstr(strcat(char(ROI(k).name)));
        end
        OutB(i+1,k+1) = cellstr(num2str(nanmean(Y(ROI(k).temp))*EnlargeTimes/ ScaleFactor(1)));
    end
    
    toc
end

xlswrite(Outname1,OutB);


end

