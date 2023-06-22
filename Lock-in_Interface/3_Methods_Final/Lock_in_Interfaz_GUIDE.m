function varargout = Lock_in_Interfaz_GUIDE(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Lock_in_Interfaz_GUIDE_OpeningFcn, ...
                   'gui_OutputFcn',  @Lock_in_Interfaz_GUIDE_OutputFcn, ...
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

function Lock_in_Interfaz_GUIDE_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes4)
img = imread('IPN_CICATA.png');
axis off
imshow(img);

amp = zeros(256,320);
[fil,col] = size(amp);
set(handles.uitable1,'Data',amp);
set(handles.uitable2,'Data',amp);

cla(handles.axes3,'reset')
cla(handles.axes2,'reset')
mesh(handles.axes3,amp);
title(handles.axes3,'Amplitude');
view(handles.axes3,2);
axis(handles.axes3,[0 col 0 fil 0 1]);
colorbar(handles.axes3);
colormap(handles.axes3,gray);

mesh(handles.axes2,amp);
title(handles.axes2,'Phase');
view(handles.axes2,2);
axis(handles.axes2,[0 col 0 fil 0 1]);
colorbar(handles.axes2);
colormap(handles.axes2,gray);

set(handles.text26,'String','-');
set(handles.text27,'String','-');
set(handles.text28,'String','-');
set(handles.text29,'String','-');



handles.output = hObject;
guidata(hObject, handles);

function varargout = Lock_in_Interfaz_GUIDE_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function togglebutton1_Callback(hObject, eventdata, handles)

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")   
   set(hObject,'String','1500')
end

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")
   set(hObject,'String','10')
end

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")
   set(hObject,'String','150')   
end

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")
   set(hObject,'String','1')
end

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton2_Callback(hObject, eventdata, handles)
global file path str a fil col carpEjec ampActual fasActual parAmp
try
    carpEjec = cd;
    [file,path] = uigetfile('*.mat');
    cd(path)
    str = get(handles.edit1,'String'); 
    
    loading = waitbar(0,'Loading...');
    a = load(file);
    
    cd(carpEjec)        
    var = eval(strcat('a.',str,num2str(1)));    
    [fil, col]=size(var);
    maximo = max(max(var));
    minimo = min(min(var));
    media = mean(mean(var));
    tx1 = num2str(fil);
    tx2 = num2str(col);
    dimensiones = strcat(tx1," X ",tx2);
    
    waitbar(0.3,loading);
    pause(0.5)
    
    cla(handles.axes3,'reset')
    cla(handles.axes2,'reset')
    
    titulo = strcat(str,' 1');
    parAmp = [0 col 0 fil minimo maximo];
    
    mesh(handles.axes3,var);
    xlabel(handles.axes3,'Pixels');
    ylabel(handles.axes3,'Pixels');
    zlabel(handles.axes3,'Amplitude');
    title(handles.axes3,titulo)
    view(handles.axes3,2);
    axis(handles.axes3,[0 col 0 fil minimo maximo])

    mesh(handles.axes2,var);
    xlabel(handles.axes2,'Pixels');
    ylabel(handles.axes2,'Pixels');
    zlabel(handles.axes2,'Amplitude');
    title(handles.axes2,titulo)
    view(handles.axes2,2);
    axis(handles.axes2,[0 col 0 fil minimo maximo])
    
    waitbar(0.6,loading);
    pause(0.5)
    
    set(handles.uitable1,'Data',var);
    set(handles.uitable2,'Data',var);
    
    set(handles.text12,'String',titulo);
    set(handles.text13,'String',titulo);

    set(handles.text7,'String',path);    
        
    set(handles.text26,'String',dimensiones);
    set(handles.text27,'String',num2str(round(maximo,1)));
    set(handles.text28,'String',num2str(round(minimo,1)));
    set(handles.text29,'String',num2str(round(media,1)));
    
    set(handles.pushbutton3,'Enable','on');
    set(handles.pushbutton5,'Enable','off');
    
    ampActual = var;
    fasActual = var;
    
    waitbar(1,loading);
    pause(0.5)
    close(loading);
catch
    msgbox("Error loading file","Error","error");
end

