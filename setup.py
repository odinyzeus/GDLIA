from struct import pack
from setuptools import setup
setup (
    name="GDLIA",
    version="0.1",
    description="Paquete desarrollado para implementar el GDLIA",
    author="Eduardo Vargas Bernardino",
    author_email="odinyzeus@gmail.com",
    url="http://www.hektorprofe.net",
    packages=['LIA','LIA.Image','paquete.adios'],
    scripts=['app.py']
)