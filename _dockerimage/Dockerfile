From grahamc/jekyll
MAINTAINER jon.weisz@gmail.com	

RUN apt-get update && apt-get install bundler -y

ENV USERNAME webadmin
ENV HOME /home/$USERNAME
RUN mkdir -p $HOME
RUN useradd $USERNAME
RUN echo "$USERNAME:$USERNAME" | chpasswd
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN chown -R $USERNAME:$USERNAME $HOME

VOLUME /src

RUN chown webadmin /src

USER webadmin

WORKDIR /src

CMD bundle install && bundle exec jekyll serve --port 4000