function pushbutton3_Callback(hObject, eventdata, handles)
global   file path str a fil col carpEjec ampFinal fasFinal pend tituloAmp ampActual fasActual parAmp
try    
    numberOfImages = str2double(get(handles.edit2,'String'));
    numberOfPeriods= str2double(get(handles.edit3,'String'));
    sampleRate= str2double(get(handles.edit4,'String'));
    modulationFrequency= str2double(get(handles.edit5,'String'));
    cameraFocus= str2double(get(handles.edit7,'String'));
    cantTotalImagenes = ((1/modulationFrequency)*sampleRate)*numberOfPeriods;
    
    % ---------- Verificamos qué método está seleccionado ---------------- 
    s = get(handles.uibuttongroup1,'SelectedObject');
    seleccion = s.String;
    switch seleccion
        case 'Digital Lock-in'
            sel = 1;
        case 'Four-Points'
            sel = 2;
        case 'Fourier'
            sel = 3;
    end
        
    if cantTotalImagenes > numberOfImages
        msgbox("There must be agreement between the data","Warning","warn")
    else
        L = str2double(get(handles.edit2,'String'));                   % Cantidad de imágenes (longitud de de la señal en Fourier)
        cant_p = round(str2double(get(handles.edit3,'String')));       % Cantidad de períodos a analizar
        fs = str2double(get(handles.edit4,'String'));                  % Frecuencia de muestreo (frame rate de la cámara)
        fe = str2double(get(handles.edit5,'String'));                  % Frecuencia de modulación del experimento
        N = round((1/fe)*fs);                                          % Cantidad de imágenes que hay en un solo período
        lim = str2double(get(handles.edit9,'String'));                 % El usuario establece un limite para quitar los pixeles malos
        
        barra_progreso = waitbar(0,'Starting','Name','Lock-in processing');
        pause(1)
            
        if sel == 1
            % ------------ Método de Lock-in Digital -----------------
            s0_sum=0;                             % Iniciamos en 0 la variable donde acumulamos la suma de la componente en fase de todos los ciclos  
            s90_sum=0;                            % Iniciamos en 0 la variable donde acumulamos la suma de la componente en cuadratura de todos los ciclos
            cont_c=0;                             % Iniciamos en 0 un contador (esto es solo para ir viendo la barra de progreso en el procesamiento)
            for k=1:cant_p                        % k es la variable de control de ciclo para la cantidad de períodos
                for n=1:N                         % n es la variable de control de ciclo para la cantidad de imágenes que hay en un solo período
                    % Las siguientes 5 líneas de código son solo para la barra de progreso (no influyen en el procesamiento de los datos)
                    cont_c = cont_c+1;
                    q = round((cont_c/(N*cant_p))*100);
                    texto1 = 'Processing ... %d%%';
                    str1 = sprintf(texto1,q);
                    waitbar((cont_c/(N*cant_p)),barra_progreso,str1);
                    % -- Hasta aquí es el código de control de la barra de progreso --

                    w=(k-1)*N+n;                                         % w se encarga de tomar las imágenes de forma consecutiva de toda mi secuencia de imágenes
                    frame_t = eval(strcat('a.',str,num2str(w)));         % Convertimos a string el número de imagen guardado en "w" para concatenerlo con la palabra "Frame" y guardar los datos de esa imagen en "frame_t"
                    s0_sum  = s0_sum + frame_t*2*sin(2*pi*(n-1)/N);      % Acumulamos todas las sumas de las componentes en fase
                    s90_sum = s90_sum + frame_t*(-2)*cos(2*pi*(n-1)/N);  % Acumulamos todas las sumas de las componentes en cuadratura
                end
            end
            escalamiento=0.1;
            s0 = (escalamiento/(cant_p*N))*s0_sum;     % Hallamos el promedio de la componente en fase dividiendo entre la cantidad total de imágenes analizadas
            s90= (escalamiento/(cant_p*N))*s90_sum;    % Hallamos el promedio de la componente en cuadratura dividiendo entre la cantidad total de imágenes analizadas
                                               % Nota: El valor de 1.75 es solo un factor de escalamiento

            ampd = zeros(fil,col);              % Creamos nuestra matriz de amplitud
            fasd = zeros(fil,col);              % Creamos nuestra matriz de fase
            for f=1:fil                        % Hallamos los valores de amplitud y fase a partir de las componentes obtenidas, esto en cada uno de los pixeles de la imagen
                for c=1:col
                    ampd(f,c) = sqrt((s0(f,c))^2+(s90(f,c))^2);
                    fasd(f,c) = atan((s90(f,c))/(s0(f,c)));                
                end
            end

            % Con los siguientes ciclos "for" anidados recorremos la matriz de amplitud
            % obtenida para limitar los valores muy grandes que se pueden obtener debido 
            % a los malos pixeles que tiene la cámara físicamente. 
