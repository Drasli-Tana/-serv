FROM python:3.10-alpine

EXPOSE 5000
COPY ../../requirements.txt /

COPY src /
RUN pip install -r requirements.txt

ENTRYPOINT gunicorn -w 4 --bind 0.0.0.0:5000 taskmanager:app



