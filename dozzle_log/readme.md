# Dozzle - [dozzle.dev](https://dozzle.dev/)

## Getting Dozzle

```bash
$ docker pull amir20/dozzle:latest
```

## Using Dozzle

```bash
$ docker run --name dozzle -d --volume=/var/run/docker.sock:/var/run/docker.sock -p 8888:8080 amir20/dozzle:latest
```