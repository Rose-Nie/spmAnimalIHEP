function varargout = spmAnimalIHEP(varargin)
% SPMANIMALIHEP MATLAB code for spmAnimalIHEP.fig
%      SPMANIMALIHEP, by itself, creates a new SPMANIMALIHEP or raises the existing
%      singleton*.
%
%      H = SPMANIMALIHEP returns the handle to a new SPMANIMALIHEP or the handle to
%      the existing singleton*.
%
%      SPMANIMALIHEP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPMANIMALIHEP.M with the given input arguments.
%
%      SPMANIMALIHEP('Property','Value',...) creates a new SPMANIMALIHEP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spmAnimalIHEP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spmAnimalIHEP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spmAnimalIHEP

% Last Modified by GUIDE v2.5 21-Mar-2024 21:25:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spmAnimalIHEP_OpeningFcn, ...
                   'gui_OutputFcn',  @spmAnimalIHEP_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before spmAnimalIHEP is made visible.
function spmAnimalIHEP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spmAnimalIHEP (see VARARGIN)

% Choose default command line output for spmAnimalIHEP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


%-------定义全局变量(nbb-2021.06.24)-----------
global defaults;
global spmanimalIHEPsets;

if isempty(spmanimalIHEPsets)
    initspmanimalIHEPsets;
end

global Prepross_parameter;
Prepross_parameter.flag = 0;
Prepross_parameter.data = '';
Prepross_parameter.template = '';
%---------------------------------------------

addpath(spmanimalIHEPsets.pathn);
addpath(spmanimalIHEPsets.path);
%---------------------------------------------
% 初始化预处理及统计分析等按钮，根据选择的数据类型再对按钮开放
% nbb 2021.06.24
set(handles.pushbutton_PET,'Enable','off');
set(handles.pushbutton_BOLD,'Enable','off');
set(handles.pushbuttonDTI,'Enable','off');
set(handles.pushbutton_Structural,'Enable','off');
set(handles.radiobutton4,'Enable','off');
set(handles.radiobutton_MRI,'Enable','off');
set(handles.pushbutton_RunTwosample,'Enable','off');
set(handles.radiobutton_active,'Enable','off');
set(handles.radiobutton_deactive,'Enable','off');
set(handles.radiobutton_AD,'Enable','off');
set(handles.pushbutton_printresults,'Enable','off');
set(handles.radiobuttonWB,'Enable','off');
set(handles.radiobuttonWM,'Enable','off');
set(handles.radiobuttonGM,'Enable','off');
%---------------------------------------------
disp(' ');
disp('Welcome to use the toolbox of spm --- spmAnimalIHEP~~~');
disp('Please cite ....');
disp('For Rat,please cite .....: ');
disp('Nie, Binbin, et al. Human brain mapping, 2013,34:1306-1318. ');
disp('For Mouse,please cite .....:');
disp('Nie, Binbin, et al.Mag netic Resonance Imaging, 2019, 57: 83-94. ');
disp('For Monkey,please cite.....:');
disp('Nie, Binbin, et al. NeuroImage, 2019, 203: 116163.');



% UIWAIT makes spmAnimalIHEP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spmAnimalIHEP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu_animal_type.
function popupmenu_animal_type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_animal_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_animal_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_animal_type
%-------定义全局变量(nbb-2021.06.24)-----------
global defaults;
global spmanimalIHEPsets;
%---------------------------------------------
%---------------------------------------------
% 判断选择的待处理的数据类型
% spmanimalIHEPsets.datatype =  2 --- Rat
%                               3 --- Mouse
%                               4 --- Monkey
% nbb 2021.06.24
spmanimalIHEPsets.datatype = get(handles.popupmenu_animal_type,'value');
switch spmanimalIHEPsets.datatype
    case 2 % Rat
        %---------------------------------------------
        % 添加路径
        % nbb -----2021.06.24
        mypath = which('spmAnimalIHEP');
        rmpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.path = fullfile(fileparts(mypath),'replace_rat'); % 设置结果MIP的路径
        addpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.resultpath = pwd;
        %---------------------------------------------
        %---------------------------------------------
        % 设定可使用的预处理及统计分析的功能
        % nbb 2021.06.24
        set(handles.pushbutton_PET,'Enable','on');
        set(handles.pushbutton_BOLD,'Enable','on');
        set(handles.pushbutton_Structural,'Enable','on');
        set(handles.pushbuttonDTI,'Enable','on');

        set(handles.radiobutton4,'Enable','on');
        set(handles.radiobutton_MRI,'Enable','on');
        set(handles.pushbutton_RunTwosample,'Enable','on');
        set(handles.radiobutton_active,'Enable','on');
