from PySide6.QtCore import QSize , Qt
from PySide6.QtWidgets import *


from LIA import *

# Only needed for access to command line arguments
import sys

# Define the main window class
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Graphic Digital Lock In Amplifier")

        button = QPushButton("Press Me!")

        self.setFixedSize(QSize(400, 300)) # Set the size of main window

        self.setCentralWidget(button) # Set the central widget of the Window.

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