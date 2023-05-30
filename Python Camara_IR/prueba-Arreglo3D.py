import numpy as np

# Crea un arreglo de datos de 3 dimensiones con forma (2, 3, 4)
arr = np.array([[[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]],
                [[13, 14, 15, 16], [17, 18, 19, 20], [21, 22, 23, 24]]])

dimensiones=arr.shape
print(arr)
print(dimensiones)