for i = 121:2:1458
    N = ROI(i).name;
     ROI(i).name = cellstr(strcat(char(N(1:end-1)),'R'));
end

for i = 122:2:1458
    N = ROI(i).name;
     ROI(i).name = cellstr(strcat(char(N(1:end-1)),'L'));
end