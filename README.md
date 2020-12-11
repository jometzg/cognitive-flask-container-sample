# Tutorial: Build a Flask app with Azure Cognitive Services

With this sample, you'll build a Flask web app that uses Azure Cognitive Services to translate text, analyze sentiment, and synthesize translated text into speech. If you run into any issues, let us know by submitting and issue.

This is a containerised version of this application described here https://docs.microsoft.com/en-us/azure/cognitive-services/translator/tutorial-build-flask-app-translation-synthesis and whose repository is https://github.com/MicrosoftTranslator/Text-Translation-API-V3-Flask-App-Tutorial

Please look at this repository for more details on the application itself.

## Prerequisites

Let's review the software and subscription keys that you'll need for this tutorial.

* [Git tools](https://git-scm.com/downloads)
* An IDE or text editor, such as [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/)  
* [Chrome](https://www.google.com/chrome/browser/) or [Firefox](https://www.mozilla.org/firefox)
* A **Translator Text** subscription key in the **West US** region.
* A **Text Analytics** subscription key in the **West US** region.
* A **Speech Services** subscription key in the **West US** region.
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

```

1. Build the docker image

```
docker build -t translator .
```

2. Test locally
This will require the setting of at least three of the environment variables.


5. Navigate to the URL provided and test your app.

## Clean up

When you're done with the sample, don't forget to remove your subscription keys. Consider reading from environment variables.

## Next steps

* [Translator Text API reference](https://docs.microsoft.com/azure/cognitive-services/Translator/reference/v3-0-reference)
* [Text Analytics API reference](https://westus.dev.cognitive.microsoft.com/docs/services/TextAnalytics.V2.0/operations/56f30ceeeda5650db055a3c7)
* [Text-to-speech API reference](https://docs.microsoft.com/azure/cognitive-services/speech-service/rest-text-to-speech)
