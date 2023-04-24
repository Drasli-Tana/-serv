FROM python:3.10-alpine
ENV NATS_HOST '10.1.33.57'
COPY src /
RUN ls /
RUN pip install -r requirements.txt
ENTRYPOINT [ "ls ", "/"]
#ENTRYPOINT "python -u app_web.py"