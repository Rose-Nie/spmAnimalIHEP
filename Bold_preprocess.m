function varargout = Bold_preprocess(varargin)
% BOLD_PREPROCESS MATLAB code for Bold_preprocess.fig
%      BOLD_PREPROCESS, by itself, creates a new BOLD_PREPROCESS or raises the existing
%      singleton*.
%
%      H = BOLD_PREPROCESS returns the handle to a new BOLD_PREPROCESS or the handle to
%      the existing singleton*.
%
%      BOLD_PREPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOLD_PREPROCESS.M with the given input arguments.
%
%      BOLD_PREPROCESS('Property','Value',...) creates a new BOLD_PREPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bold_preprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bold_preprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bold_preprocess

% Last Modified by GUIDE v2.5 25-Jul-2024 10:44:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bold_preprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @Bold_preprocess_OutputFcn, ...
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


% --- Executes just before Bold_preprocess is made visible.
function Bold_preprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bold_preprocess (see VARARGIN)

% Choose default command line output for Bold_preprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Bold_preprocess wait for user response (see UIRESUME)
% uiwait(handles.figure_Bold_process);

%-------定义全局变量(nbb-2021.06.24)-----------
global Prepross_parameter;
Prepross_parameter.flag = 0;
Prepross_parameter.data = '';
Prepross_parameter.template = '';
Prepross_parameter.T2 = '';
Prepross_parameter.templateuser = '';
Prepross_parameter.brainmat = '';
Prepross_parameter.templateT2 = '';
% set(handles.pushbutton_Template,'Enable','off');
%-----------------------------------------------


% --- Outputs from this function are returned to the command line.
function varargout = Bold_preprocess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_ROI = spm_select(Inf, '.nii$', 'Select the 4D Nifit files ...');
if isempty(file_ROI)
    errordlg('The Nifiti image should not be empty ....');
    return;
else
    Prepross_parameter.data = file_ROI;
    set(handles.listbox1,'string',file_ROI);
    return;
end


% --- Executes on button press in checkbox_Deletefiles.
function checkbox_Deletefiles_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Deletefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Deletefiles



function edit_Deletefiles_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Deletefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Deletefiles as text
%        str2double(get(hObject,'String')) returns contents of edit_Deletefiles as a double


% --- Executes during object creation, after setting all properties.
function edit_Deletefiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Deletefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_SliceTiming.
function checkbox_SliceTiming_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_SliceTiming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_SliceTiming



function edit_TR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TR as text
%        str2double(get(hObject,'String')) returns contents of edit_TR as a double


% --- Executes during object creation, after setting all properties.
function edit_TR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_Realign.
function checkbox_Realign_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Realign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Realign


% --- Executes on button press in checkbox_Normalization.
function checkbox_Normalization_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Normalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Normalization
Normalization = get(handles.checkbox_Normalization,'Value');
if Normalization
    set(handles.checkbox9,'Value',0);
    set(handles.checkboxT2,'Value',0);
end



% --- Executes on button press in pushbutton_Template.
function pushbutton_Template_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Template (see GCBO)
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
    set(handles.text_Template,'string',file_template(1:(t-1)));
    return;
end



% --- Executes on button press in pushbutton_RunPreBOLD.
function pushbutton_RunPreBOLD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_RunPreBOLD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%-------定义全局变量(nbb-2021.06.24)-----------
global Prepross_parameter;
%---------------------------------------------
Files = Prepross_parameter.data;
Prepross_parameter.flag = 0;
Deletefiles = get(handles.checkbox_Deletefiles,'Value');
SliceTiming = get(handles.checkbox_SliceTiming,'Value');
Realign = get(handles.checkbox_Realign,'Value');
Normalization = get(handles.checkbox_Normalization,'Value');
NormalizationUser = get(handles.checkbox9,'Value');
NormalizationT2 = get(handles.checkboxT2,'Value');
if NormalizationUser
    Normalization = 0;
    NormalizationT2 = 0;
end
if NormalizationT2
    Normalization = 0;
    NormalizationUser = 0;
end

if Deletefiles
    Prepross_parameter.flag = 1;
    str_Deletefiles = get(handles.edit_Deletefiles,'String');
    Deletenumbs_nbb = str2num(str_Deletefiles);
    IHEPDeleteBOLDfiles(Files,Deletenumbs_nbb);
end

