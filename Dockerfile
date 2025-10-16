FROM public.ecr.aws/deep-learning-containers/tensorflow-training:2.18.0-cpu-py310-ubuntu22.04-ec2-v1.39

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -U \
    flask \
    gevent \
    gunicorn \
    pandas \
    numpy \
    scikit-learn

RUN mkdir -p /opt/program
RUN mkdir -p /opt/ml

COPY app.py /opt/program
COPY model.py /opt/program
COPY nginx.conf /opt/program
COPY wsgi.py /opt/program
WORKDIR /opt/program

EXPOSE 8080

ENTRYPOINT ["python", "app.py"]