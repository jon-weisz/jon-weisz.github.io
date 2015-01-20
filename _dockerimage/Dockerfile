From grahamc/jekyll
MAINTAINER jon.weisz@gmail.com	

RUN apt-get update && apt-get install bundler -y

#ENV USERNAME webadmin
#ENV HOME /home/$USERNAME
#RUN mkdir -p $HOME
#RUN useradd $USERNAME
#RUN echo "$USERNAME:$USERNAME" | chpasswd
#RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
#RUN chown -R $USERNAME:$USERNAME $HOME

RUN apt-get update
RUN apt-get install -y curl git build-essential ruby1.9.1 libsqlite3-dev
RUN gem install rubygems-update --no-ri --no-rdoc
RUN update_rubygems
RUN gem install bundler --no-ri --no-rdoc

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock 
RUN bundle install
 
WORKDIR /src 

VOLUME /src
#RUN chown webadmin /src

#USER webadmin

#WORKDIR /src

CMD bundle install && bundle exec jekyll serve --port 4000 --host 0.0.0.0
