#!/bin/bash
docker run -ti -p 4000:4000 -v $PWD:/src jonweisz/jekyll-bundler:onbuild-test