if SliceTiming
    if(Prepross_parameter.flag == 0)
        str_TR = get(handles.edit_TR,'String');
        numTRnbb = str2num(str_TR);
        Prepross_parameter.flag = 20;
        IHEPSliceTiming_batch(Files,numTRnbb)
        
    elseif(Prepross_parameter.flag == 1)
        str_TR = get(handles.edit_TR,'String');
        numTRnbb = str2num(str_TR); 
        Prepross_parameter.flag = 21;
        NumFiles = size(Files,1);
        for i = 1:NumFiles
            [P,N,E] = fileparts(Files(i,:));
            Filesn(i,:) = cellstr(strcat(P,filesep,'n',N,E));
        end
        Filesnn = char(Filesn);
        IHEPSliceTiming_batch(Filesnn,numTRnbb)
    end
    clear Filesn;
    clear Filesnn;    
end

if Realign
    if(Prepross_parameter.flag == 0)
        IHEPRealign_batch(Files);
        Prepross_parameter.flag = 300;
    else if(Prepross_parameter.flag == 1)
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'n',N,E));
                end
                Filesnn = char(Filesn);
                IHEPRealign_batch(Filesnn);
                Prepross_parameter.flag = 301;
        else if(Prepross_parameter.flag == 20) 
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'a',N,E));
                end
                Filesnn = char(Filesn);
                IHEPRealign_batch(Filesnn);
                Prepross_parameter.flag = 320;
            else if(Prepross_parameter.flag == 21) 
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'an',N,E));
                end
                Filesnn = char(Filesn);
                IHEPRealign_batch(Filesnn);
                Prepross_parameter.flag = 321;
                end
            end
        end
    end
        
    clear Filesn;
    clear Filesnn;    
end

if Normalization
%     set(handles.pushbutton_Template,'Enable','on');
    Template = Prepross_parameter.template;

    if(Prepross_parameter.flag == 0)
        NumFiles = size(Files,1);
        for i = 1:NumFiles
            [P,N,E] = fileparts(Files(i,:));
            Filesn(i,:) = cellstr(strcat(P,filesep,N,E));
            Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N(2:end),E));
            Filesw(i,:)= cellstr(strcat(P,filesep,'w',N,E));
            Filessw(i,:)= cellstr(strcat(P,filesep,'sw',N,E));
        end
         Filesnn = char(Filesn);
         Regsnn = char(Regsn); 
         Prepross_parameter.flag = 4000;
        
    else if(Prepross_parameter.flag ==1)            
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'n',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wn',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swn',N,E));
                end
                Filesnn = char(Filesn);
                Regsnn = char(Regsn);                
                Prepross_parameter.flag = 4001;
                
        else if(Prepross_parameter.flag == 20)                
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'a',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wa',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swa',N,E));
                end
                Filesnn = char(Filesn);               
                Regsnn = char(Regsn);            
                Prepross_parameter.flag = 4020;
                
            else if(Prepross_parameter.flag == 21)
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'an',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'meann',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wan',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swan',N,E));
                end
                Filesnn = char(Filesn);                
                Regsnn = char(Regsn);
                Prepross_parameter.flag = 4021;
                    
                else if(Prepross_parameter.flag == 300)
                        NumFiles = size(Files,1);
                        for i = 1:NumFiles
                            [P,N,E] = fileparts(Files(i,:));
                            Filesn(i,:) = cellstr(strcat(P,filesep,'r',N,E));
                            Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                            Filesw(i,:)= cellstr(strcat(P,filesep,'wr',N,E));
                            Filessw(i,:)= cellstr(strcat(P,filesep,'swr',N,E));
                        end
                        Filesnn = char(Filesn);
                        Regsnn = char(Regsn);   
                        Prepross_parameter.flag = 4300;
                        
                    else if(Prepross_parameter.flag == 301)
                            NumFiles = size(Files,1);
                            for i = 1:NumFiles
                                [P,N,E] = fileparts(Files(i,:));
                                Filesn(i,:) = cellstr(strcat(P,filesep,'rn',N,E));
                                Regsn(i,:) = cellstr(strcat(P,filesep,'meann',N,E));
                                Filesw(i,:)= cellstr(strcat(P,filesep,'wrn',N,E));
                                Filessw(i,:)= cellstr(strcat(P,filesep,'swrn',N,E));
                            end
                            Filesnn = char(Filesn);
                            Regsnn = char(Regsn);
                            Prepross_parameter.flag = 4301;
                            
                         else if(Prepross_parameter.flag == 320)
                                     NumFiles = size(Files,1);
                                    for i = 1:NumFiles
                                        [P,N,E] = fileparts(Files(i,:));
                                        Filesn(i,:) = cellstr(strcat(P,filesep,'ra',N,E));
                                        Regsn(i,:) = cellstr(strcat(P,filesep,'meana',N,E));
                                        Filesw(i,:)= cellstr(strcat(P,filesep,'wra',N,E));
                                        Filessw(i,:)= cellstr(strcat(P,filesep,'swra',N,E));
                                    end
                                    Filesnn = char(Filesn);
                                    Regsnn = char(Regsn);
                                    Prepross_parameter.flag = 4320;
                                    
                              else if(Prepross_parameter.flag == 321)
                                       NumFiles = size(Files,1);
                                        for i = 1:NumFiles
                                            [P,N,E] = fileparts(Files(i,:));
                                            Filesn(i,:) = cellstr(strcat(P,filesep,'ran',N,E));
                                            Regsn(i,:) = cellstr(strcat(P,filesep,'meanan',N,E));
                                            Filesw(i,:)= cellstr(strcat(P,filesep,'wran',N,E));
                                            Filessw(i,:)= cellstr(strcat(P,filesep,'swran',N,E));
                                        end
                                        Filesnn = char(Filesn);
                                        Regsnn = char(Regsn);
                                        Prepross_parameter.flag = 4321;
                                  end
                             end
                        end
                    end
                end
            end
        end
    end
    
    Flipx = get(handles.checkbox_FlipX,'Value');
    Flipy = get(handles.checkbox_FlipY,'Value');
    Flipz = get(handles.checkbox_FlipZ,'Value');    
    if (Flipx || Flipy || Flipz)
        IHEP_change_header(Filesnn,Regsnn,Flipx,Flipy,Flipz);
    end
    IHEP_old_normalization(Template,Regsnn,Filesnn);
    Fileswn = char(Filesw);
    Filesswn = char(Filessw);
    IHEPadapttoMIP(Fileswn);
    IHEP_smooth(Fileswn);
    IHEP_mask_images_nbb(Fileswn);
    IHEP_mask_images_nbb(Filesswn);
    clear Filesn;
    clear Filesnn;   
