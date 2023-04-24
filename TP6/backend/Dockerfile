FROM python:3.10-alpine
ENV DB_HOST=10.1.33.57
ENV DB_NAME=tp6
ENV DB_USER=tp6
ENV DB_PASSWORD=tp6
COPY src /
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "-u", "backend.py"]