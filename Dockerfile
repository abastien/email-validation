FROM php:8.3-cli

ARG GROUP_ID
ARG GROUP_NAME
ARG USER_ID
ARG USER_NAME
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

RUN addgroup --gid $GROUP_ID $GROUP_NAME
RUN adduser --uid $USER_ID --gid $GROUP_ID $USER_NAME
RUN echo "PS1='\e[92m\u\e[0m@\e[94m\h\e[0m:\e[35m\w\e[0m# '" >> /home/$USER_NAME/.bashrc

RUN apt update && apt install sudo unzip git -y
RUN sudo -u $USER_NAME git config --global user.email $GIT_USER_EMAIL
RUN sudo -u $USER_NAME git config --global user.name $GIT_USER_NAME

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --2.7 --install-dir=/usr/local/bin --filename=composer
RUN rm composer-setup.php
