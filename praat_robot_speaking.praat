###### Description ##########
# This script can create synthetic speech based on a list of sentences
# and then save the generated speech and TextGrid files in a directory
# You can select whether you want the American or British version

# Things required: a .txt file with sentences, and an output directory
# The .txt can include SSML (speech synthesis markup language) markers for further manipulations
# The settings for output pitch range are '44100, 0.01, 1, 0, 175, "IPA"', change this in the script if you need to
###### Buhan Guo 29th Nov 2023 ######


### Define input and output paths ###

form Give the working directories

comment Give the directory for the txt file containing sentences
text input_dir /Users/Desktop/praat/sentences.txt

comment Give the output directory (include final /)
text output_dir /Users/Desktop/praat/robot_sounds/

comment Choose the English accent:
	optionmenu accent 1 
		option American English
		option Great Britain English

endform


# Determine the accent for the SpeechSynthesizer
if accent = 1
    language$ = "English (America)"
	language_tag$ = "America"
else
    language$ = "English (Great Britain)"
	language_tag$ = "Great_Britain"
endif


# Read the lines from the text file
sent_files = Read Strings from raw text file: input_dir$
n_sentences = Get number of strings

# Loop through each line and generate speech
for line from 1 to n_sentences

	# Get the current line's text
	selectObject: sent_files
    currentText$ = Get string: line

    # Generate speech
	Create SpeechSynthesizer: language$, "Female1"
	Speech output settings: 44100, 0.01, 1, 0, 175, "IPA"
	To Sound: currentText$, "yes"

    # Save the sound and the TextGrid
	selectObject: "Sound English__" + language_tag$ + "__Female1"
    Save as WAV file: output_dir$ + "sentence_" + string$(line) + ".wav"
	selectObject: "TextGrid English__" + language_tag$ + "__Female1"
    Save as text file: output_dir$ + "sentence_" + string$(line) + ".TextGrid"
    

    # Clean up
	select all 
	minus Strings sentences
	synthesizerName$ = "SpeechSynthesizer English__" + language_tag$ + "__Female1"
	minusObject: synthesizerName$
	Remove


endfor

# Clean up

select all
Remove

appendInfoLine: "The robot has finished speaking!"
