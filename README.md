# Groovy Docker Example

This is a fixed version of https://oneuptime.com/blog/post/2026-02-08-how-to-containerize-a-groovy-application-with-docker/view .

The writer made a very good example of how to run Groovy as a microservice with docker, but it had some bugs.

* It needed some small tweaks to build.gradle to compile due to some missing files. 
* settings.gradle or gradle.properties was not provided for some reason.
* It needed to be updated to jdk26, which required updating other dependency versions like [gradleUp/shadow.](https://github.com/GradleUp/shadow/issues/908)
* Switched to RHEL ubi for gradle instead of Ubuntu as it doubles as minimal image

## Build

To build, run the following command, or substitute docker with podman.

```
docker build -t yourgroovydockertag
```

## Usage

To expose on port 8080 and use -it to display logs, run the following command.

```bash
docker run -p 8080:8080 -it yourgroovydockertag
```

Then you can curl the following API endpoints.

```bash
$ curl http://localhost:8080/
Hello from Groovy in Docker!

$ curl http://localhost:8080/compute/16
{"limit":16,"primeCount":4,"largestPrime":13}
```

Ctrl-C to stop the server.
