function varargout = Smudgy_Module(varargin)
% SMUDGY_MODULE MATLAB code for Smudgy_Module.fig
%      SMUDGY_MODULE, by itself, creates a new SMUDGY_MODULE or raises the existing
%      singleton*.
%
%      H = SMUDGY_MODULE returns the handle to a new SMUDGY_MODULE or the handle to
%      the existing singleton*.
%
%      SMUDGY_MODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SMUDGY_MODULE.M with the given input arguments.
%
%      SMUDGY_MODULE('Property','Value',...) creates a new SMUDGY_MODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Smudgy_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Smudgy_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Smudgy_Module

% Last Modified by GUIDE v2.5 18-Mar-2018 16:10:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Smudgy_Module_OpeningFcn, ...
                   'gui_OutputFcn',  @Smudgy_Module_OutputFcn, ...
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


% --- Executes just before Smudgy_Module is made visible.
function Smudgy_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Smudgy_Module (see VARARGIN)

% Choose default command line output for Smudgy_Module
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Smudgy_Module wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Smudgy_Module_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SmudgyBrowse.
function SmudgyBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to SmudgyBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('Data', 'dir')
    mkdir('Data');
end
if ~exist('Data\SRC', 'dir')
    mkdir('Data\SRC');
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
if ~exist('Data\SmudgyResult', 'dir')
    mkdir('Data\SmudgyResult');
end
set(handles.Smudgy1,'string',' ');
set(handles.Smudgy2,'string',' ');
set(handles.Smudgy3,'string',' ');
delete('Data\SRC\*.jpg');
[filename, pathname]= uigetfile('*.jpg','Select an Image for effect');
iview=imread(strcat(pathname,filename));
imwrite(iview,['Data\SRC\',filename]);
set(handles.Smudgy1,'string','Ready to Deploy Effect ...');

% --- Executes on button press in SmudgyApply.
function SmudgyApply_Callback(hObject, eventdata, handles)
% hObject    handle to SmudgyApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSLRimage;
set(handles.Smudgy1,'string',' ');
set(handles.Smudgy2,'string',' ');
set(handles.Smudgy3,'string',' ');
set(handles.Smudgy1,'string','Processing Started ...');
pause(1);
set(handles.Smudgy2,'string','Fetching useful regions ...');
pause(1);
DSLRimage=Main_4SmudgyResult();
figure,imshow(DSLRimage);
set(handles.Smudgy3,'string','Process Completed ...');


% --- Executes on button press in SmudgySave.
function SmudgySave_Callback(hObject, eventdata, handles)
% hObject    handle to SmudgySave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSLRimage;
set(handles.Smudgy1,'string',' ');
set(handles.Smudgy2,'string',' ');
set(handles.Smudgy3,'string',' ');
pro_name=dir(fullfile('Data/SmudgyResult/*.png'));
folder_name = uigetdir('C:\','Select directory to save Image');
imwrite(DSLRimage,[folder_name '\' pro_name(1).name]);
set(handles.Smudgy1,'string',strcat('Image Saved at location : ',folder_name));
delete('Data\SRC\*.jpg');
delete('Data\Res\*.png');
delete('Data\Proposed\*.png');
delete('Data\Edges\*.jpg');
delete('Data\SmudgyResult\*.png');

if exist('Data\SRC', 'dir')
    rmdir('Data\SRC');
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
if exist('Data\SmudgyResult', 'dir')
    rmdir('Data\SmudgyResult');
end
if exist('Data', 'dir')
    rmdir('Data');
end