FROM python:3.7-alpine

RUN addgroup user && adduser -h /home/user -D user -G user -s /bin/sh

COPY . /usr/src/app/lennonwall

WORKDIR /usr/src/app/lennonwall

RUN apk update \
	&& apk add --no-cache git openssh-client \
    && pip install pipenv \
    && apk add gcc libc-dev linux-headers \
    && pip install --upgrade pip \
    && pip install -r requirements.txt

EXPOSE 8080
CMD ["/usr/local/bin/uwsgi", "--ini", "server.ini"]
