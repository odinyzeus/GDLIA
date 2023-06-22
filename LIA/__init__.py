import os
import sys

class LIA(object):
    __Metodo  = 1
    __status  =  'Inicializando'
    def __init__(self,**kw):
        __status = f'Inicializando Lock In'

    def __str__(self) -> str:
        return __status

class Video(object):
    __status = ''

    def __init__(self,**kw):
        __status = f'Inicializando el proceso de video'
        pass

    def __str__(self) -> str:
        return __status 