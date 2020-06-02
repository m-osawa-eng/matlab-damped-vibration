function varargout = masdam(varargin)
% MASDAM M-file for masdam.fig
%      MASDAM, by itself, creates a new MASDAM or raises the existing
%      singleton*.
%
%      H = MASDAM returns the handle to a new MASDAM or the handle to
%      the existing singleton*.
%
%      MASDAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASDAM.M with the given input arguments.
%
%      MASDAM('Property','Value',...) creates a new MASDAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before masdam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to masdam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help masdam

% Last Modified by GUIDE v2.5 10-Jul-2013 18:18:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @masdam_OpeningFcn, ...
                   'gui_OutputFcn',  @masdam_OutputFcn, ...
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


% --- Executes just before masdam is made visible.
function masdam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to masdam (see VARARGIN)

% Choose default command line output for masdam
handles.output = hObject;
handles.x_angle=15;
handles.z_angle=45;
handles.K=2;
handles.M=5;
handles.b_l=30;
handles.r=0.01;
handles.x30=10;
handles.y40=10;
handles.t0=0;
handles.nmax=5;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes masdam wait for user response (see UIRESUME)
% uiwait(handles.fig);


% --- Outputs from this function are returned to the command line.
function varargout = masdam_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x_angle = handles.x_angle;
z_angle = handles.z_angle;
s=handles.K;
m=handles.M;
b_l =handles.b_l;
r = handles.r;
y0=handles.x30;
v0=handles.y40;
t0=handles.t0;
nmax=handles.nmax*100;
h=0.1;

w02 = s/m;
del = r/(2*m);%r/2*m
w0 = sqrt(w02-del^2);%sqrt(w02-del^2)

t = h*(t0:nmax+1);
y = zeros(length(t),1);

for i = 1:1:length(t)
    y(i,1) = y0*exp(-r/(2*m)*t(i))*cos(w0*t(i))+((v0+y0*r/(2*m))/w0)*exp(-r/(2*m)*t(i))*sin(w0*t(i));%r/2*m
end

if x_angle == 0
    XX_angle = 0;
elseif x_angle > 0
    XX_angle = x_angle:-0.25:0;
else
    XX_angle = x_angle:0.25:0;
end

if z_angle == 90
    ZZ_angle = 90;
elseif z_angle > 90
   ZZ_angle = z_angle:-0.25:90;
else
    ZZ_angle = z_angle:0.25:90;
end

T=0:pi/(nmax/10):10*pi+pi/(nmax/10);
ZZ = zeros(1,length(y))-1;
II=0:0.01:length(y)*0.01-0.01;


for i = 1:length(y)
    t=-b_l-5:(y(i)+b_l)/(length(y)-1):y(i)-5;
    axes(handles.dam_fig);
    plot3(t,0.5*sin(T),0.5*cos(T),'k','linewidth',3)
    hold on
    grid on
    X_box1 = [-1 -1 1 1 -1].*0.8;
    Y_box1 = [-1 1 1 -1 -1].*0.8;
    Z_box1 = [max(t) max(t) max(t) max(t) max(t)];
    plot3(Z_box1,X_box1,Y_box1,'linewidth',3);
    X_box2 = [-1 -1 1 1 -1].*0.8;
    Y_box2 = [-1 1 1 -1 -1].*0.8;
    Z_box2 = [max(t) max(t) max(t) max(t) max(t)]+10;
    plot3(Z_box2,X_box2,Y_box2,'linewidth',3);
    X_line1 = [-1 -1].*0.8;
    Y_line1 = [-1 -1].*0.8;
    Z_line1 = [max(t) max(t)+10];
    plot3(Z_line1,X_line1,Y_line1,'linewidth',3);
    X_line2 = [-1 -1].*0.8;
    Y_line2 = [1 1].*0.8;
    Z_line2 = [max(t) max(t)+10];
    plot3(Z_line2,X_line2,Y_line2,'linewidth',3);

    X_line3 = [1 1].*0.8;
    Y_line3 = [1 1].*0.8;
    Z_line3 = [max(t) max(t)+10];
    plot3(Z_line3,X_line3,Y_line3,'linewidth',3);

    X_line4 = [1 1].*0.8;
    Y_line4 = [-1 -1].*0.8;
    Z_line4 = [max(t) max(t)+10];
    plot3(Z_line4,X_line4,Y_line4,'linewidth',3);
    plot3(y(1:i),-(II(1:i)-i*0.01),ZZ(1:i),'r','linewidth',2.5);
    axis([-b_l-2 max(abs(y))+b_l+6 -1.5 1.5 -1 2])
    view([x_angle z_angle])
    drawnow
    

    hold off
     if i == length(y);
        for IIi = 1.5:0.02:max(II)
        axis([-b_l-5 max(abs(y))+b_l+6 -1.5 IIi+0.5 -1 2])
        view([x_angle z_angle])
        drawnow
        end
        if max([length(XX_angle)  length(ZZ_angle)]) ~= 1
            for IIi = 1:max([length(XX_angle)  length(ZZ_angle)])
                if IIi > length(XX_angle)
                    view([XX_angle(length(XX_angle)) ZZ_angle(IIi)])
                    drawnow
                        if max([length(XX_angle)  length(ZZ_angle)])==IIi
                            grid on
                            drawnow
                        end
                elseif IIi > length(ZZ_angle)
                    view([XX_angle(IIi) ZZ_angle(length(XX_angle))])
                    drawnow
                    if max([length(XX_angle)  length(ZZ_angle)])==IIi
                        grid on
                        drawnow
                    end
                else
                    view([XX_angle(IIi) ZZ_angle(IIi)])
                    drawnow
                end
            end
        else
            grid on
        end
    end
    drawnow
end




function Bane_len_Callback(hObject, eventdata, handles)
% hObject    handle to Bane_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Bane_len as text
%        str2double(get(hObject,'String')) returns contents of Bane_len as a double
handles.b_l = str2num(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Bane_len_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bane_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_Callback(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r as text
%        str2double(get(hObject,'String')) returns contents of r as a double
handles.r = str2num(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K_Callback(hObject, eventdata, handles)
% hObject    handle to K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K as text
%        str2double(get(hObject,'String')) returns contents of K as a double
handles.K = str2num(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function M_Callback(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M as text
%        str2double(get(hObject,'String')) returns contents of M as a double
handles.M = str2num(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_Callback(hObject, eventdata, handles)
% hObject    handle to t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t as text
%        str2double(get(hObject,'String')) returns contents of t as a double
handles.t0 = str2num(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_Callback(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x as text
%        str2double(get(hObject,'String')) returns contents of x as a double
handles.x30 = str2num(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_Callback(hObject, eventdata, handles)
% hObject    handle to v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v as text
%        str2double(get(hObject,'String')) returns contents of v as a double
handles.y40 = str2num(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double
handles.nmax = str2num(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sui_Callback(hObject, eventdata, handles)
% hObject    handle to sui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sui as text
%        str2double(get(hObject,'String')) returns contents of sui as a double
handles.x_angle = str2num(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function sui_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tyoku_Callback(hObject, eventdata, handles)
% hObject    handle to tyoku (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tyoku as text
%        str2double(get(hObject,'String')) returns contents of tyoku as a double
handles.z_angle = str2num(get(hObject,'String'));
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function tyoku_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tyoku (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


