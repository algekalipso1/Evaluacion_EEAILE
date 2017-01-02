library(ggplot2)

setwd("~/Documents/Person/language_improvement_analysis/featurized_text")

#d = read.csv("text_features_2.csv")
d = read.csv("text_features_with_grade_levels.csv")

d$sqrt_word_count = d$word_count^.5
d$normalized_word_proportion = d$different_words / d$sqrt_word_count

t.test(d[d$mod == 'mod1_pro',]$mean_word_length, d[d$mod == 'mod3_pro',]$mean_word_length)
t.test(d[d$mod == 'mod1_pro',]$mean_words_per_sentence, d[d$mod == 'mod3_pro',]$mean_words_per_sentence)
t.test(d[d$mod == 'mod1_pro',]$normalized_word_proportion, d[d$mod == 'mod3_pro',]$normalized_word_proportion)

qplot(sqrt_word_count, different_words, color = mod, data = d)
summary(lm(different_words ~ sqrt_word_count + word_count, data = d))


d1 = d[d$gen == 'gen2',]
d2 = d[d$gen == 'gen3',]

t.test(d1[d1$mod == 'mod1_pro',]$mean_word_length, d1[d1$mod == 'mod3_pro',]$mean_word_length)
t.test(d2[d2$mod == 'mod1_pro',]$mean_word_length, d2[d2$mod == 'mod3_pro',]$mean_word_length)

t.test(d1[d1$mod == 'mod1_pro',]$normalized_word_proportion, d1[d1$mod == 'mod3_pro',]$normalized_word_proportion)
t.test(d2[d2$mod == 'mod1_pro',]$normalized_word_proportion, d2[d2$mod == 'mod3_pro',]$normalized_word_proportion)

t.test(d1[d1$mod == 'mod1_pro',]$mean_words_per_sentence, d1[d1$mod == 'mod3_pro',]$mean_words_per_sentence)
t.test(d2[d2$mod == 'mod1_pro',]$mean_words_per_sentence, d2[d2$mod == 'mod3_pro',]$mean_words_per_sentence)

t.test(d1[d1$mod == 'mod1_pro',]$mean_different_words_per_bucket, d1[d1$mod == 'mod3_pro',]$mean_different_words_per_bucket)   
t.test(d2[d2$mod == 'mod1_pro',]$mean_different_words_per_bucket, d2[d2$mod == 'mod3_pro',]$mean_different_words_per_bucket)   




 # Intersect and conduct paired t tests

students_in_both_3 <- intersect(d2[d2$mod == 'mod1_pro',]$student, d2[d2$mod == 'mod3_pro',]$student)
#d2m1 <- d2[d2$mod=='mod1_pro',]
#d2m1s <- d2m1[d2m1$student %in%students_in_both_3,]
#d2m3 <- d2[d2$mod=='mod3_pro',]
#d2m3s <- d2m3[d2m3$student %in%students_in_both_3,]

d1m1 <- d1[d1$mod=='mod1_pro',]
d1m3 <- d1[d1$mod=='mod3_pro',]
d1m13 <- merge(d1m1, d1m3, by = "student")

d2m1 <- d2[d2$mod=='mod1_pro',]
d2m3 <- d2[d2$mod=='mod3_pro',]
d2m13 <- merge(d2m1, d2m3, by = "student")

# Relevant variables: mean_word_length.x, mean_words_per_sentence.x, mean_different_words_per_bucket.x
t.test(d1m13$mean_word_length.x, d1m13$mean_word_length.y,paired=TRUE)
t.test(d1m13$mean_words_per_sentence.x, d1m13$mean_words_per_sentence.y, paired=TRUE)
t.test(d1m13$mean_different_words_per_bucket.x, d1m13$mean_different_words_per_bucket.y,paired=TRUE)
t.test(d1m13$normalized_word_proportion.x, d1m13$normalized_word_proportion.y,paired=TRUE)
t.test(d1m13$FleschReadingEase.x, d1m13$FleschReadingEase.y,paired=TRUE)
t.test(d1m13$FleschKincaidGradeLevel.x, d1m13$FleschKincaidGradeLevel.y,paired=TRUE)
t.test(d1m13$GunningFogIndex.x, d1m13$GunningFogIndex.y,paired=TRUE)
t.test(d1m13$SMOGIndex.x, d1m13$SMOGIndex.y,paired=TRUE)
t.test(d1m13$ColemanLiauIndex.x, d1m13$ColemanLiauIndex.y,paired=TRUE)
t.test(d1m13$LIX.x, d1m13$LIX.y,paired=TRUE)
t.test(d1m13$RIX.x, d1m13$RIX.y,paired=TRUE)


t.test(d2m13$mean_word_length.x, d2m13$mean_word_length.y,paired=TRUE)
t.test(d2m13$mean_words_per_sentence.x, d2m13$mean_words_per_sentence.y,paired=TRUE)
t.test(d2m13$mean_different_words_per_bucket.x, d2m13$mean_different_words_per_bucket.y,paired=TRUE)
t.test(d2m13$normalized_word_proportion.x, d2m13$normalized_word_proportion.y,paired=TRUE)
t.test(d2m13$FleschReadingEase.x, d2m13$FleschReadingEase.y,paired=TRUE)
t.test(d2m13$FleschKincaidGradeLevel.x, d2m13$FleschKincaidGradeLevel.y,paired=TRUE)
t.test(d2m13$GunningFogIndex.x, d2m13$GunningFogIndex.y,paired=TRUE)
t.test(d2m13$SMOGIndex.x, d2m13$SMOGIndex.y,paired=TRUE)
t.test(d2m13$ColemanLiauIndex.x, d2m13$ColemanLiauIndex.y,paired=TRUE)
t.test(d2m13$LIX.x, d2m13$LIX.y,paired=TRUE)
t.test(d2m13$RIX.x, d2m13$RIX.y,paired=TRUE)


# Show histogram of the changes.
d1m13$change_word_length <- d1m13$mean_word_length.y - d1m13$mean_word_length.x
d1m13$change_in_words_per_sentence <- d1m13$mean_words_per_sentence.y - d1m13$mean_words_per_sentence.x
d1m13$change_words_per_bucket <- d1m13$mean_different_words_per_bucket.y - d1m13$mean_different_words_per_bucket.x
d1m13$change_in_normalized_wordprop <- d1m13$normalized_word_proportion.y - d1m13$normalized_word_proportion.x
d1m13$change_in_FleschKincaidGradeLevel <- d1m13$FleschKincaidGradeLevel.y - d1m13$FleschKincaidGradeLevel.x



qplot(d1m13$change_in_FleschKincaidGradeLevel)
mean(d1m13$change_in_FleschKincaidGradeLevel)

d2m13$change_in_ColemanLiauIndex <- d2m13$ColemanLiauIndex.y - d2m13$ColemanLiauIndex.x
qplot(d2m13$change_in_ColemanLiauIndex)
mean(d2m13$change_in_ColemanLiauIndex)


# Analyze the causes of the changes.
summary(glm(change_in_words_per_sentence ~ mean_word_length.x, data = d1m13))
summary(glm(change_word_length ~ change_words_per_bucket + mean_word_length.x + instructor.x, data = d1m13))
