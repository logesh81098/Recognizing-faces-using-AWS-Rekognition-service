FROM python:3.12.3-alpine3.18

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 81

CMD [ "python", "app.py" ]