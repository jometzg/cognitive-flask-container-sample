# Deploy a containerised Flask app with Azure Cognitive Services onto Azure app services

With this sample, you'll build a Flask web app that uses Azure Cognitive Services to translate text, analyze sentiment, and synthesize translated text into speech. If you run into any issues, let us know by submitting and issue.

This is a containerised version of this application described [here](https://docs.microsoft.com/en-us/azure/cognitive-services/translator/tutorial-build-flask-app-translation-synthesis) and the GitHub [repository](https://github.com/MicrosoftTranslator/Text-Translation-API-V3-Flask-App-Tutorial) .

Please look at this repository for more details on the application itself.

## Prerequisites

Let's review the software and subscription keys that you'll need for this tutorial.

* [Git tools](https://git-scm.com/downloads)
* An IDE or text editor, such as [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/)  
* [Chrome](https://www.google.com/chrome/browser/) or [Firefox](https://www.mozilla.org/firefox)
* A **Translator Text** subscription key in the **West Europe** region.
* A **Text Analytics** subscription key in the **West Europe** region.
* A **Speech Services** subscription key in the **West Europe** region.
* Docker desktop https://www.docker.com/products/docker-desktop
* an Azure app service - of the Web App for Containers variety
* An Azure container respository (ACR) to store the docker image created locally

## Create an account and subscribe to resources

As previously mentioned, you're going to need three subscription keys for this tutorial. This means that you need to create a resource within your Azure account for:

* Translator Text
* Text Analytics
* Speech Services

Use [Create a Cognitive Services Account in the Azure portal](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-apis-create-account) for step-by-step instructions to create resources.

**IMPORTANT NOTE**: For this tutorial, please create your resources in the West US region. If using a different region, you'll need to adjust the base URL in each of your Python files.

## Clone the sample

This is pretty straightforward, clone this repository:

```
https://github.com/jometzg/cognitive-flask-container-sample.git
```

## Docker build

1. The Dockerfile
```
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
```

What you can see from the Dockerfile is there are three environment variables needed for the Cognitive Services keys, and another four for URLs - the last ones with sensible defaults for the Azure West Europe region.

Note the name of the environment variables are designed to work well with Azure App Service application settings.

1. Build the docker image

```
docker build -t translatorapp .
```

2. Test locally
This will require the setting of at least three of the environment variables.
```
docker run -it -e APPSETTING_TRANSLATE_KEY='keyone' \ 
-e APPSETTING_SPEECH_KEY='keytwo' \
-e APPSETTING_SENTIMENT_KEY='keythree' \
-p 5000:5000 \
translatorapp
```

3. Upload to ACR
```
az acr login myacr
docker tag translatorapp myacr.azurecr.io/translatorapp
docker push myacr.azurecr.io/translatorapp
```

4. Provision a web app for containers in Azure
Create the web app in the right region and make sure it is a Docker Container type. Then set its Docker settings to point to your docker image:

![Create web app](/create-web-app.png)

Then make sure that you configure your Cognitive services keys in Application settings:

![Application Settings](/web-app-settings.png)

The container running the flask applicatin exposes its web endpoint on port *5000*, so you set *WEBSITES_PORT* in applications settings too:

5. Navigate to the URL provided and test your app.

![The web app](/translateapp.png)

## Clean up

When you're done with the sample, don't forget to remove your subscription keys. Consider reading from environment variables.

## Next steps

* [Translator Text API reference](https://docs.microsoft.com/azure/cognitive-services/Translator/reference/v3-0-reference)
* [Text Analytics API reference](https://westus.dev.cognitive.microsoft.com/docs/services/TextAnalytics.V2.0/operations/56f30ceeeda5650db055a3c7)
* [Text-to-speech API reference](https://docs.microsoft.com/azure/cognitive-services/speech-service/rest-text-to-speech)
