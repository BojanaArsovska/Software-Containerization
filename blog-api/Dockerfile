FROM python:3.8-slim-buster

RUN apt-get update && apt-get install -qq -y \
  build-essential libpq-dev libffi-dev --no-install-recommends
# postgresql-dev gcc python3-dev musl-dev &&\
# apt-get add --no-cache python3-dev openssl-dev libffi-dev gcc && pip3 install --upgrade pip

# WORKDIR /code
ENV FLASK_APP=src/app.py
ENV FLASK_RUN_HOST=0.0.0.0
COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt
RUN pip3 install pipenv
#RUN pip3 install libpq-dev python3-dev
RUN pipenv shell --fancy
RUN pipenv install

ENV FLASK_ENV=development
ENV JWT_SECRET_KEY=test123
# ENV DATABASE_URL=postgres://postgresadmin:admin123@10.164.0.4:5432/postgresdb

EXPOSE 5000
COPY . .
CMD ["python3", "run.py"]
