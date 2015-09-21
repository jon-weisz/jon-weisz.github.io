---
layout: post
title: "Tacklebox: Bring your hardware into your container."
excerpt: "An attempt at making the common use case easy, and the uncommon possible"
tags: [Docker, Robobench, Tacklebox]
comments: false
image:
  feature: docker_gears.png
---

#Introduction
Pack your hardware with you when running containerized applications. 

This is a command line tool and library to automatically introspect the host machine and modify the docker command to use the hosts GPU hardware without modifying the container itself. 

This is meant to ease development of GPU intensive code - i.e. Augmented Reality or Deep Learning projects.

#Motivation
The standard approach to getting GPU related hardware to work inside of a container is to modify the standard toolchain with a build command that does something like

0. Build a base container with an application.
1. Figure out which driver the host uses
2. Download the driver from some remote URL
3. Add the driver installer to a DockerFile build script
4. Add X11 server to the Build Container
5. Build new container based on original application


Then to run the container, there is some bash script that wraps the docker run command to pass in only the drivers.

See https://github.com/thewtex/docker-opengl-nvidia.git for an example of this approach.


This approach is not particularly scalable, not robust, and requires a lengthy and complex build process for each user of the application. There are three main issues.
1. Different flags are needed for different host configurations
2. A mismatch between the host and client X server can cause graphical corruption.
3. Modifying the container is very slow, inhibitting development of the underlying application.



Our approach skips the modification of the original containerized application in favor of simply linking in the libraries directly from the host. This involves three capabilities


1. Host introspection to determine the correct devices nodes and libraries to pass in to the container.
2. Tests that assure that the host is configured correctly for the necessary libraries.
3. Demos that allow a human to verify the capabilities engendered by these libraries.

The most similar project to this is [Subuser](http://subuser.org/), which attempts to wrap applications. However, it doesn't incorporate automatic discovery of all of the correct configuration variables, specifically the vendor specific device nodes and libraries.





Support is planned initially for CUDA, OpenCL, and audio applications.