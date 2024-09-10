FROM rust:1-bullseye

RUN apt-get update && apt-get install -y \
	python3 \
	python3-pip \
	python3-dev \
	build-essential \
	libssl-dev \
	libffi-dev \
	python3-setuptools \
	python3-venv \
	virtualenv \
	python-is-python3 \
	&& rm -rf /var/lib/apt/lists/*

COPY Client/requirements.txt /opt/client_requirements.txt
RUN virtualenv /opt/venv && /opt/venv/bin/pip install --upgrade pip && /opt/venv/bin/pip install -r /opt/client_requirements.txt

COPY . /opt/app

WORKDIR /opt/app

ENTRYPOINT ["/opt/venv/bin/python", "Client/client.py", "--threads", "4", "--nsockets", "2", "--syzygy", "/opt/syzygy"]

