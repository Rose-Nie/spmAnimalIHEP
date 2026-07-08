function IHEP_print_figures_tunshu( numbs )
%IHEP_PRINT_FIGURES 此处显示有关此函数的摘要
%   此处显示详细说明
if numbs == 1
    files = spm_select(Inf,'image','Input the result images..');
    IHEPNANtest(files)
    n = size(files,1);
    for i = 1:n
        slover('basic_ui',files(i,:));  
    end
            disp('Location the results images .....');
    extract_mean_scaled_spm12_IHEP(files);
            disp('                   Location the results images done.');

else if numbs ==2
        files_act = spm_select(Inf,'image','Input the active result images..');
        files_deact = spm_select(Inf,'image','Input the deactive result images..');
        IHEPNANtest(files_act);
        IHEPNANtest(files_deact);
        files_deact_new = IHEPdeactive(files_deact);
        
        n_act = size(files_act);
        n_deact = size(files_deact_new);
        
        if n_act(1) == n_deact(1)
            for i = 1:n_act(1)
                file_paired(1,1:n_act(2)) = files_act(i,:)
                file_paired(2,1:n_deact(2)) = files_deact_new(i,:);
                slover('basic_ui',file_paired);  
            end
        else
            error('The number of active images and deactive images must be equal.');
        end
%         file_res = [files_act;files_deact_new];


    else if numbs == 3
                files = spm_select(Inf,'image','Input the result images..');
                IHEPNANtest(files);
                filesnew = IHEPdeactive(files);
                n = size(filesnew,1);
                for i = 1:n
                    slover('basic_ui',filesnew(i,:));  
                end
        end
    end
end

end

