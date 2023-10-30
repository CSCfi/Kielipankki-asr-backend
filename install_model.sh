#!/usr/bin/bash

ORIG_DIR=$(pwd)

AM_URL="https://zenodo.org/records/7101543/files/am_lp_1600h.zip"
EXTRACTOR_URL="https://zenodo.org/records/7101543/files/extractor.zip"
GRAPH_MORFESSOR_LP_DSP_URL="https://zenodo.org/records/7101543/files/graph_morfessor_lp_web_dsp.zip"
GRAPH_WORD_DSP_URL="https://zenodo.org/records/7101543/files/graph_word_lp_web_dsp.zip"

if [[ -e kaldi-serve/model-fi ]]
then
    echo "model-fi already present in kaldi-serve/, exiting"
    exit 1
fi

TMP_DIR=$(mktemp --directory)
cd $TMP_DIR

packages=($AM_URL $EXTRACTOR_URL $GRAPH_WORD_DSP_URL)
for package in "${packages[@]}"; do
    echo "Fetching $(basename $package) from Zenodo"
    echo "***"
    echo
    wget $package
    if [ $? -ne 0 ]; then
	echo "Failed to fetch model zip, wget returned error code $?"
	exit 1
    fi
    mkdir $(basename -s .zip $package)
    echo
    echo "***"
    echo "Extracting"
    unzip -q -d $(basename -s .zip $package) $(basename $package)
done


echo "Installing model to kaldi-serve/model-fi and model-spec.toml to kaldi-serve/..."

mkdir model-fi model-fi/ivector_extractor
mv am_lp_1600h/exp/swbd/chain/tdnn7q_sp/* model-fi
mv extractor/exp/nnet3/extractor/* model-fi/ivector_extractor
mv graph_word_lp_web_dsp/exp/swbd/chain/tdnn7q_sp/graph_word_lp_web_dsp_nosp/* model-fi

mv model-fi $ORIG_DIR/kaldi-serve/model-fi
cd $ORIG_DIR
cp -r config/conf kaldi-serve/model-fi/
cp config/model-spec.toml kaldi-serve/

echo "Cleaning up"
rm -rf $TMP_DIR
echo "Done."