end

if NormalizationUser
%     set(handles.pushbutton_Template,'Enable','on');
    Template = Prepross_parameter.templateuser;
    Matfile = Prepross_parameter.brainmat;

    if(Prepross_parameter.flag == 0)
        NumFiles = size(Files,1);
        for i = 1:NumFiles
            [P,N,E] = fileparts(Files(i,:));
            Filesn(i,:) = cellstr(strcat(P,filesep,N,E));
            Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N(2:end),E));
            Fileswtt(i,:)= cellstr(strcat(P,filesep,'w',N,E));
            Filesw(i,:)= cellstr(strcat(P,filesep,'ww',N,E));
            Filessw(i,:)= cellstr(strcat(P,filesep,'sww',N,E));
        end
         Filesnn = char(Filesn);
         Regsnn = char(Regsn); 
         Fileswttn = char(Fileswtt);
         Prepross_parameter.flag = 4000;
        
    else if(Prepross_parameter.flag ==1)            
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'n',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                    Fileswtt(i,:)= cellstr(strcat(P,filesep,'wn',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wwn',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swwn',N,E));
                end
                Filesnn = char(Filesn);
                Regsnn = char(Regsn);    
                Fileswttn = char(Fileswtt);
                Prepross_parameter.flag = 4001;
                
        else if(Prepross_parameter.flag == 20)                
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'a',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                    Fileswtt(i,:)= cellstr(strcat(P,filesep,'wa',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wwa',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swwa',N,E));
                end
                Filesnn = char(Filesn);               
                Regsnn = char(Regsn); 
                Fileswttn = char(Fileswtt);
                Prepross_parameter.flag = 4020;
                
            else if(Prepross_parameter.flag == 21)
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'an',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'meann',N,E));
                    Fileswtt(i,:)= cellstr(strcat(P,filesep,'wan',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wwan',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swwan',N,E));
                end
                Filesnn = char(Filesn);                
                Regsnn = char(Regsn);
                Fileswttn = char(Fileswtt);
                Prepross_parameter.flag = 4021;
                    
                else if(Prepross_parameter.flag == 300)
                        NumFiles = size(Files,1);
                        for i = 1:NumFiles
                            [P,N,E] = fileparts(Files(i,:));
                            Filesn(i,:) = cellstr(strcat(P,filesep,'r',N,E));
                            Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                            Fileswtt(i,:)= cellstr(strcat(P,filesep,'wr',N,E));
                            Filesw(i,:)= cellstr(strcat(P,filesep,'wwr',N,E));
                            Filessw(i,:)= cellstr(strcat(P,filesep,'swwr',N,E));
                        end
                        Filesnn = char(Filesn);
                        Regsnn = char(Regsn);   
                        Fileswttn = char(Fileswtt);
                        Prepross_parameter.flag = 4300;
                        
                    else if(Prepross_parameter.flag == 301)
                            NumFiles = size(Files,1);
                            for i = 1:NumFiles
                                [P,N,E] = fileparts(Files(i,:));
                                Filesn(i,:) = cellstr(strcat(P,filesep,'rn',N,E));
                                Regsn(i,:) = cellstr(strcat(P,filesep,'meann',N,E));
                                Fileswtt(i,:)= cellstr(strcat(P,filesep,'wrn',N,E));
                                Filesw(i,:)= cellstr(strcat(P,filesep,'wwrn',N,E));
                                Filessw(i,:)= cellstr(strcat(P,filesep,'swwrn',N,E));
                            end
                            Filesnn = char(Filesn);
                            Regsnn = char(Regsn);
                            Fileswttn = char(Fileswtt);
                            Prepross_parameter.flag = 4301;
                            
                         else if(Prepross_parameter.flag == 320)
                                     NumFiles = size(Files,1);
                                    for i = 1:NumFiles
                                        [P,N,E] = fileparts(Files(i,:));
                                        Filesn(i,:) = cellstr(strcat(P,filesep,'ra',N,E));
                                        Regsn(i,:) = cellstr(strcat(P,filesep,'meana',N,E));
                                        Fileswtt(i,:)= cellstr(strcat(P,filesep,'wra',N,E));
                                        Filesw(i,:)= cellstr(strcat(P,filesep,'wwra',N,E));
                                        Filessw(i,:)= cellstr(strcat(P,filesep,'swwra',N,E));
                                    end
                                    Filesnn = char(Filesn);
                                    Regsnn = char(Regsn);
                                    Prepross_parameter.flag = 4320;
                                    
                              else if(Prepross_parameter.flag == 321)
                                       NumFiles = size(Files,1);
                                        for i = 1:NumFiles
                                            [P,N,E] = fileparts(Files(i,:));
                                            Filesn(i,:) = cellstr(strcat(P,filesep,'ran',N,E));
                                            Regsn(i,:) = cellstr(strcat(P,filesep,'meanan',N,E));
                                            Fileswtt(i,:)= cellstr(strcat(P,filesep,'wran',N,E));
                                            Filesw(i,:)= cellstr(strcat(P,filesep,'wwran',N,E));
                                            Filessw(i,:)= cellstr(strcat(P,filesep,'swwran',N,E));
                                        end
                                        Filesnn = char(Filesn);
                                        Regsnn = char(Regsn);
                                        Fileswttn = char(Fileswtt);
                                        Prepross_parameter.flag = 4321;
                                  end
                             end
                        end
                    end
                end
            end
        end
    end
    
    Flipx = get(handles.checkbox_FlipX,'Value');
    Flipy = get(handles.checkbox_FlipY,'Value');
    Flipz = get(handles.checkbox_FlipZ,'Value');    
    if (Flipx || Flipy || Flipz)
        IHEP_change_header(Filesnn,Regsnn,Flipx,Flipy,Flipz);
    end
    IHEP_old_normalization_touser(Template,Regsnn,Filesnn);
    IHEP_to_use_write_old_normalization(Matfile,Fileswttn);
    Fileswn = char(Filesw);
    Filesswn = char(Filessw);
    IHEPadapttoMIP(Fileswn);
    IHEP_smooth(Fileswn);
    IHEP_mask_images_nbb(Fileswn);
    IHEP_mask_images_nbb(Filesswn);
    clear Filesn;
    clear Filesnn;   