%         set(handles.radiobutton_deactive,'Enable','on');
        set(handles.radiobutton_AD,'Enable','on');
        set(handles.pushbutton_printresults,'Enable','on');
        set(handles.radiobuttonWB,'Enable','on');
        set(handles.radiobuttonWM,'Enable','on');
        set(handles.radiobuttonGM,'Enable','on');
         set(handles.radiobuttonWB,'Value',1);
        %---------------------------------------------
        
        
    case 3 % Mouse
        %---------------------------------------------
        % 添加路径
        % nbb -----2021.06.24
        mypath = which('spmAnimalIHEP');
        rmpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.path = fullfile(fileparts(mypath),'replace_mouse');
        addpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.resultpath = pwd;
        %---------------------------------------------
        %---------------------------------------------
        %---------------------------------------------
        % 设定可使用的预处理及统计分析的功能
        % nbb 2021.06.24
        set(handles.pushbutton_PET,'Enable','off');
        set(handles.pushbutton_BOLD,'Enable','on');
        set(handles.pushbutton_Structural,'Enable','on');
        set(handles.pushbuttonDTI,'Enable','on');
        
        set(handles.radiobutton4,'Enable','on');
        set(handles.radiobutton_MRI,'Enable','on');
        set(handles.pushbutton_RunTwosample,'Enable','on');
        set(handles.radiobutton_active,'Enable','on');
%         set(handles.radiobutton_deactive,'Enable','on');
        set(handles.radiobutton_AD,'Enable','on');
        set(handles.pushbutton_printresults,'Enable','on');
        set(handles.radiobuttonWB,'Enable','on');
        set(handles.radiobuttonWM,'Enable','on');
        set(handles.radiobuttonGM,'Enable','on');
         set(handles.radiobuttonWB,'Value',1);
        %---------------------------------------------
        
        
    case 4 %Monkey
% %         %---------------------------------------------
% %         % 添加路径
% %         % nbb -----2021.06.24
% %         mypath = which('spmAnimalIHEP');
% %         spmanimalIHEPsets.path = fullfile(fileparts(mypath),'replace_monkey');
% %         addpath(spmanimalIHEPsets.path);
% %         %---------------------------------------------
% %         %---------------------------------------------
% %         % 设定可使用的预处理及统计分析的功能
% %         % nbb 2021.06.24
        set(handles.pushbutton_PET,'Enable','off');
        set(handles.pushbutton_BOLD,'Enable','off');
        set(handles.pushbutton_Structural,'Enable','off');
        set(handles.pushbuttonDTI,'Enable','off');

% %         set(handles.radiobutton4,'Enable','on');
% %         set(handles.radiobutton_MRI,'Enable','on');
% %         set(handles.pushbutton_RunTwosample,'Enable','on');
% %         %---------------------------------------------

    case 5 % TreeShew
        %---------------------------------------------
        % 添加路径
        % nbb -----2021.06.24
        mypath = which('spmAnimalIHEP');
        rmpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.path = fullfile(fileparts(mypath),'replace_Treeshew'); % 设置结果MIP的路径
        addpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.resultpath = pwd;
        %---------------------------------------------
        %---------------------------------------------
        % 设定可使用的预处理及统计分析的功能
        % nbb 2021.06.24
        set(handles.pushbutton_PET,'Enable','on');
        set(handles.pushbutton_BOLD,'Enable','off');
        set(handles.pushbutton_Structural,'Enable','off');
        set(handles.pushbuttonDTI,'Enable','off');

        set(handles.radiobutton4,'Enable','on');
        set(handles.radiobutton_MRI,'Enable','off');
        set(handles.pushbutton_RunTwosample,'Enable','on');
        set(handles.radiobuttonWB,'Enable','on');
        set(handles.radiobuttonWM,'Enable','on');
        set(handles.radiobuttonGM,'Enable','on');
        set(handles.radiobuttonWB,'Value',1);
        set(handles.radiobutton_active,'Enable','on');
