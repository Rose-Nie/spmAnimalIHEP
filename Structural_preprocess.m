function varargout = Structural_preprocess(varargin)
% STRUCTURAL_PREPROCESS MATLAB code for Structural_preprocess.fig
%      STRUCTURAL_PREPROCESS, by itself, creates a new STRUCTURAL_PREPROCESS or raises the existing
%      singleton*.
%
%      H = STRUCTURAL_PREPROCESS returns the handle to a new STRUCTURAL_PREPROCESS or the handle to
%      the existing singleton*.
%
%      STRUCTURAL_PREPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURAL_PREPROCESS.M with the given input arguments.
%
%      STRUCTURAL_PREPROCESS('Property','Value',...) creates a new STRUCTURAL_PREPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Structural_preprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Structural_preprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Structural_preprocess

% Last Modified by GUIDE v2.5 25-Jun-2021 17:39:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Structural_preprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @Structural_preprocess_OutputFcn, ...
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


% --- Executes just before Structural_preprocess is made visible.
function Structural_preprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Structural_preprocess (see VARARGIN)

% Choose default command line output for Structural_preprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Structural_preprocess wait for user response (see UIRESUME)
% uiwait(handles.figure_structuralpreprocess);
%-------定义全局变量(nbb-2021.06.24)-----------
global Prepross_parameter;
Prepross_parameter.data = '';


% --- Outputs from this function are returned to the command line.
function varargout = Structural_preprocess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Seg.
function pushbutton_Seg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%-------定义全局变量(nbb-2021.06.24)-----------
global Prepross_parameter;
%---------------------------------------------
Files = Prepross_parameter.data;
IHEP_Structural_segmentation(Files);
n = size(Files,1);
for i = 1:n
    [path,name,ext] = fileparts(Files(i,:));
    file = strcat(path,'\mwc1',name,ext);
    IHEPadapttoMIP(file);
    clear file;
    file = strcat(path,'\mwc2',name,ext);
    IHEPadapttoMIP(file);
    clear file;
    file = strcat(path,'\mwc3',name,ext);
    IHEPadapttoMIP(file);
    clear file;
end

% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
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
    set(handles.listbox_listNII,'string',file_ROI);
    return;
end

% --- Executes on selection change in listbox_listNII.
function listbox_listNII_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_listNII (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_listNII contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_listNII


% --- Executes during object creation, after setting all properties.
function listbox_listNII_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_listNII (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
