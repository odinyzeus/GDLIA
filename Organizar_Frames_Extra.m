% clear all
% clc
% close all
% 
% load ACERO SIN SATURAR 01HZ FRAMES

%conveirte la imagen en formato double
video=NIQUEL_ACERO_01HZ;


%video=recording2;

tamano_m= size(video);
%obtengo la cantidad de frames
tamano_i=tamano_m(4);
j=1;
% Crear las variables consecutivas desde el frame i para borrar los
% frames negros inciales
for i = 1:tamano_i
    % Definir la matriz que se usará para llenar las variables
    
    %---convierto manualmente de RGB a GRAY y a Double
    %matriz1 = im2double(0.2989*video(:,:,1,i)+0.5870*video(:,:,2,i)+0.1140*video(:,:,3,i));        %-cap(:,:,1);
   
    
    %---convierto a double si ya esta en GRAY
    %matriz = im2double(video(:,:,1,i));
    

   

    %----Convierto  de RGB a GRAY y a Double
    matriz1 = rgb2gray(video(:,:,:,i));
    %matriz = imflatfield(matriz1,10);  % correccion de campo plano

    % combina las dos escalas cuando el cuadro es 192x384
    matriz1A = im2double(matriz1(1:192,:));

    matriz1B = matriz1(193:384,:);
    tam=size(matriz1B);
    Col1B=tam(2);
    fil1B=tam(1);

   %---- %corrige los datos de la matriz1B por saturacion. Valores menores a 100
   %se ponene en 255 que al convertir en double seran 1.-------%
    
%     for k=1:Col1B
%         for l=1:fil1B
%             if matriz1B(l,k)<=100
%             matriz1B(l,k)=255;
%             end
%         end
%     end
    %----------------------------------------------%
    
    matriz1B=im2double(matriz1B);
    matriz= matriz1A.*matriz1B;


    nombreVariable = sprintf('Frame%d', j); % Crear el nombre de la variable
    comandoEval = sprintf('%s = matriz;', nombreVariable); % Crear el comando eval
    eval(comandoEval); % Ejecutar el comando eval para crear la variable
    j=j+1;
end