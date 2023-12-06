# Praat-synthetic-speech
This script can create synthetic speech based on a list of sentences in a .txt file
and then save the generated speech and TextGrid files in a directory.
You can select whether you want the American or British accent.

Things required: a .txt file with sentences, and an output directory.

The .txt can include SSML (speech synthesis markup language) markers;
The default settings for output pitch range in this script are '44100, 0.01, 1, 0, 175, "IPA"';
Such settings generate real robotic-like speech as pitch range is strictly controlled;
Deleting this line will allow back to Praat default pitch range setting.