%             for f=1:fil
%                 for c=1:col
%                     if ampd(f,c)>=lim
%                         ampd(f,c) = 0.01;
%                     end        
%                 end
%             end
            close(barra_progreso)
            
        elseif sel == 2
            % ------------ Método de correlación de 4 puntos -----------------
            sum1 = zeros(fil,col);
            sum2 = zeros(fil,col);
            sum3 = zeros(fil,col);
            sum4 = zeros(fil,col);
            amp1 = zeros(fil,col);
            fas1 = zeros(fil,col);
            ampt = zeros(fil,col);
            fast = zeros(fil,col);
            cont1= 0;
            cont2= 0;
            cont3= 0;
            cont4= 0;
            cont_c=0;
            for k=0:cant_p-1
                for n=1+k*N:N+k*N
                    cont_c = cont_c+1;
                    q = round((cont_c/(N*cant_p))*100);
                    texto1 = 'Processing ... %d%%';
                    str1 = sprintf(texto1,q);
                    waitbar((cont_c/(N*cant_p)),barra_progreso,str1);

                    frame_t = eval(strcat('a.',str,num2str(n)));
                    if n<=N/4        
                        sum1 = sum1 + frame_t;
                        cont1=cont1+1;
                    elseif (N/4<n) && (n<=N/2)
                        sum2 = sum2 + frame_t;
                        cont2=cont2+1;
                    elseif (N/2<n) && (n<=3*N/4)
                        sum3 = sum3 + frame_t;
                        cont3=cont3+1;
                    elseif (3*N/4<n) && (n<=N)
                        sum4 = sum4 + frame_t;
                        cont4=cont4+1;
                    end
                end
                s1 = sum1/cont1;
                s2 = sum2/cont2;
                s3 = sum3/cont3;
                s4 = sum4/cont4;

                for f=1:fil
                    for c=1:col
                        fast(f,c) = atan((s3(f,c)-s1(f,c))/(s4(f,c)-s2(f,c)));
                        ampt(f,c) = sqrt((s3(f,c)-s1(f,c))^2+(s4(f,c)-s2(f,c))^2);        
                    end
                end

            amp1(:,:,k+1) = ampt;
            fas1(:,:,k+1) = fast;
            end

            amp_sum = zeros(fil,col);
            fas_sum = zeros(fil,col);
            for j=1:cant_p
                amp_sum = amp_sum+amp1(:,:,j);
                fas_sum = fas_sum+fas1(:,:,j);
            end

            amp4p = amp_sum/cant_p;
            fas4p = fas_sum/cant_p;
            close(barra_progreso)
            
        elseif sel == 3
            % ---------------- Método de Fourier ------------------
            N = L;
            k = round(N*(fe/fs)+1);

            cont = 0;
            Y = zeros(fil,col);            
            
            for n=1:1:N
                cont = cont+1;
                q = round((cont/(N))*100);
                texto1 = 'Processing ... %d%%';
                str1 = sprintf(texto1,q);
                waitbar((cont/(N)),barra_progreso,str1);

                frame_t = eval(strcat('a.',str,num2str(n)));

                Y = Y + frame_t*exp(-1j*2*pi*(k-1)*(n-1)/N);
            end
            
            ampf = 2*abs(Y/L);
            fasf = angle(Y);
            
