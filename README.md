# Cloud One Application Security with dotNET Core

- [Cloud One Application Security with dotNET Core](#cloud-one-application-security-with-dotnet-core)
  - [Usage](#usage)
  - [Support](#support)
  - [Contribute](#contribute)

This demo app for Cloud One Application Security uses a simple dotNET demo app based on @Microsoft <https://github.com/dotnet/dotnet-docker/tree/main/samples/aspnetapp>.

Application Security integration done via the provided Dockerfile

## Usage

First, clone the repo

Then build and run the container

```sh
# Build the image with dotNET 3.1
docker build --pull -t aspnetapp -f Dockerfile.3.1 .

# Build the image with dotNET 5.0
docker build --pull -t aspnetapp -f Dockerfile.5.0 .

# Build the image with dotNET 6.0
docker build --pull -t aspnetapp -f Dockerfile.6.0 .

# Run the container
docker run --rm -it -p 8888:80 --name aspnetapp aspnetapp
```

The upload app is accessible on port 8000.

Finally, run a shellshock for example.

```sh
curl -H "User-Agent: () { :; }; /bin/eject" http://localhost:8888
```

## Support

This is an Open Source community project. Project contributors may be able to help, depending on their time and availability. Please be specific about what you're trying to do, your system, and steps to reproduce the problem.

For bug reports or feature requests, please [open an issue](../../issues). You are welcome to [contribute](#contribute).

Official support from Trend Micro is not available. Individual contributors may be Trend Micro employees, but are not official support.

## Contribute

I do accept contributions from the community. To submit changes:

1. Fork this repository.
1. Create a new feature branch.
1. Make your changes.
1. Submit a pull request with an explanation of your changes or additions.

I will review and work with you to release the code.
