function varargout = Eye_Filter_Module(varargin)
% EYE_FILTER_MODULE MATLAB code for Eye_Filter_Module.fig
%      EYE_FILTER_MODULE, by itself, creates a new EYE_FILTER_MODULE or raises the existing
%      singleton*.
%
%      H = EYE_FILTER_MODULE returns the handle to a new EYE_FILTER_MODULE or the handle to
%      the existing singleton*.
%
%      EYE_FILTER_MODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EYE_FILTER_MODULE.M with the given input arguments.
%
%      EYE_FILTER_MODULE('Property','Value',...) creates a new EYE_FILTER_MODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Eye_Filter_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Eye_Filter_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Eye_Filter_Module

% Last Modified by GUIDE v2.5 18-Mar-2018 16:55:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Eye_Filter_Module_OpeningFcn, ...
                   'gui_OutputFcn',  @Eye_Filter_Module_OutputFcn, ...
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


% --- Executes just before Eye_Filter_Module is made visible.
function Eye_Filter_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Eye_Filter_Module (see VARARGIN)

% Choose default command line output for Eye_Filter_Module
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global Icon;
Icon=0;
axes(handles.Ax1);
imshow('Data/icons/FinEye.jpg');
axes(handles.Ax2);
imshow('Data/icons/FinFir.jpg');
axes(handles.Ax3);
imshow('Data/icons/FinHrt.jpg');
axes(handles.Ax4);
imshow('Data/icons/FinMag.jpg');
axes(handles.Ax5);
imshow('Data/icons/FinMon.jpg');
axes(handles.Ax6);
imshow('Data/icons/FinSml.jpg');
axes(handles.Ax7);
imshow('Data/icons/FinStr.jpg');

% UIWAIT makes Eye_Filter_Module wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Eye_Filter_Module_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in EyeBrowse.
function EyeBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to EyeBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('Data', 'dir')
    mkdir('Data');
end
if ~exist('Data\SRC', 'dir')
    mkdir('Data\SRC');
end
if ~exist('Data\EyesEffectResult', 'dir')
    mkdir('Data\EyesEffectResult');
end
set(handles.Eye1,'string',' ');
set(handles.Eye2,'string',' ');
set(handles.Eye3,'string',' ');
delete('Data\SRC\*.jpg');
delete('Data\EyesEffectResult\*.png');
[filename, pathname]= uigetfile('*.jpg','Select an Image for Filter');
iview=imread(strcat(pathname,filename));
imwrite(iview,['Data\SRC\',filename]);
set(handles.Eye1,'string','Write no. of selected filter if not yet ...');
set(handles.Eye2,'string','Then we are Ready to Deploy Effect ...');



% --- Executes on button press in EyeApplyEffect.
function EyeApplyEffect_Callback(hObject, eventdata, handles)
% hObject    handle to EyeApplyEffect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Eye1,'string',' ');
set(handles.Eye2,'string',' ');
set(handles.Eye3,'string',' ');
set(handles.Eye1,'string','Processing Started ...');
pause(1);
set(handles.Eye2,'string','Fetching useful regions ...');
pause(1);
x = str2double(get(handles.ED1,'String')); 
Out=Main_9EyesEffectResult(x);
figure,imshow(Out);
set(handles.Eye3,'string','Process Completed ...');

% --- Executes during object creation, after setting all properties.
function ED1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ED1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ED1_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes on button press in EyeResult.
function EyeResult_Callback(hObject, eventdata, handles)
% hObject    handle to EyeResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Eye1,'string',' ');
set(handles.Eye2,'string',' ');
set(handles.Eye3,'string',' ');
pro_name=dir(fullfile('Data/EyesEffectResult/*.png'));
folder_name = uigetdir('C:\','Select directory to save Image');
imwrite(Out,[folder_name '\' pro_name(1).name]);
set(handles.Eye1,'string',strcat('Image Saved at location : ',folder_name));
delete('Data\SRC\*.jpg');
delete('Data\EyesEffectResult\*.png');
if exist('Data\SRC', 'dir')
    rmdir('Data\SRC');
end
if exist('Data\EyesEffectResult', 'dir')
   rmdir('Data\EyesEffectResult');
end
if exist('Data', 'dir')
    rmdir('Data');
end