function varargout = Person_Detect_Module(varargin)
% PERSON_DETECT_MODULE MATLAB code for Person_Detect_Module.fig
%      PERSON_DETECT_MODULE, by itself, creates a new PERSON_DETECT_MODULE or raises the existing
%      singleton*.
%
%      H = PERSON_DETECT_MODULE returns the handle to a new PERSON_DETECT_MODULE or the handle to
%      the existing singleton*.
%
%      PERSON_DETECT_MODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PERSON_DETECT_MODULE.M with the given input arguments.
%
%      PERSON_DETECT_MODULE('Property','Value',...) creates a new PERSON_DETECT_MODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Person_Detect_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Person_Detect_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Person_Detect_Module

% Last Modified by GUIDE v2.5 18-Mar-2018 17:02:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Person_Detect_Module_OpeningFcn, ...
                   'gui_OutputFcn',  @Person_Detect_Module_OutputFcn, ...
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


% --- Executes just before Person_Detect_Module is made visible.
function Person_Detect_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Person_Detect_Module (see VARARGIN)

% Choose default command line output for Person_Detect_Module
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Person_Detect_Module wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Person_Detect_Module_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PersonBrowse.
function PersonBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to PersonBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('Data', 'dir')
    mkdir('Data');
end
if ~exist('Data\SRC', 'dir')
    mkdir('Data\SRC');
end
if ~exist('Data\FaceDetectResult', 'dir')
    mkdir('Data\FaceDetectResult');
end
set(handles.Face1,'string',' ');
set(handles.Face2,'string',' ');
set(handles.Face3,'string',' ');
set(handles.CountTXT,'String','Total People in Image : ');

delete('Data\SRC\*.jpg');
delete('Data\FaceDetectResult\*.png');
[filename, pathname]= uigetfile('*.jpg','Select an Image for effect');
iview=imread(strcat(pathname,filename));
imwrite(iview,['Data\SRC\',filename]);
set(handles.Face1,'string','Ready to Deploy Effect ...');

% --- Executes on button press in PersonDetect.
function PersonDetect_Callback(hObject, eventdata, handles)
% hObject    handle to PersonDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Face1,'string',' ');
set(handles.Face2,'string',' ');
set(handles.Face3,'string',' ');
set(handles.Face1,'string','Processing Started ...');
pause(1);
set(handles.Face2,'string','Fetching useful regions ...');
pause(1);
[Out,totalperson]=Main_8FaceDetectResult();
ttxxtt=strcat('Total People in Image :-  ',int2str(totalperson));
set(handles.CountTXT,'String',ttxxtt);
figure,imshow(Out);
set(handles.Face3,'string','Process Completed ...');


% --- Executes on button press in PersonSave.
function PersonSave_Callback(hObject, eventdata, handles)
% hObject    handle to PersonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Face1,'string',' ');
set(handles.Face2,'string',' ');
set(handles.Face3,'string',' ');
pro_name=dir(fullfile('Data/FaceDetectResult/*.png'));
folder_name = uigetdir('C:\','Select directory to save Image');
imwrite(Out,[folder_name '\' pro_name(1).name]);
set(handles.Face1,'string',strcat('Image Saved at location : ',folder_name));
delete('Data\SRC\*.jpg');
delete('Data\FaceDetectResult\*.png');
if exist('Data\SRC', 'dir')
    rmdir('Data\SRC');
end
if exist('Data\FaceDetectResult', 'dir')
   rmdir('Data\FaceDetectResult');
end
if exist('Data', 'dir')
    rmdir('Data');
end
