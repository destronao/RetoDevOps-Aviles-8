# Eólica Naranco S.L. - Sistema de gestión

App Node.js del sistema de gestión del parque eólico de la sierra del Aramo.

## Arrancar en local

```bash
node app.js
```

Accede en http://localhost:8080

## Estructura

- `app.js` — servidor principal


## Persistencia de datos con volúmenes

Se ha comprobado que, al ejecutar el contenedor sin volumen, los datos almacenados en `/data` (como el contador de visitas) se pierden al reiniciar el contenedor, ya que los contenedores son efímeros.

Para solucionar esto, se ha creado un volumen Docker llamado `datos-eolica` y se ha montado en la ruta `/data` del contenedor.

De esta forma, los datos se almacenan fuera del contenedor y se mantienen incluso después de reiniciarlo.

### Comandos utilizados

```bash
docker volume create datos-eolica

##  Logs y ejecución en background

El contenedor se ha ejecutado en modo background (`-d`), lo que permite que la aplicación funcione sin bloquear la terminal.

Tras realizar varias peticiones a las rutas `/`, `/aerogeneradores` y `/salud`, se han analizado los logs del contenedor para comprobar su comportamiento.

### Comandos utilizados

Ver todos los logs:

```bash
docker logs eolica-naranco

## Límites de recursos del contenedor

En producción no es recomendable permitir que un contenedor consuma todos los recursos del servidor. Si una aplicación tiene un error, una fuga de memoria o una carga inesperada, podría afectar al resto de servicios.

Para evitarlo, se han probado límites de memoria y CPU en el contenedor de la aplicación.

### Ejecución con límites de recursos

```bash
docker run -d \
  --env-file .env \
  -v datos-eolica:/data \
  --memory='128m' \
  --cpus='0.5' \
  --name eolica-naranco \
  -p 8080:8080 \
  eolica-naranco