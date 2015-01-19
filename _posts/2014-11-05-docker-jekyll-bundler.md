---
layout: post
title: "A Dockerized Jekyll Server With Bundler"
excerpt: "Test your blog updates with a local Jekyll server! It's so close to being easy..."
tags: [Docker, Jekyll, Bundler, onbuild]
comments: false
image:
  feature: robot_bundle.png
  credit: Prem Sichanugrist
  creditlink: http://robots.thoughtbot.com/parallel-gem-installing-using-bundler
---

The first Jekyll theme I found that I liked for this new blog is Minimal Mistakes theme by Michael Rose[^1]. Unfortunately, that means I need a development enviromnent that supports the dependency management system that it uses, Bundler[^2]. Because Bundler creates an isolated environment for the packages it installs, the popular Jekyll Docker image provided by Graham Christensen[^3] does not provide a compatible entrypoint. Additionally, the build command doesn't invoke the package management system when the image is created. Also, it would explicity set the hostname and port used by the Jekyll server, since different Jekyll releases have different defaults. This was a huge pain when they made the switch. 

A better Dockerfile for bundler based environments would:

1.  Provide an appropriate bundler command entrypoint
2.  Cache the downloaded dependencies with minimal modifications for each project.  
3.  Explicity set the hostname and port being used by the jekyll server inside the container.

Putting something together that accomplished these three goals smoothly took a fare bit of twiddling. Luckily by abusing the "ONBUILD" directive of the Dockefile, these goals can all be accomplished gracefully and concisely in the following Dockerfile:

	From grahamc/jekyll
	MAINTAINER jon.weisz@gmail.com	

	#Install the jekyll environment's dependencies
	RUN apt-get update && apt-get install bundler -y

	RUN apt-get update
	RUN apt-get install -y curl git build-essential ruby1.9.1 libsqlite3-dev
	RUN gem install rubygems-update --no-ri --no-rdoc
	RUN update_rubygems
	RUN gem install bundler --no-ri --no-rdoc

	#Create the mount point for the website's source
	VOLUME /src

	#Copy over the gemfile to a temporary directory and run the install command. 
	ONBUILD WORKDIR /tmp
	ONBUILD ADD Gemfile Gemfile
	ONBUILD ADD Gemfile.lock Gemfile.lock 
	ONBUILD RUN bundle install
 
	#Switch into the working directory and run the server. 
	ONBUILD WORKDIR /src
	ONBUILD ENTRYPOINT ["/bin/sh", "-c"] 
	ONBUILD CMD ["bundle exec jekyll serve --port 4000 --host 0.0.0.0"]

Because these commands are only executed when the image that is based on this one is built, this file is a little opaque. I'll explain these steps below.

# Local working copy
I don't want to include all of my editing tools in the Docker image, and I also don't want to constantly build and mount new docker images (Mainly because it resets my other network connections and causes my music streaming services to hiccup), so I need the website to be mounted on an external volume, not uploaded to the image in an ADD command. To do this, I create a mountpoint at /src and make that the final workdir. That way I can modify my files using whatever huge, dependency laden program I want (i.e. texworks or gimp), and simply hit refresh on my browser, without having huge Docker image files or constantly rebuilding. This explains the beginning VOLUME command and the ONBUILD block at the end.  

However, we also need to bring the files that annotate the dependencies into the images build context, so that the dependencies can be uploaded and cached. This is what happens in the middle ONBUILD block.  

# Caching the dependencies
The dependencies are stored in the packages Gemfile, with an associated Gemfile.lock. The Gemfile lists the dependencies, and the Gemfile.lock file stores all of the packages, with the specific versions installed. By encorporating both with onbuild commands in the Docker file, the Docker build will cache the dependencies for future builds.

# Abusing the onbuild command
This is nearly an ideal use case for the onbuild command, and the resulting "image" recipe can be used to create a single line Dockerfile that creates a nice little testing environment.  

Below is the README.md from the Docker image on github[^4] that documents the usage of this Dockerfile.

# Usage

## Build a Local Server Image

Create a Dockerfile containing the following in the base directory of your Jekyll image. It must be the same directory that contains your Gemfile and Gemfile.lock.

	From jonweisz/jekyll-bundler:onbuild

This command will download the packages specified in the Gemfile. 
	
Then create the image using the usual command, replacing image name with the name you wish to use for your blog image:
	
	docker build -t $IMAGENAME .

## Using the image

To run the image, with LOCALHOSTNAME and PORT as the localhost URI and port number to serve the website from, respectively (i.e. LOCALHOSTNAME=0.0.0.0 and PORT=4000):

	docker run -t -i -p $LOCALHOSTNAME:$PORT:4000 -v $PWD:/src $IMAGENAME

The server should now be running, and it should be possible to access it from a webbrowser pointed at http://$LOCALHOSTNAME:$PORT

## Caveats

* Omitting the "-t -i" flags will prohibit CTRL-C from terminating the server as normal. Without it, you will need to kill the ruby process externally to terminate the image. 
* Using only the "-t" flag will allow the CTRL-C flag to escape the command that launched the server, but it will not terminate the image. Attempting to run the command again will yield an error because the port in question will already be bound to the prior invocation of docker. 

[^1]: https://mmistakes.github.io/minimal-mistakes/
[^2]: http://bundler.io/
[^3]: https://github.com/grahamc/docker-jekyll
[^4]: https://github.com/jon-weisz/docker-jekyll-bundler