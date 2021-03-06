FROM python:3.6-alpine

RUN adduser -D desafio_app

WORKDIR /home/desafio_app

COPY requirements.txt .

COPY hts.json .

COPY elastdocker/ .

#Instalar as livrarias C necessárias pra instalar todos os requerimentos corretamente
RUN apk add build-base

RUN pip install -r requirements.txt

COPY api.py ./

RUN chown -R desafio_app:desafio_app ./
USER desafio_app

#Subir a stack ELK

WORKDIR /home/elastdocker/

RUN make setup & make all

WORKDIR /home/desafio_app

CMD uvicorn api:app --host 0.0.0.0 --port 5057