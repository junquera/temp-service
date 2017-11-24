# Temp watcher service

Servicio de log de la temperatura media del equipo. Cualquier otro que encuentres será mucho mejor, pero he hecho este para aprender a crear servicios y entender mejor la estructura y el funcionamiento que tienen que tener.

## Instalación

Tiene cuatro *dependencias*:

- temp.program

- temp.rotate

- temp.service

- temp.systemd

Si quisiésemos instalar otro servicio, tendríamos que crear cuatro archivos iguales reemplazando el nombre *temp* por el nombre del programa que queramos y el archivo `temp.program` por el ejecutable del servicio; y editar el archivo `configure.sh` con el nombre del nuevo servicio.

Para configurar el `Makefile`:

```
./configure.sh
```

En función del argumento `SYSD` el servicio se instalará como un servicio  tipo `init.d` (`SYSD=0`) o como un servicio `systemd` (`SYSD=1`).

> He usado este archivo para probar a crear un programa previo al Makefile

Después ejecutaremos:

```
make
make install
```

## LogRotation

Documentación de `log-rotation`: https://www.digitalocean.com/community/tutorials/how-to-manage-log-files-with-logrotate-on-ubuntu-12-10
