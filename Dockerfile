FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

# We copy just the requirements.txt first to leverage Docker cache
COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

# keys for Cognitive services
ENV APPSETTING_TRANSLATE_KEY=first
ENV APPSETTING_SPEECH_KEY=second
ENV APPSETTING_SENTIMENT_KEY=third

# regional URLs
ENV APPSETTING_TRANSLATE_URI=https://api-eur.cognitive.microsofttranslator.com
ENV APPSETTING_TRANSLATE_REGION=westeurope
ENV APPSETTING_SPEECH_URI=https://westeurope.api.cognitive.microsoft.com
ENV APPSETTING_SENTIMENT_URI=https://westeurope.api.cognitive.microsoft.com

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]