end

if NormalizationT2
    T2Images = Prepross_parameter.T2;
    Template = Prepross_parameter.templateT2;

    if(Prepross_parameter.flag == 0)
        NumFiles = size(Files,1);
        for i = 1:NumFiles
            [P,N,E] = fileparts(Files(i,:));
            Filesn(i,:) = cellstr(strcat(P,filesep,N,E));
            Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N(2:end),E));
            Fileswtt(i,:)= cellstr(strcat(P,filesep,'r',N,E));
            Filesw(i,:)= cellstr(strcat(P,filesep,'wr',N,E));
            Filessw(i,:)= cellstr(strcat(P,filesep,'swr',N,E));
        end
         Filesnn = char(Filesn);
         Regsnn = char(Regsn); 
         Fileswttn = char(Fileswtt);
         Prepross_parameter.flag = 4000;
        
    else if(Prepross_parameter.flag ==1)            
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'n',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                    Fileswtt(i,:)= cellstr(strcat(P,filesep,'rn',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wrn',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swrn',N,E));
                end
                Filesnn = char(Filesn);
                Regsnn = char(Regsn);    
                Fileswttn = char(Fileswtt);
                Prepross_parameter.flag = 4001;
                
        else if(Prepross_parameter.flag == 20)                
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'a',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                    Fileswtt(i,:)= cellstr(strcat(P,filesep,'ra',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wra',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swra',N,E));
                end
                Filesnn = char(Filesn);               
                Regsnn = char(Regsn); 
                Fileswttn = char(Fileswtt);
                Prepross_parameter.flag = 4020;
                
            else if(Prepross_parameter.flag == 21)
                NumFiles = size(Files,1);
                for i = 1:NumFiles
                    [P,N,E] = fileparts(Files(i,:));
                    Filesn(i,:) = cellstr(strcat(P,filesep,'an',N,E));
                    Regsn(i,:) = cellstr(strcat(P,filesep,'meann',N,E));
                    Fileswtt(i,:)= cellstr(strcat(P,filesep,'ran',N,E));
                    Filesw(i,:)= cellstr(strcat(P,filesep,'wran',N,E));
                    Filessw(i,:)= cellstr(strcat(P,filesep,'swran',N,E));
                end
                Filesnn = char(Filesn);                
                Regsnn = char(Regsn);
                Fileswttn = char(Fileswtt);
                Prepross_parameter.flag = 4021;
                    
                else if(Prepross_parameter.flag == 300)
                        NumFiles = size(Files,1);
                        for i = 1:NumFiles
                            [P,N,E] = fileparts(Files(i,:));
                            Filesn(i,:) = cellstr(strcat(P,filesep,'r',N,E));
                            Regsn(i,:) = cellstr(strcat(P,filesep,'mean',N,E));
                            Fileswtt(i,:)= cellstr(strcat(P,filesep,'rr',N,E));
                            Filesw(i,:)= cellstr(strcat(P,filesep,'wrr',N,E));
                            Filessw(i,:)= cellstr(strcat(P,filesep,'swrr',N,E));
                        end
                        Filesnn = char(Filesn);
                        Regsnn = char(Regsn);   
                        Fileswttn = char(Fileswtt);
                        Prepross_parameter.flag = 4300;
                        
                    else if(Prepross_parameter.flag == 301)
                            NumFiles = size(Files,1);
                            for i = 1:NumFiles
                                [P,N,E] = fileparts(Files(i,:));
                                Filesn(i,:) = cellstr(strcat(P,filesep,'rn',N,E));
                                Regsn(i,:) = cellstr(strcat(P,filesep,'meann',N,E));
                                Fileswtt(i,:)= cellstr(strcat(P,filesep,'rrn',N,E));
                                Filesw(i,:)= cellstr(strcat(P,filesep,'wrrn',N,E));
                                Filessw(i,:)= cellstr(strcat(P,filesep,'swrrn',N,E));
                            end
                            Filesnn = char(Filesn);
                            Regsnn = char(Regsn);
                            Fileswttn = char(Fileswtt);
                            Prepross_parameter.flag = 4301;
                            
                         else if(Prepross_parameter.flag == 320)
                                     NumFiles = size(Files,1);
                                    for i = 1:NumFiles
                                        [P,N,E] = fileparts(Files(i,:));
                                        Filesn(i,:) = cellstr(strcat(P,filesep,'ra',N,E));
                                        Regsn(i,:) = cellstr(strcat(P,filesep,'meana',N,E));
                                        Fileswtt(i,:)= cellstr(strcat(P,filesep,'rra',N,E));
                                        Filesw(i,:)= cellstr(strcat(P,filesep,'wrra',N,E));
                                        Filessw(i,:)= cellstr(strcat(P,filesep,'swrra',N,E));
                                    end
                                    Filesnn = char(Filesn);
                                    Regsnn = char(Regsn);
                                    Prepross_parameter.flag = 4320;
                                    
                              else if(Prepross_parameter.flag == 321)
                                       NumFiles = size(Files,1);
                                        for i = 1:NumFiles
                                            [P,N,E] = fileparts(Files(i,:));
                                            Filesn(i,:) = cellstr(strcat(P,filesep,'ran',N,E));
                                            Regsn(i,:) = cellstr(strcat(P,filesep,'meanan',N,E));
                                            Fileswtt(i,:)= cellstr(strcat(P,filesep,'rran',N,E));
                                            Filesw(i,:)= cellstr(strcat(P,filesep,'wrran',N,E));
                                            Filessw(i,:)= cellstr(strcat(P,filesep,'swrran',N,E));
                                        end
                                        Filesnn = char(Filesn);
                                        Regsnn = char(Regsn);
                                        Fileswttn = char(Fileswtt);
                                        Prepross_parameter.flag = 4321;
                                  end
                             end
                        end
                    end
                end
            end
        end
    end
    
    Flipx = get(handles.checkbox_FlipX,'Value');
    Flipy = get(handles.checkbox_FlipY,'Value');
    Flipz = get(handles.checkbox_FlipZ,'Value');    
    if (Flipx || Flipy || Flipz)
        IHEP_change_header(Filesnn,Regsnn,Flipx,Flipy,Flipz);
    end
    IHEP_NormaltoT2(T2Images,Regsnn,Filesnn,Template)
    Fileswn = char(Filesw);
    Filesswn = char(Filessw);
    IHEPadapttoMIP(Fileswn);
    IHEP_smooth(Fileswn);
    IHEP_mask_images_nbb(Fileswn);
    IHEP_mask_images_nbb(Filesswn);
    clear Filesn;
    clear Filesnn;   
