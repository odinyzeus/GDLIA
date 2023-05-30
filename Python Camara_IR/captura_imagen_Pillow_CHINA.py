from PIL import Image
import numpy as np
import PyCapture2

bus = PyCapture2.BusManager()
num_camaras = bus.getNumOfCameras()

if not num_camaras:
    print("No se detectó ninguna cámara.")
    exit()

cam = PyCapture2.Camera()
cam.connect(bus.getCameraFromIndex(0))
cam.startCapture()

# Captura una imagen de la cámara térmica
imagen_raw, metadata = cam.retrieveBuffer()

# Convierte la imagen capturada a un objeto de imagen Pillow
imagen_pillow = Image.fromarray(np.uint8(imagen_raw))

# Guarda la imagen en un archivo
imagen_pillow.save("captura_thermal.png")

cam.stopCapture()
cam.disconnect()
