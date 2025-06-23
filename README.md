# xlwings Lite (self-hosted)

[xlwings-lite](https://hub.docker.com/r/xlwings/xlwings-lite) is a Docker image that includes [all the packages](https://pyodide.org/en/stable/usage/packages-in-pyodide.html) that come with the Pyodide distribution and has installation of Python packages via PyPI blocked.

To add additional packages, build your own Docker image based on the xlwings-lite base image:

1. Add your Python wheels to the `packages` folder. Note that the wheels need to be either pure Python wheels (e.g., `mypackage-0.0.0-py3-none-any.whl`) or otherwise need to be [built for Pyodide](https://pyodide.org/en/stable/usage/building-and-testing-packages.html#building-and-testing-packages-out-of-tree).
2. Build your Docker file like so (adjust `XLWINGS_LITE_VERSION` and `-t` as desired):

   ```bash
   docker build --build-arg XLWINGS_LITE_VERSION=1.0.0.0-17 -t xlwings-lite-custom:1.0.0.0-17 .
   ```

3. For a quick test, you can spin up your container locally and go to http://localhost:8000, but bear in mind that Excel requires TLS certificates, so you won't be able to load this directly in Excel as an add-in (it's expected that the container hosting platform like Kubernetes, Azure Container Apps, etc. handle TLS certificates):

   ```bash
   docker run  --name xlwings-lite -e XLWINGS_LICENSE_KEY=YOUR_LICENSE_KEY -e XLWINGS_HOSTNAME=localhost:8000 -p 8000:8000 xlwings-lite-custom:1.0.0.0-17
   ```

NOTE: you don't necessarily need to clone this repo. Creating a `packages` directory together with the `Dockerfile` is all you need.