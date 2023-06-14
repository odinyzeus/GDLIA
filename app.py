from PySide6.QtCore import QSize , Qt
from PySide6.QtWidgets import *
from PySide6.QtGui import QAction, QIcon
from pathlib import Path

from LIA import LIA as L

# Only needed for access to command line arguments
import sys

def absPath(file):
    return str(Path(__file__).parent.absolute() / file)

def actionCreate(self, Text = "&Botón", Icon = "exit.png", ShortCut = "Ctrl+O",StatusTip = "Información de barra"):
    accion_info = QAction(Text,self)
    accion_info.setIcon(QIcon(absPath(Icon)))
    accion_info.setShortcut(ShortCut)
    accion_info.setStatusTip(StatusTip)
    return accion_info

# Define the main window class
class MainWindow(QMainWindow):
    __LIA = None

    def __init__(self):
        super().__init__()
        # construimos el menú
        self.mnu_build()
        self.setWindowTitle("Graphic Digital Lock In Amplifier")
        self.setFixedSize(QSize(480, 320)) # Set the size of main window

    def mnu_build(self):
        # Recuperamos la barra de menú
        menu = self.menuBar()

        # Añadimos un menú de archivo
        file_mnu = menu.addMenu("&File")
        ac = actionCreate(self,"&OpenVideo","open-video.png",ShortCut="Ctrl+O",StatusTip="Inicia el proceso de apertura del video")
        ac.triggered.connect(self.openvideo)
        file_mnu.addAction(ac)
    
        # Añadimos un separador
        file_mnu.addSeparator()
        # Añadimos una acción completa
        file_mnu.addAction(QIcon(absPath("exit.png")), "S&alir", self.close, "Ctrl+Q")

        # Añadimos un menú de ayuda
        menu_ayuda = menu.addMenu("Ay&uda")
        ac = actionCreate(self,"&Información","info.png",ShortCut="Ctrl+I",StatusTip="Muestra información irrelevante")
        ac.triggered.connect(self.mostrar_info)
        menu_ayuda.addAction(ac)

        # Añadimos una barra de estado
        self.setStatusBar(QStatusBar(self))

    def mostrar_info(self):
        dialogo = QMessageBox.information(
            self, "Diálogo informativo", "Esto es un texto informativo")

    def openvideo(self):
        dialogo = QMessageBox.information(
            self, "Diálogo informativo", "desde aqui se carga el archivo de video")

# You need one (and only one) QApplication instance per application.
# Pass in sys.argv to allow command line arguments for your app.
# If you know you won't use command line arguments QApplication([]) works too.
app = QApplication(sys.argv)

# Create a Qt widget, which will be our window.
window = MainWindow()
window.show()  # IMPORTANT!!!!! Windows are hidden by default.

# Start the event loop.
app.exec_()

# Your application won't reach here until you exit and the event
# loop has stopped.