%         set(handles.radiobutton_deactive,'Enable','on');
        set(handles.radiobutton_AD,'Enable','on');
        set(handles.pushbutton_printresults,'Enable','on');
        %---------------------------------------------
        
        
        case 6 % Zebra Fench
        %---------------------------------------------
        % 添加路径
        % nbb -----2021.06.24
        mypath = which('spmAnimalIHEP');
        rmpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.path = fullfile(fileparts(mypath),'replace_ZebraFinch'); % 设置结果MIP的路径
        addpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.resultpath = pwd;
        %---------------------------------------------
        %---------------------------------------------
        % 设定可使用的预处理及统计分析的功能
        % nbb 2021.06.24
        set(handles.pushbutton_PET,'Enable','off');
        set(handles.pushbutton_BOLD,'Enable','on');
        set(handles.pushbutton_Structural,'Enable','off');
        set(handles.pushbuttonDTI,'Enable','off');

        set(handles.radiobutton4,'Enable','off');
        set(handles.radiobutton_MRI,'Enable','on');
        set(handles.pushbutton_RunTwosample,'Enable','on');
        set(handles.radiobuttonWB,'Enable','on');
        set(handles.radiobuttonWM,'Enable','on');
        set(handles.radiobuttonGM,'Enable','on');
        set(handles.radiobuttonWB,'Value',1);
        set(handles.radiobutton_active,'Enable','on');
%         set(handles.radiobutton_deactive,'Enable','on');
        set(handles.radiobutton_AD,'Enable','on');
        set(handles.pushbutton_printresults,'Enable','on');
        %---------------------------------------------
        
        case 7 % Parrot
        %---------------------------------------------
        % 添加路径
        % nbb -----2021.06.24
        mypath = which('spmAnimalIHEP');
        rmpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.path = fullfile(fileparts(mypath),'replace_Parrot'); % 设置结果MIP的路径
        addpath(spmanimalIHEPsets.path);
        spmanimalIHEPsets.resultpath = pwd;
        %---------------------------------------------
        %---------------------------------------------
        % 设定可使用的预处理及统计分析的功能
        % nbb 2021.06.24
        set(handles.pushbutton_PET,'Enable','off');
        set(handles.pushbutton_BOLD,'Enable','on');
        set(handles.pushbutton_Structural,'Enable','off');
        set(handles.pushbuttonDTI,'Enable','off');

        set(handles.radiobutton4,'Enable','off');
        set(handles.radiobutton_MRI,'Enable','on');
        set(handles.pushbutton_RunTwosample,'Enable','on');
        set(handles.radiobuttonWB,'Enable','on');
        set(handles.radiobuttonWM,'Enable','off');
        set(handles.radiobuttonGM,'Enable','off');
        set(handles.radiobuttonWB,'Value',1);
        set(handles.radiobutton_active,'Enable','on');
%         set(handles.radiobutton_deactive,'Enable','on');
        set(handles.radiobutton_AD,'Enable','on');
        set(handles.pushbutton_printresults,'Enable','on');
        %---------------------------------------------
% %                

end
return;


% --- Executes during object creation, after setting all properties.
function popupmenu_animal_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_animal_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%--------------------------------------------------
% 初始化设置参数，主要保证replace的函数能够被正确的调用 ----nbb
function initspmanimalIHEPsets
global spmanimalIHEPsets;
        mypath = which('spmAnimalIHEP');
        spmanimalIHEPsets.path = fullfile(fileparts(mypath),'replace_rat');
        spmanimalIHEPsets.pathn = fullfile(fileparts(mypath),'batch_programs');
        spmanimalIHEPsets.flag = 1; % 设定标志信息，表示spmratIHEP工具包正在运行
        spmanimalIHEPsets.datatype = 0; % 设定数据类型的标志信息，根据该标志位，能够判断运行哪个程序
        spmanimalIHEPsets.writename = ''; % 用于保存写出的文件名称
        spmanimalIHEPsets.writefilelength = [0 0]; % 用于保存写出的文件长度
        spmanimalIHEPsets.normaliseflag = 0; % 设定数据标准化标志信息，0表示标准化未运行
        spmanimalIHEPsets.resultpath = pwd;
        spmanimalIHEPsets.ROIresultpath = pwd;
%--------------------------------------------------


% --- Executes on button press in pushbutton_PET.
function pushbutton_PET_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PET_preprocess;

