# [Levanta la mano ~ Standalone (votainteligente)](https://github.com/ciudadanointeligente/votainteligente-portal-electoral) en Docker

## Atención
**Tanto el directorio app-code como sus subdirectorios tienen permisos de escritura, lectura y ejecución (777) mientras que los ficheros tienen permisos de escritura y lectura**

Esto se debe a que este compose es para un entorno de desarrollo.

### VotaInteligente -> Levanta la mano
Este repositorio contiene un deploy con [docker-compose](https://docs.docker.com/compose/) de [VotaInteligente](https://github.com/ciudadanointeligente/votainteligente-portal-electoral) a modo de entorno de desarrollo local utilizando "Levanta la mano" como aplicación específica.
Esto es casi un clon del deploy de VotaInteligente que hice anteriormente que se encuentra [aquí](https://github.com/mxdlx/votainteligente-docker), esta versión es específica y orientada a desarrolladores.

### Pasos a seguir
1. Lo primero es clonar este repositorio.

   `$ git clone https://github.com/mxdlx/mxdlx/levantalamano-docker`

2. Luego cambiar al directorio de trabajo y levantar el compose.

   `$ cd levantalamano-docker && sudo docker-compose up -d`
3. El código de [VotaInteligente](https://github.com/ciudadanointeligente/votainteligente-portal-electoral) se encontrará dentro del directorio `app-code` una vez finalizado el `docker-compose up`. Es decir, la estructura será de la siguiente forma:

```
$ tree -L 1 .
.
├── app-code
├── app-container
├── nginx
├── docker-compose.yml
└── README.md
```

### Rutas disponibles

El `docker-compose` está configurado para que la aplicación escuche en el host en `http://127.0.0.1:8000`. De esta forma hay dos rutas principales:

* `http://127.0.0.1:8000/`: la aplicación en si.
* `http://127.0.0.1:8000/admin`: panel de administración.

#### Panel de administración
En app-container/example-data.yaml se define un usuario administrador para la aplicación:

* Usuario: admin
* Password: admin