end

 disp('                   ALL THE BOLD PREPROCESSES DONE.');
%----------------------------
% 程序返回时需要修改一下flag
% nbb 20210625
Prepross_parameter.flag = 0;
%--------------------------




% --- Executes on button press in checkbox_FlipX.
function checkbox_FlipX_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_FlipX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_FlipX


% --- Executes on button press in checkbox_FlipY.
function checkbox_FlipY_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_FlipY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_FlipY


% --- Executes on button press in checkbox_FlipZ.
function checkbox_FlipZ_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_FlipZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_FlipZ


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
NormalizationUser = get(handles.checkbox9,'Value');
if NormalizationUser
    set(handles.checkboxT2,'Value',0);
    set(handles.checkbox_Normalization,'Value',0);
end

% --- Executes on button press in pushbutton_select_user_mean_template.
function pushbutton_select_user_mean_template_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_user_mean_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_template = spm_select(1, 'image', 'Select user template image ...');
if isempty(file_template)
    errordlg('The template image should not be empty ....');
    return;
else
    t = find(file_template == 44);
    Prepross_parameter.templateuser = file_template(1:(t-1));
    set(handles.text_userMean,'string',file_template(1:(t-1)));
    return;
end

% --- Executes on button press in pushbutton_UserMeanBrain.
function pushbutton_UserMeanBrain_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_UserMeanBrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_template = spm_select(1, '.mat$', 'Select user matfile ...');
if isempty(file_template)
    errordlg('The template image should not be empty ....');
    return;
