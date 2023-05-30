import cv2
import numpy as np

flag=1

# Seleccionar la fuente de video (cámara térmica)
cap = cv2.VideoCapture(0) 

# Obtener las dimensiones en pixeles de la imagen térmica
width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

# Definir el codec y el archivo de salida
fourcc = cv2.VideoWriter_fourcc(*'XVID')
out = cv2.VideoWriter('thermal.avi', fourcc, 20.0, (width,height))


# Verificar si la cámara térmica está abierta
if not cap.isOpened():
    print("No se puede abrir la camara termica")
    exit()

# Bucle para leer y mostrar el video de la cámara térmica
while True:
    # Leer el siguiente cuadro del video
    ret, frame = cap.read()

    # Verificar si se ha leído correctamente el cuadro
    if not ret:
        print("No se puede recibir cuadro. Saliendo ...")
        break

    # Mostrar el cuadro en una ventana
    cv2.imshow('Camara termica', frame)
    
    # Esperar a que se pulse la tecla 'q' para salir del bucle e iniciar la grabacion
    if cv2.waitKey(1) == ord('q'):        
        break

# bucle para iniciar la grabacion del video
while True:
    # Leer el siguiente cuadro del video
    ret, frame = cap.read()

    # Verificar si se ha leído correctamente el cuadro
    if not ret:
        print("No se puede recibir cuadro. Saliendo ...")
        break

    cv2.imshow('Camara termica', frame)
    
    # Escribir el frame en el archivo de salida
    if flag==1:
        print("GRABRANDO VIDEO ...")
        flag=0
    
    out.write(frame)
    # Esperar a que se pulse la tecla 'q' para salir del bucle de grabacion
    if cv2.waitKey(1) == ord('q'):        
        break

# Liberar la cámara térmica y cerrar la ventana
cap.release()
cv2.destroyAllWindows()
flag=1
print("Termino de ejecutar bien")