% --- Executes on button press in pushbutton_BOLD.
function pushbutton_BOLD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_BOLD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Bold_preprocess;

% --- Executes on button press in pushbutton_Structural.
function pushbutton_Structural_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Structural (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Structural_preprocess;


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton_MRI,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton_MRI.
function radiobutton_MRI_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton4,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_MRI



function edit_resultPath_Callback(hObject, eventdata, handles)
% hObject    handle to edit_resultPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_resultPath as text
%        str2double(get(hObject,'String')) returns contents of edit_resultPath as a double


% --- Executes during object creation, after setting all properties.
function edit_resultPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_resultPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_LoadPath.
function pushbutton_LoadPath_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_LoadPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spmanimalIHEPsets;
Pathold = spmanimalIHEPsets.resultpath;
ResultPath = uigetdir(Pathold, 'Path of OutPath of Results ....');
if ~isempty(ResultPath)
    spmanimalIHEPsets.resultpath = ResultPath;
    set(handles.edit_resultPath,'string',ResultPath);
else
    set(handles.edit_resultPath,'string',Pathold);
end


% --- Executes on button press in pushbutton_RunTwosample.
function pushbutton_RunTwosample_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_RunTwosample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spmanimalIHEPsets;
SubPathName = get(handles.edit2,'String');
if(isempty(SubPathName))
    ResultOutPath = strcat(spmanimalIHEPsets.resultpath,filesep,'Results');
else
    ResultOutPath = strcat(spmanimalIHEPsets.resultpath,filesep,SubPathName);
end
mkdir(ResultOutPath);
FlagPET = get(handles.radiobutton4,'Value');
FlagMRI = get(handles.radiobutton_MRI,'Value');
if FlagPET
    Flag = 1;
else if FlagMRI
        Flag = 2;
    end
end

FlagWB = get(handles.radiobuttonWB,'Value');
FlagWM = get(handles.radiobuttonWM,'Value');
FlagGM = get(handles.radiobuttonGM,'Value');
if FlagWB
    FlagMask = 1;
else if FlagWM
        FlagMask = 2;
    else if FlagGM
            FlagMask = 3;
        end
    end
end

IHEPtwosampleTest(ResultOutPath,Flag,FlagMask);
%  IHEPtwosampleTest_nanjingtaibai(ResultOutPath,Flag);


% --- Executes on button press in radiobutton_active.
function radiobutton_active_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_active (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.radiobutton_active,'Value',0);
set(handles.radiobutton_deactive,'Value',0);
set(handles.radiobutton_AD,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_active


% --- Executes on button press in radiobutton_deactive.
function radiobutton_deactive_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_deactive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton_active,'Value',0);
% set(handles.radiobutton_deactive,'Value',0);
set(handles.radiobutton_AD,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_deactive


% --- Executes on button press in radiobutton_AD.
function radiobutton_AD_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_AD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton_active,'Value',0);
set(handles.radiobutton_deactive,'Value',0);
% set(handles.radiobutton_AD,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_AD


% --- Executes on button press in pushbutton_printresults.
function pushbutton_printresults_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_printresults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FlagActive = get(handles.radiobutton_active,'Value');
FlagDeactive = get(handles.radiobutton_deactive,'Value');
FlagAD = get(handles.radiobutton_AD,'Value');
if FlagActive
    IHEP_print_figures(1);
else if FlagDeactive
        IHEP_print_figures(3);
    else if FlagAD
            IHEP_print_figures(2);
        end
    end
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%-------定义全局变量(nbb-2011.11.03)-----------
global defaults;
global spmanimalIHEPsets;
%---------------------------------------------
%-------清除变量并初始化batch(nbb-2011.11.04)--
rmpath(spmanimalIHEPsets.path);
rmpath(spmanimalIHEPsets.pathn);

defaults = [];
spm_get_defaults;
spm_jobman('initcfg');
%---------------------------------------------
return;


% --- Executes on button press in pushbutton_Selectusertemplatefiles.
function pushbutton_Selectusertemplatefiles_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Selectusertemplatefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_ROI = spm_select(Inf, 'image', 'Select the Nifit files ...');
if isempty(file_ROI)
    errordlg('The Nifiti image should not be empty ....');
    return;
else
    n = size(file_ROI,1);
    for i = 1:n
        clear filetemp;
        t = find(file_ROI(i,:) == 44);
        filetemp = file_ROI(i,1:(t-1));
        Filenew(i,:) = cellstr(filetemp);
        clear filetemp;
    end
    Prepross_parameter.data = char(Filenew);
    set(handles.listbox_maketemplate,'string',file_ROI);
    return;
end

% --- Executes on selection change in listbox_maketemplate.
function listbox_maketemplate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_maketemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_maketemplate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_maketemplate


% --- Executes during object creation, after setting all properties.
function listbox_maketemplate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_maketemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Reference.
function pushbutton_Reference_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_template = spm_select(1, 'image', 'Select template image ...');
if isempty(file_template)
    errordlg('The template image should not be empty ....');
    return;
else
    t = find(file_template == 44);
    Prepross_parameter.template = file_template(1:(t-1));
    set(handles.text_Reference,'string',file_template(1:(t-1)));
    return;
end

% --- Executes on button press in pushbutton_Runuser.
function pushbutton_Runuser_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Runuser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%-------定义全局变量(nbb-2021.06.24)-----------
global Prepross_parameter;
%---------------------------------------------
Files = Prepross_parameter.data;
Template = Prepross_parameter.template;
IHEP_maketemplate(Template,Files);
NumFiles = size(Files,1);
for i = 1:NumFiles
    [P,N,E] = fileparts(Files(i,:));
    Filesw(i,:)= cellstr(strcat(P,filesep,'w',N,E));
end
Fileswn = char(Filesw);
IHEP_outmean(Fileswn);
disp('                   The userdefined template done.');



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ROIPath_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ROIPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ROIPath as text
%        str2double(get(hObject,'String')) returns contents of edit_ROIPath as a double


% --- Executes during object creation, after setting all properties.
function edit_ROIPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ROIPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ROIpath.
function pushbutton_ROIpath_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ROIpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spmanimalIHEPsets;
Pathold = spmanimalIHEPsets.ROIresultpath;
ResultPath = uigetdir(Pathold, 'Path of OutPath of Results ....');
if ~isempty(ResultPath)
    spmanimalIHEPsets.ROIresultpath = ResultPath;
    set(handles.edit_ROIPath,'string',ResultPath);
else
    set(handles.edit_ROIPath,'string',Pathold);
end


function edit_ResultFileName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ResultFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ResultFileName as text
%        str2double(get(hObject,'String')) returns contents of edit_ResultFileName as a double


% --- Executes during object creation, after setting all properties.
function edit_ResultFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ResultFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_extractionROI.
function pushbutton_extractionROI_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_extractionROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spmanimalIHEPsets;
disp('Start to extract ROI value in atlas images  ...................');
ResultName = get(handles.edit_ResultFileName,'String');
if(isempty(ResultName))
    ResultOutPath = strcat(spmanimalIHEPsets.ROIresultpath,filesep,'ROIResults_');
else
    ResultOutPath = strcat(spmanimalIHEPsets.ROIresultpath,filesep,ResultName,'_');
end
EnlargeTimes = str2num(get(handles.edit_enlarge,'String'));
IHEP_ROI_value_extraction(ResultOutPath,EnlargeTimes);
disp('                             ROI Extraction DONE!');



function edit_enlarge_Callback(hObject, eventdata, handles)
% hObject    handle to edit_enlarge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_enlarge as text
%        str2double(get(hObject,'String')) returns contents of edit_enlarge as a double


% --- Executes during object creation, after setting all properties.
function edit_enlarge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_enlarge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDTI.
function pushbuttonDTI_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDTI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DTI_preprocess;

% --- Executes on button press in radiobuttonWB.
function radiobuttonWB_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonWB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonWB
set(handles.radiobuttonWM,'Value',0);
set(handles.radiobuttonGM,'Value',0);
set(handles.radiobuttonWB,'Value',1);

% --- Executes on button press in radiobuttonWM.
function radiobuttonWM_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonWM
set(handles.radiobuttonWM,'Value',1);
set(handles.radiobuttonGM,'Value',0);
set(handles.radiobuttonWB,'Value',0);

% --- Executes on button press in radiobuttonGM.
function radiobuttonGM_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonGM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonGM
set(handles.radiobuttonWM,'Value',0);
set(handles.radiobuttonGM,'Value',1);
set(handles.radiobuttonWB,'Value',0);