else
%     t = find(file_template == 44);
    Prepross_parameter.brainmat = file_template;
    set(handles.text_usermeanbrain,'string',file_template);
    return;
end


% --- Executes on button press in pushbutton_movefiles.
function pushbutton_movefiles_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_movefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MoveFiles;
if isempty(MoveFiles)
    MoveFiles.imagepath = pwd;
    MoveFiles.outpath = pwd;
end
disp('Start to move files for quantitive analysis ...................');
tic
Filter = get(handles.edit_Filter,'String');
nf = length(Filter);
SubPathName = get(handles.edit_outPathSubFolder,'String');
FolderPath = MoveFiles.imagepath;
OutPath = strcat(MoveFiles.outpath,filesep,SubPathName);
FolderDir       = dir(FolderPath);
for i = 3:length(FolderDir)
    TryFolder           = FolderDir(i).isdir; %判断是否是文件夹
    if(TryFolder ==1)
        Folder1Name         = FolderDir(i).name;
        ImgPath             = [FolderPath filesep Folder1Name];
        ImgMovePath         = strcat(OutPath,'\Subject',Folder1Name);
        mkdir(ImgMovePath)
        DirExp              = dir(ImgPath);  %找到图像所在的文件夹
        for j = 3:length(DirExp)
            ImgName         = [];
            ImgName         = DirExp(j).name;
             if (strcmp(ImgName(1:nf),Filter) ==1)
                ImagePath   = [ImgPath filesep ImgName];
                strii = num2str(i-2);
                disp([strii '  Moving ' ImagePath]);
                disp(['             To ' ImgMovePath]);
                movefile(ImagePath, ImgMovePath);
            end
        end        
    end