%             for f=1:fil
%                 for c=1:col
%                     if ampf(f,c)>=lim
%                         ampf(f,c) = 0.01;
%                     end        
%                 end
%             end
            close(barra_progreso);
            
        end
        
    if sel == 1
        ampFinal = ampd;
        fasFinal = fasd;
    elseif sel == 2
        ampFinal = amp4p;
        fasFinal = fas4p;
    elseif sel == 3
        ampFinal = ampf;
        fasFinal = fasf;
    end
         
    ampActual = ampFinal;
    fasActual = fasFinal;
    
        % ----------------- Conversión de pixeles a milímetros -------------------
        dist_focal = cameraFocus;
        pend = 393e-6;
        
        % ------------- Creamos una malla a partir de la pendiente --------------
        if fil > col
            [eje_x,eje_y] = meshgrid(0:pend:fil*pend);
        elseif col > fil
            [eje_x,eje_y] = meshgrid(0:pend:col*pend);
        else
            [eje_x,eje_y] = meshgrid(0:pend:col*pend);
        end
        
        x1 = eje_x(1:(fil),1:col);
        y1 = eje_y(1:(fil),1:col);
                              
        % --- Hallar max y min para limitar los ejes hasta esos valores ---
        minAmp = min(min(ampFinal));
        maxAmp = max(max(ampFinal));
        medAmp = mean(mean(ampFinal));
        minFas = min(min(fasFinal));
        maxFas = max(max(fasFinal));
     
        % ------- Hallamos que unidades selecciona el usuario ----------       
        contAmp = cellstr(get(handles.popupmenu1,'String'));
        popAmp = contAmp(get(handles.popupmenu1,'Value'));
        if(strcmp(popAmp,'°C'))
            selecAmp = '°C';
        elseif (strcmp(popAmp,'K'))
            selecAmp = 'K';
        else
            selecAmp = 'DL';
        end
        
        % --- Concatenamos las unidades con el titulo de las graficas ---
        tituloAmp = strcat('Amplitude',' (',selecAmp,')');
        parAmp = [0 col*pend 0 fil*pend minAmp maxAmp];
        
        cla(handles.axes3,'reset')
        cla(handles.axes2,'reset')
        mesh(handles.axes3,x1,y1,ampFinal);
        title(handles.axes3,tituloAmp);
        xlabel(handles.axes3,'Length (m)');
        ylabel(handles.axes3,'Length (m)');
        view(handles.axes3,2);
        axis(handles.axes3,[0 col*pend 0 fil*pend minAmp maxAmp]);
        colorbar(handles.axes3);
        colormap(handles.axes3,hot);

        mesh(handles.axes2,x1,y1,fasFinal);
        title(handles.axes2,'Phase (rad)');
        xlabel(handles.axes2,'Length (m)');
        ylabel(handles.axes2,'Length (m)');
        view(handles.axes2,2);
        axis(handles.axes2,[0 col*pend 0 fil*pend minFas maxFas]);
        colorbar(handles.axes2);
        colormap(handles.axes2,hot);
        
        set(handles.text12,'String','Amplitude');
        set(handles.text13,'String','Phase');
        
        set(handles.uitable1,'Data',ampFinal);
        set(handles.uitable2,'Data',fasFinal);
        
        set(handles.text27,'String',num2str(round(maxAmp,1)));
        set(handles.text28,'String',num2str(round(minAmp,1)));
        set(handles.text29,'String',num2str(round(medAmp,1)));
        
        set(handles.pushbutton5,'Enable','on');         
    end       
catch
    msgbox("Upload the files","Error","error");
end

function figure1_CloseRequestFcn(hObject, eventdata, handles)
pregunta = questdlg('Do you want to exit?','EXIT','YES','NO','YES'); % (texto, titulo, boton1, boton2, boton que aparece marcado por defecto)
if strcmp(pregunta,'NO')
    return;
end
clear global % Borramos todas las variables globales al salir
try
    delete(Profiles);
    delete(Some_angles);
catch 
end
delete(hObject);

function edit7_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")
   set(hObject,'String','6150')
end

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox1_Callback(hObject, eventdata, handles)

function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton1_Callback(hObject, eventdata, handles)

function popupmenu1_Callback(hObject, eventdata, handles)

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu2_Callback(hObject, eventdata, handles)

function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton5_Callback(hObject, eventdata, handles)
global   ampActual fasActual pend tituloAmp
Profiles(ampActual,fasActual,pend,tituloAmp);

function radiobutton2_Callback(hObject, eventdata, handles)

function radiobutton3_Callback(hObject, eventdata, handles)

function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)

function uibuttongroup1_CreateFcn(hObject, eventdata, handles)

function pushbutton6_Callback(hObject, eventdata, handles)
global ampActual fasActual

[fil,col] = size(ampActual);
fas = cell(fil,col);
amp = cell(fil,col);
for f=1:1:fil
    for c=1:1:col
        fas(f,c)=num2cell(fasActual(f,c));
    end
end
for f=1:1:fil
    for c=1:1:col
        amp(f,c)=num2cell(ampActual(f,c));
    end
end
writecell(fas,'Phase.xlsx')
msgbox("The Phase has been saved successfully","Save");
writecell(amp,'Amplitude.xlsx')
msgbox("The Amplitude has been saved successfully","Save");

function listbox2_Callback(hObject, eventdata, handles)

function listbox2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu3_Callback(hObject, eventdata, handles)

function popupmenu3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slider1_Callback(hObject, eventdata, handles)

