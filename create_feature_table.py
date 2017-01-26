import csv
from os import listdir
from os.path import isfile, join
from featurize_text import get_word_features, get_sentence_features, get_readability_scores, get_precence_of_terms

gens = ['gen2', 'gen3']
mods = ['mod1_pro', 'mod3_pro']


# crea lista de palabras clave:
key_words_file = open("palabras_clave/palabras_clave.txt", 'r')
key_words = key_words_file.read()
key_words = "".join(i for i in key_words if ord(i) < 128)
key_words = key_words.replace('-', ' ')
key_words = key_words.split(',')
key_words = [word[1:] for word in key_words]
split_key_words = [words.split(' ') for words in key_words]

# Featurize everything
all_text_features = {}
for gen in gens:
    for mod in mods:
        directory_prefix = gen + "/" + mod
        onlyfiles = [f for f in listdir(directory_prefix) if isfile(join(directory_prefix, f))]
        for filename in onlyfiles:
            if filename != '.DS_Store':
                stripped_filename = filename.split('.')[0]
                file_opened = open(directory_prefix + "/" + filename, 'r')
                example_text = file_opened.read()
                example_text = "".join(i for i in example_text if ord(i) < 128)
                text_features = {}
                text_features.update(get_word_features(example_text))
                text_features.update(get_sentence_features(example_text))
                text_features.update(get_readability_scores(example_text))
                text_features.update(get_precence_of_terms(split_key_words, key_words, example_text))
                parts_of_filename = stripped_filename.split('_')  # to get instructors
                text_features['gen'] = gen
                text_features['mod'] = mod
                text_features['student'] = parts_of_filename[3]
                text_features['instructor'] = parts_of_filename[4]
                all_text_features[stripped_filename] = text_features
                print "done: ", filename


header = ['gen', 'mod', 'student', 'instructor', 'word_count', 'mean_word_length', 'different_words',
          'valid_sentences_count', 'mean_words_per_sentence', 'mean_different_words_per_bucket', 'FleschReadingEase',
          'FleschKincaidGradeLevel', 'GunningFogIndex', 'SMOGIndex', 'ColemanLiauIndex', 'LIX', 'RIX',
          'total_term_appearance', 'total_term_appearance_normalized']

header += key_words

with open("featurized_text/text_features_with_grade_levels_and_key_terms.csv", 'w') as csvfile:
    feature_writer = csv.writer(csvfile, delimiter=',')
    feature_writer.writerow(header)
    for filename in all_text_features:
        feature_writer.writerow([all_text_features[filename][feature] for feature in header])