end
disp('                                       MOVING FILES DONE');
toc


function edit_bold_niiPath_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bold_niiPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bold_niiPath as text
%        str2double(get(hObject,'String')) returns contents of edit_bold_niiPath as a double


% --- Executes during object creation, after setting all properties.
function edit_bold_niiPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bold_niiPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_select_boldniipath.
function pushbutton_select_boldniipath_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_boldniipath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MoveFiles;
if isempty(MoveFiles)
    MoveFiles.imagepath = pwd;
    MoveFiles.outpath = pwd;
end
Pathold = MoveFiles.imagepath;
ResultPath = uigetdir(Pathold, 'Path of OutPath of Results ....');
if ~isempty(ResultPath)
    MoveFiles.imagepath = ResultPath;
    set(handles.edit_bold_niiPath,'string',ResultPath);
else
    set(handles.edit_bold_niiPath,'string',Pathold);
end


function edit_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Filter as text
%        str2double(get(hObject,'String')) returns contents of edit_Filter as a double


% --- Executes during object creation, after setting all properties.
function edit_Filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_outPath_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outPath as text
%        str2double(get(hObject,'String')) returns contents of edit_outPath as a double


% --- Executes during object creation, after setting all properties.
function edit_outPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_outPath.
function pushbutton_outPath_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_outPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MoveFiles;
if isempty(MoveFiles)
    MoveFiles.imagepath = pwd;
    MoveFiles.outpath = pwd;
end
Pathold = MoveFiles.outpath;
ResultPath = uigetdir(Pathold, 'Path of OutPath of Results ....');
if ~isempty(ResultPath)
    MoveFiles.outpath = ResultPath;
    set(handles.edit_outPath,'string',ResultPath);
else
    set(handles.edit_outPath,'string',Pathold);
end


function edit_outPathSubFolder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outPathSubFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outPathSubFolder as text
%        str2double(get(hObject,'String')) returns contents of edit_outPathSubFolder as a double


% --- Executes during object creation, after setting all properties.
function edit_outPathSubFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outPathSubFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxT2.
function checkboxT2_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NormalizationT2 = get(handles.checkboxT2,'Value');
if NormalizationT2
    set(handles.checkbox_Normalization,'Value',0);
    set(handles.checkbox9,'Value',0); 
end

% --- Executes on button press in pushbuttonT2.
function pushbuttonT2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_ROI = spm_select(Inf, '.nii$', 'Select the individual T2 files ...');
if isempty(file_ROI)
    errordlg('The individual T2 images should not be empty ....');
    return;
else
    FileData = Prepross_parameter.data;
    if(size(FileData,1) == size(file_ROI,1))
        Prepross_parameter.T2 = file_ROI;
        return;
    else
        errordlg('The numbers of individual T2 images is not equal to Bold Files !!');
        return;
    end
end


% --- Executes on button press in pushbuttonT2template.
function pushbuttonT2template_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonT2template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_template = spm_select(1, 'image', 'Select T2 template image ...');
if isempty(file_template)
    errordlg('The template image should not be empty ....');
    return;
else
    t = find(file_template == 44);
    Prepross_parameter.templateT2 = file_template(1:(t-1));
    set(handles.textT2template,'string',file_template(1:(t-1)));
    return;
end
