# NVIDIA Jetson - Workshop HSRW

WIP...

### Set NVIDIA Container Runtime for Docker

in the file `/etc/docker/daemon.json` add `"default-runtime": "nvidia"`:

```
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },

    "default-runtime": "nvidia"
}
```

You will then want to restart the Docker service or reboot your system before proceeding.

```
$ service docker restart
```

## Build Docker Image

```
$ ./docker/build.sh
```
