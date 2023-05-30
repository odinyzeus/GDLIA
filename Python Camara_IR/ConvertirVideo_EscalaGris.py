import cv2
import numpy as np
import scipy.io as sio

# Abre el archivo de video
cap = cv2.VideoCapture('thermal.avi')
# Obtiene la cantidad de fotogramas del video
frames_totales = int(cap.get(cv2.CAP_PROP_FRAME_COUNT)) #profundidad
width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))  #columnas
height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)) #filas

i=0
arreglo_gris=np.zeros((frames_totales,height,width))

# Verifica si el video se abrió correctamente
if not cap.isOpened():
    print("Error al abrir el video")

# Recorre cada frame del video
while True:
    # Lee un frame del video
    ret, frame = cap.read()

    # Si no hay más frames, sal del loop
    if not ret:
        break

    # Convierte el frame a escala de grises
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # Convertir la imagen a un arreglo de datos
    data1 = np.array(gray)

    #crear un arreglo 3D
    arreglo_gris[i,:,:]=data1
    #print(arreglo_gris[i])
    #print(frames_totales)
    i=i+1
    # Muestra el frame en una ventana
    cv2.imshow('Escala de Grises', gray)

    # Espera 1 milisegundo para la siguiente iteración
    if cv2.waitKey(1) == ord('q'):
        break

dimdata1=data1.shape
dimarreglo_gris=arreglo_gris.shape
np.savetxt('Datos_en_gris1frame.csv', data1, delimiter=',', fmt='%.2f')
#np.savetxt('Datos_en_gris.csv', arreglo_gris.flatten(), delimiter=',', fmt='%.2f')

#guarda los datos en formato .mat para manipular en matlab
sio.savemat('Datos_en_gris.mat', {'Datos_en_gris': arreglo_gris})

#print(type(data1))
#print(type(arreglo_gris))

print(dimdata1)
print(dimarreglo_gris)



# Cierra la ventana y libera los recursos
cap.release()
cv2.destroyAllWindows()