# ncast
A headless OBS environment in a container. The app ise exposed via a web frontend for use via XPRA. This allows
for a completely web delivered OBS with full GPU acceleration.

Currently this is only tested on NVIDIA products and configured to use nvenc.

### Building
```
. .INFO
docker build \
  --build-arg CUDA_VERSION=${CUDA_VERSION} \
  --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
  --build-arg VIRTUALGL_VERSION=${VIRTUALGL_VERSION} \
  -t "ncast:cuda${CUDA_VERSION}-ubuntu${UBUNTU_VERSION}" \
  .
```

### Usage
Please see the included manifests included for Helm and Kubernetes to see how to deploy this container effectively!
You can find them in the "templates" folder.

### Pull existing pre-built container
We use GitHub's repository for management at this time.

https://github.com/eb3095/ncast/pkgs/container/ncast

### Screenshots
TODO

### Configuration
All configuration for obs can be found in /data/obs. If no data is present a default set will be copied over
to ensure a base level of functionality.

### Credits
For now we support open source contributors and use only projects with open licenses. If you are going to
support this project, considering throwing one of the listed people a hand as well!

#### Developers
* Eric Benner (eb3095)

#### Art
Hey, not artists here. Want to engage but not technical? Heres a chance! We could use custom art work.

* \[Background.png\] darkdissolution - https://www.deviantart.com/darkdissolution/art/Abstract-Wallpaper-Free-to-Use-96-938676956