function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function popupmenu4_Callback(hObject, eventdata, handles)
celSel = cellstr(get(handles.popupmenu4,'String'));
sel = celSel(get(handles.popupmenu4,'Value'));
if(strcmp(sel,'hot'))
    colormap(handles.axes3,hot);
elseif (strcmp(sel,'parula'))
    colormap(handles.axes3,parula);
elseif (strcmp(sel,'turbo'))
    colormap(handles.axes3,turbo);
elseif (strcmp(sel,'hsv'))
    colormap(handles.axes3,hsv);
elseif (strcmp(sel,'cool'))
    colormap(handles.axes3,cool);
elseif (strcmp(sel,'spring'))
    colormap(handles.axes3,spring);
elseif (strcmp(sel,'summer'))
    colormap(handles.axes3,summer);
elseif (strcmp(sel,'autumn'))
    colormap(handles.axes3,autumn);
elseif (strcmp(sel,'winter'))
    colormap(handles.axes3,winter);
elseif (strcmp(sel,'gray'))
    colormap(handles.axes3,gray);
elseif (strcmp(sel,'bone'))
    colormap(handles.axes3,bone);
elseif (strcmp(sel,'copper'))
    colormap(handles.axes3,copper);
elseif (strcmp(sel,'pink'))
    colormap(handles.axes3,pink);
elseif (strcmp(sel,'jet'))
    colormap(handles.axes3,jet);
end

function popupmenu4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu5_Callback(hObject, eventdata, handles)
celSel = cellstr(get(handles.popupmenu5,'String'));
sel = celSel(get(handles.popupmenu5,'Value'));
if(strcmp(sel,'2D - 1'))
    view(handles.axes3,2);
elseif (strcmp(sel,'2D - 2'))
    view(handles.axes3,90,0);
elseif (strcmp(sel,'3D'))
    view(handles.axes3,-37.5,30);
end

function popupmenu5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")
   set(hObject,'String','15')
end

function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu6_Callback(hObject, eventdata, handles)
celSel = cellstr(get(handles.popupmenu6,'String'));
sel = celSel(get(handles.popupmenu6,'Value'));
if(strcmp(sel,'hot'))
    colormap(handles.axes2,hot);
elseif (strcmp(sel,'parula'))
    colormap(handles.axes2,parula);
elseif (strcmp(sel,'turbo'))
    colormap(handles.axes2,turbo);
elseif (strcmp(sel,'hsv'))
    colormap(handles.axes2,hsv);
elseif (strcmp(sel,'cool'))
    colormap(handles.axes2,cool);
elseif (strcmp(sel,'spring'))
    colormap(handles.axes2,spring);
elseif (strcmp(sel,'summer'))
    colormap(handles.axes2,summer);
elseif (strcmp(sel,'autumn'))
    colormap(handles.axes2,autumn);
elseif (strcmp(sel,'winter'))
    colormap(handles.axes2,winter);
elseif (strcmp(sel,'gray'))
    colormap(handles.axes2,gray);
elseif (strcmp(sel,'bone'))
    colormap(handles.axes2,bone);
elseif (strcmp(sel,'copper'))
    colormap(handles.axes2,copper);
elseif (strcmp(sel,'pink'))
    colormap(handles.axes2,pink);
elseif (strcmp(sel,'jet'))
    colormap(handles.axes2,jet);
end

function popupmenu6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu7_Callback(hObject, eventdata, handles)
celSel = cellstr(get(handles.popupmenu7,'String'));
sel = celSel(get(handles.popupmenu7,'Value'));
if(strcmp(sel,'2D - 1'))
    view(handles.axes2,2);
elseif (strcmp(sel,'2D - 2'))
    view(handles.axes2,90,0);
elseif (strcmp(sel,'3D'))
    view(handles.axes2,-37.5,30);
end

function popupmenu7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton7_Callback(hObject, eventdata, handles)
global ampActual parAmp
minAmp = min(min(ampActual));
maximo = str2double(get(handles.edit9,'String'));
parametros = zeros(1,6);
for i=1:1:6
    if i==6
        parametros(1,i) = maximo;        
    else
        parametros(1,i) = parAmp(1,i);
    end
end

str1 = "The maximum limit of the amplitude must be greater than ";
str2 = num2str(round(minAmp,1));
str = strcat(str1,str2);

if minAmp<maximo
    axis(handles.axes3,parametros);
else
    msgbox(str,"Error","error");
end
