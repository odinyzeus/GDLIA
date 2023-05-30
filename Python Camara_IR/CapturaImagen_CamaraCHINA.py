import cv2
import numpy as np

# Seleccionar la fuente de video (cámara térmica)
cap = cv2.VideoCapture(0) 

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

    # Esperar a que se pulse la tecla 'q' para salir del bucle y tomar imagen
    if cv2.waitKey(1) == ord('q'):
        # Guarda la imagen en un archivo
        cv2.imwrite("termica_RGB.jpg", frame)

        # Convertir la imagen térmica a escala de grises 8 bits
        frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        cv2.imwrite("termica_GRAY.jpg", frame_gray)
        
        # Convertir la imagen a escala de grises de 16 bits
        frame_gray16 = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        frame_gray16bit = np.uint16(frame_gray16) * 256

        # Convertir la imagen a un arreglo de datos
        data1 = np.array(frame_gray)
        data2 = np.array(frame_gray16bit)
        np.savetxt('Datos_GRAY.csv', data1, delimiter=',', fmt='%.2f')
        #np.savetxt('Datos_GRAY16bit.csv', data2, delimiter=',', fmt='%.2f')
       
        #np.savetxt('arreglo2.csv', rgb_img, delimiter=',', fmt='%.2f')
        break

# Liberar la cámara térmica y cerrar la ventana
cap.release()
cv2.destroyAllWindows()
print("Termino de ejecutar bien")
