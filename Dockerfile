
# Idea taken from "Containerize your .NET Core app – the right way" by Nico Meisenzahl
# https://medium.com/01001101/containerize-your-net-core-app-the-right-way-35c267224a8d#95b3

ARG VERSION=5.0-alpine3.12

# Build in container with full SDK
FROM mcr.microsoft.com/dotnet/sdk:$VERSION AS build-env

WORKDIR /App
ADD . .

# Runtime container's base image is specified, so we can specify the dotnet
# runtime identifier as "alpine-x64"
# This makes it possible to publish everything (including the DotNet runtime)
# in one single file (well, two files total)
# Thus our output will be NetCore.Docker (executable) & NetCore.Docker.pdb
RUN dotnet publish \
  --runtime alpine-x64 \
  --self-contained true \
  /p:PublishTrimmed=true \
  /p:PublishSingleFile=true \
  -c Release \
  -o ./output

# Our runtime image based on a striped down image
FROM mcr.microsoft.com/dotnet/runtime-deps:$VERSION

# create a user and give it ownership of app's directory
RUN adduser \
  --disabled-password \
  --home /App \
  --gecos '' app \
  && chown -R app /App
  
# run container using this user, not root
USER app
WORKDIR /App
COPY --from=build-env /App/output .
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 \
  DOTNET_RUNNING_IN_CONTAINER=true

ENTRYPOINT ["./NetCore.Docker"]