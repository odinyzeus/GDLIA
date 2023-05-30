import cv2

# Seleccionar la fuente de video (cámara térmica)
cap = cv2.VideoCapture(0) 

# Verificar si la cámara térmica está abierta
if not cap.isOpened():
    print("No se puede abrir la camara termica")
    exit()

# Bucle para leer y mostrar el video de la cámara térmica
while True:
    # Leer el siguiente cuadro del videoqqqqqq
    ret, frame = cap.read()

    # Verificar si se ha leído correctamente el cuadro
    if not ret:
        print("No se puede recibir cuadro. Saliendo ...")
        break

    # Mostrar el cuadro en una ventana
    cv2.imshow('Camara termica', frame)

    # Esperar a que se pulse la tecla 'q' para salir del bucle
    if cv2.waitKey(1) == ord('q'):
        break

# Liberar la cámara térmica y cerrar la ventana
cap.release()
cv2.destroyAllWindows()
print("Termino de ejecutar bien")
