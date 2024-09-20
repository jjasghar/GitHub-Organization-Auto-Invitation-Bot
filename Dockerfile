FROM --platform=linux/amd64 python:3.11

# Create app directory
WORKDIR /app

# Install app dependencies
COPY requirements.txt ./

RUN pip install -r requirements.txt

# Bundle app source
COPY . /app

EXPOSE 8000
CMD [ "gunicorn","--bind", " 0.0.0.0:8000", "app:app" ]