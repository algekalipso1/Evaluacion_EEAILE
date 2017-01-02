import nltk
from readability.readability import Readability

# Constants
bucket_size = 100

# Compute Disperssion
# n = number of divisions
# m = mean of the frequencies over n divisions
# sd = standard deviation of the frequencies
# v = sd / m
# r = square root of n
# dispession = 1 - (v/r)

# file_opened = open("gen2/mod1_pro/mod1_pro_02_santiagog_mdrlp.txt", 'r')
# example_text = file_opened.read()
# example_text = "".join(i for i in example_text if ord(i) < 128)

# This computes the total number of words, number of different words, and average length of words (later on add rarity of words, too)


def get_word_features(full_string):
    total_number_of_words = 0
    total_length_of_words = 0
    word_set = set()
    temporary_word_set = set()
    index_in_bucket = 0
    different_words_in_buckets = []
    tokenized_string = nltk.word_tokenize(full_string)
    for word in tokenized_string:
        word = word.lower()
        if word.isalpha():
            total_number_of_words += 1
            total_length_of_words += len(word)
            word_set.add(word)
            temporary_word_set.add(word)
        if index_in_bucket % bucket_size == bucket_size - 1:
            different_words_in_buckets.append(len(temporary_word_set))
            temporary_word_set = set()
        index_in_bucket += 1
    mean_in_bucket = sum(different_words_in_buckets) / float(len(different_words_in_buckets))
    average_length_of_words = total_length_of_words / float(total_number_of_words)
    #print "words per bucket", sum(different_words_in_buckets), float(len(different_words_in_buckets)), mean_in_bucket
    return {'word_count': total_number_of_words, 'mean_word_length': average_length_of_words, 'different_words': len(word_set), 'mean_different_words_per_bucket': mean_in_bucket}

# Valid sentences are defined as sentences with at least 5 'alpha' tokens (no punctuation, numbers or other symbols).


def get_sentence_features(full_string):
    total_number_of_valid_sentences = 0
    total_words_in_sentences = 0
    sentences = nltk.sent_tokenize(full_string)
    for sentence in sentences:
        words_in_sentence = nltk.word_tokenize(sentence)
        alpha_tokens_in_sentence = 0
        for word in words_in_sentence:
            if word.isalpha():
                alpha_tokens_in_sentence += 1
        if alpha_tokens_in_sentence > 4:
            total_number_of_valid_sentences += 1
            total_words_in_sentences += alpha_tokens_in_sentence
    return {'valid_sentences_count': total_number_of_valid_sentences, 'mean_words_per_sentence': total_words_in_sentences / float(total_number_of_valid_sentences)}


# Get Flesch-Kincaid score and others.
# .39*total_words/total_sentences + 11.8*total_syllables/total_words - 15.59
def get_readability_scores(full_string):
    rd = Readability(full_string)
    reading_dict = {'ARI': rd.ARI()}
    reading_dict['FleschReadingEase'] = rd.FleschReadingEase()
    reading_dict['FleschKincaidGradeLevel'] = rd.FleschKincaidGradeLevel()
    reading_dict['GunningFogIndex'] = rd.GunningFogIndex()
    reading_dict['SMOGIndex'] = rd.SMOGIndex()
    reading_dict['ColemanLiauIndex'] = rd.ColemanLiauIndex()
    reading_dict['LIX'] = rd.LIX()
    reading_dict['RIX'] = rd.RIX()
    return reading_dict



# Features we care about (to start)
# 1 - total number of words
# 2 - number of sentences above a certain length (say, 3 words)
# 3 - number of paragraphs
# 4 - total number of different words
# 5 - average length of words
