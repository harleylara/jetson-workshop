# NVIDIA Jetson - Workshop HSRW

WIP...

## Setup Docker Container

```
docker build -t ai-applications .
```

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

