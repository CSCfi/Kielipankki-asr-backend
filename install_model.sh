#!/usr/bin/bash

MODEL_ZIP_URL="https://a3s.fi/lb-asr-models/lb-lp-baseline-kaldi-model.zip"

if [[ -e kaldi-serve/model-fi ]]
then
    echo "model-fi already present in kaldi-serve/, exiting"
    exit 1
fi

echo "Fetching model from $MODEL_ZIP_URL"
echo

curl $MODEL_ZIP_URL --output model.zip
if [ $? -ne 0 ]; then
	echo "Failed to fetch model zip, curl returned error code $?"
fi

echo "Unpacking model..."
unzip -q model.zip

echo "Installing model to kaldi-serve/model-fi and model-spec.toml to kaldi-serve/..."
mv model-spec.toml kaldi-serve/
mv model-fi/ kaldi-serve/
echo "Cleaning up..."
echo "Done."
rm model.zip
