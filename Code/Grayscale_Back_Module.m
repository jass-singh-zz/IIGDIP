function varargout = Grayscale_Back_Module(varargin)
% GRAYSCALE_BACK_MODULE MATLAB code for Grayscale_Back_Module.fig
%      GRAYSCALE_BACK_MODULE, by itself, creates a new GRAYSCALE_BACK_MODULE or raises the existing
%      singleton*.
%
%      H = GRAYSCALE_BACK_MODULE returns the handle to a new GRAYSCALE_BACK_MODULE or the handle to
%      the existing singleton*.
%
%      GRAYSCALE_BACK_MODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAYSCALE_BACK_MODULE.M with the given input arguments.
%
%      GRAYSCALE_BACK_MODULE('Property','Value',...) creates a new GRAYSCALE_BACK_MODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Grayscale_Back_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Grayscale_Back_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Grayscale_Back_Module

% Last Modified by GUIDE v2.5 18-Mar-2018 16:59:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Grayscale_Back_Module_OpeningFcn, ...
                   'gui_OutputFcn',  @Grayscale_Back_Module_OutputFcn, ...
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


% --- Executes just before Grayscale_Back_Module is made visible.
function Grayscale_Back_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Grayscale_Back_Module (see VARARGIN)

% Choose default command line output for Grayscale_Back_Module
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Grayscale_Back_Module wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Grayscale_Back_Module_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GrayscaleBrowse.
function GrayscaleBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to GrayscaleBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('Data', 'dir')
    mkdir('Data');
end
if ~exist('Data\SRC', 'dir')
    mkdir('Data\SRC');
end
if ~exist('Data\BlackBackResult', 'dir')
    mkdir('Data\BlackBackResult');
end
if ~exist('Data\RES', 'dir')
    mkdir('Data\RES');
end
if ~exist('Data\Proposed', 'dir')
    mkdir('Data\Proposed');
end
if ~exist('Data\Edges', 'dir')
    mkdir('Data\Edges');
end
set(handles.Grayscale1,'string',' ');
set(handles.Grayscale2,'string',' ');
set(handles.Grayscale3,'string',' ');
delete('Data\SRC\*.jpg');
delete('Data\BlackBackResult\*.png');
[filename, pathname]= uigetfile('*.jpg','Select an Image for Effect');
iview=imread(strcat(pathname,filename));
imwrite(iview,['Data\SRC\',filename]);
set(handles.Grayscale1,'string','Ready to Deploy Effect ...');

% --- Executes on button press in GrayscaleEffect.
function GrayscaleEffect_Callback(hObject, eventdata, handles)
% hObject    handle to GrayscaleEffect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Grayscale1,'string',' ');
set(handles.Grayscale2,'string',' ');
set(handles.Grayscale3,'string',' ');
set(handles.Grayscale1,'string','Processing Started ...');
pause(1);
set(handles.Grayscale2,'string','Fetching useful regions ...');
pause(1);
Out=Main_6BlackBackResult();
figure,imshow(Out);
set(handles.Grayscale3,'string','Process Completed ...');


% --- Executes on button press in GrayscaleSave.
function GrayscaleSave_Callback(hObject, eventdata, handles)
% hObject    handle to GrayscaleSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Grayscale1,'string',' ');
set(handles.Grayscale2,'string',' ');
set(handles.Grayscale3,'string',' ');
pro_name=dir(fullfile('Data/BlackBackResult/*.png'));
folder_name = uigetdir('C:\','Select directory to save Image');
imwrite(Out,[folder_name '\' pro_name(1).name]);
set(handles.Grayscale1,'string',strcat('Image Saved at location : ',folder_name));
delete('Data\SRC\*.jpg');
delete('Data\BlackBackResult\*.png');
delete('Data\Res\*.png');
delete('Data\Proposed\*.png');
delete('Data\Edges\*.jpg');
if exist('Data\SRC', 'dir')
    rmdir('Data\SRC');
end
if exist('Data\BlackBackResult', 'dir')
   rmdir('Data\BlackBackResult');
end
if exist('Data\RES', 'dir')
   rmdir('Data\RES');
end
if exist('Data\Proposed', 'dir')
    rmdir('Data\Proposed');
end
if exist('Data\Edges', 'dir')
    rmdir('Data\Edges');
end
if exist('Data', 'dir')
    rmdir('Data');
end