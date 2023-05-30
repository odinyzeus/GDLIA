import cv2
import numpy as np
from pymba import Vimba
from pymba import Frame

with Vimba() as vimba:
    # Listar todas las cámaras conectadas
    camera_ids = vimba.getCameraIds()

    if not camera_ids:
        raise ValueError("No se encontraron cámaras")

    # Seleccionar la primera cámara disponible
    camera_id = camera_ids[0]

    # Conectar con la cámara
    with vimba.getCamera(camera_id) as camera:
        # Establecer los parámetros de adquisición
        camera.feature('ExposureTime').value = 1000 #Tiempo de exposición en microsegundos
        camera.feature('AcquisitionFrameRateAbs').value = 30.0 #Frecuencia de fotogramas en fps

        # Iniciar la transmisión de video
        camera.arm('Continuous', acquire_timeout_ms=2000)

        # Capturar y mostrar el video en tiempo real
        while True:
            try:
                # Capturar un cuadro de la cámara
                frame = camera.getFrame(timeout=2000)
                image_data = frame.buffer_data_numpy()

                # Convertir los datos de imagen a una matriz de NumPy
                image = np.ndarray(buffer=image_data,
                                   dtype=np.uint8,
                                   shape=(frame.height, frame.width))

                # Mostrar el cuadro en una ventana
                cv2.imshow('Cámara térmica', image)

                # Esperar a que se pulse la tecla 'q' para salir del bucle
                if cv2.waitKey(1) == ord('q'):
                    break

            except Exception as e:
                print("Error al obtener cuadro:", str(e))
                continue

        # Detener la transmisión de video
        camera.disarm()
        cv2.destroyAllWindows()
