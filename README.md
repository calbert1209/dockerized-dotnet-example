# dockerized-dotnet-example

## What

### Basic app

This repo contains the code to build a hello-world level console app and containerize it.
The app is based on [a tutorial in the DotNet Docs](https://docs.microsoft.com/en-us/dotnet/core/docker/build-container)

### using best practices when containerizing

The image build features

- multi-stage build to limit final image size
- final image whose container is run without root privledges

Nico Meisenzahl's helpful article on Medium.com, "[Containerize your .NET Core app – the right way](https://medium.com/01001101/containerize-your-net-core-app-the-right-way-35c267224a8d)" was the starting point.