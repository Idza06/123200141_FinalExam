function varargout = number2(varargin)
% NUMBER2 MATLAB code for number2.fig
%      NUMBER2, by itself, creates a new NUMBER2 or raises the existing
%      singleton*.
%
%      H = NUMBER2 returns the handle to a new NUMBER2 or the handle to
%      the existing singleton*.
%
%      NUMBER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NUMBER2.M with the given input arguments.
%
%      NUMBER2('Property','Value',...) creates a new NUMBER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before number2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to number2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help number2

% Last Modified by GUIDE v2.5 20-May-2022 08:11:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @number2_OpeningFcn, ...
                   'gui_OutputFcn',  @number2_OutputFcn, ...
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


% --- Executes just before number2 is made visible.
function number2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to number2 (see VARARGIN)

% Choose default command line output for number2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes number2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = number2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in showbutton_141.
function showbutton_141_Callback(hObject, eventdata, handles)
% hObject    handle to showbutton_141 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('laptop_price.csv');
opts.SelectedVariableNames = [5 8 12 13]; %column of the data in xlsx
dataset = readmatrix('laptop_price.csv','Range','E2:M51');

set(handles.table1, 'data', dataset);

% --- Executes on button press in resultbutton_141.
function resultbutton_141_Callback(hObject, eventdata, handles)
% hObject    handle to resultbutton_141 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('laptop_price.csv');
opts.SelectedVariableNames = [5 8 12 13]; %column of the data in xlsx
dataset = readmatrix('laptop_price.csv','Range','B2:M51');

%Attribute each criteria, 1 = benefit, and 0 = cost
criteria = [1,1,0,0];

%The weight value each criteria
weight = [1,3,2,4];

%calculate the values of column and row from data
[m,n] = size (dataset);

%divide the weight each criteria with total of the weights
weight = round(weight./sum(weight),2);

%multiply weight cost with -1 to make it minus
for j = 1:n
    if criteria(j) == 0, weight(j) =- 1*weight(j);
    end
end

%calculate vector S each row (for alternative company)
for i = 1:m
    S(i) = prod(dataset(i,:).^weight);
end

%ranking step
V = S/sum(S);

[sortedDist, index] = sort(V,'descend');
result = sortedDist.';
idx = index.';
ss = [result idx];
disp(ss);

set(handles.table2,'data',ss);
