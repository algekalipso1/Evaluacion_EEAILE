install.packages("ggplot2")
library(ggplot2)

#setwd("~/Documents/Person/language_improvement_analysis/featurized_text")
setwd("~/Documents/hard_drive/Personal/repessss/language_improvement_analysis/featurized_text")

#d = read.csv("text_features_2.csv")
#d = read.csv("text_features_with_grade_levels.csv")
d = read.csv("text_features_with_grade_levels_and_key_terms.csv")


d$sqrt_word_count = d$word_count^.5
d$normalized_word_proportion = d$different_words / d$sqrt_word_count

t.test(d[d$mod == 'mod1_pro',]$mean_word_length, d[d$mod == 'mod3_pro',]$mean_word_length)
t.test(d[d$mod == 'mod1_pro',]$mean_words_per_sentence, d[d$mod == 'mod3_pro',]$mean_words_per_sentence)
t.test(d[d$mod == 'mod1_pro',]$normalized_word_proportion, d[d$mod == 'mod3_pro',]$normalized_word_proportion)

qplot(sqrt_word_count, different_words, color = mod, data = d)
summary(lm(different_words ~ sqrt_word_count + word_count, data = d))


d2 = d[d$gen == 'gen2',]
d3 = d[d$gen == 'gen3',]

t.test(d2[d2$mod == 'mod1_pro',]$mean_word_length, d2[d2$mod == 'mod3_pro',]$mean_word_length)
t.test(d3[d3$mod == 'mod1_pro',]$mean_word_length, d3[d3$mod == 'mod3_pro',]$mean_word_length)

t.test(d2[d2$mod == 'mod1_pro',]$normalized_word_proportion, d2[d2$mod == 'mod3_pro',]$normalized_word_proportion)
t.test(d3[d3$mod == 'mod1_pro',]$normalized_word_proportion, d3[d3$mod == 'mod3_pro',]$normalized_word_proportion)

t.test(d2[d2$mod == 'mod1_pro',]$mean_words_per_sentence, d2[d2$mod == 'mod3_pro',]$mean_words_per_sentence)
t.test(d3[d3$mod == 'mod1_pro',]$mean_words_per_sentence, d3[d3$mod == 'mod3_pro',]$mean_words_per_sentence)

t.test(d2[d2$mod == 'mod1_pro',]$mean_different_words_per_bucket, d2[d2$mod == 'mod3_pro',]$mean_different_words_per_bucket)   
t.test(d3[d3$mod == 'mod1_pro',]$mean_different_words_per_bucket, d3[d3$mod == 'mod3_pro',]$mean_different_words_per_bucket)   




 # Intersect and conduct paired t tests

#students_in_both_3 <- intersect(d3[d3$mod == 'mod1_pro',]$student, d3[d3$mod == 'mod3_pro',]$student)
#d3m1 <- d3[d3$mod=='mod1_pro',]
#d3m1s <- d3m1[d3m1$student %in%students_in_both_3,]
#d3m3 <- d3[d3$mod=='mod3_pro',]
#d3m3s <- d3m3[d3m3$student %in%students_in_both_3,]

d2m1 <- d2[d2$mod=='mod1_pro',]
d2m3 <- d2[d2$mod=='mod3_pro',]
d2m13 <- merge(d2m1, d2m3, by = "student")

d3m1 <- d3[d3$mod=='mod1_pro',]
d3m3 <- d3[d3$mod=='mod3_pro',]
d3m13 <- merge(d3m1, d3m3, by = "student")

# Relevant variables: mean_word_length.x, mean_words_per_sentence.x, mean_different_words_per_bucket.x
t.test(d2m13$mean_word_length.x, d2m13$mean_word_length.y,paired=TRUE)
t.test(d2m13$mean_words_per_sentence.x, d2m13$mean_words_per_sentence.y, paired=TRUE)
t.test(d2m13$mean_different_words_per_bucket.x, d2m13$mean_different_words_per_bucket.y,paired=TRUE)
t.test(d2m13$normalized_word_proportion.x, d2m13$normalized_word_proportion.y,paired=TRUE)
t.test(d2m13$FleschReadingEase.x, d2m13$FleschReadingEase.y,paired=TRUE)
t.test(d2m13$FleschKincaidGradeLevel.x, d2m13$FleschKincaidGradeLevel.y,paired=TRUE)
t.test(d2m13$GunningFogIndex.x, d2m13$GunningFogIndex.y,paired=TRUE)
t.test(d2m13$SMOGIndex.x, d2m13$SMOGIndex.y,paired=TRUE)
t.test(d2m13$ColemanLiauIndex.x, d2m13$ColemanLiauIndex.y,paired=TRUE)
t.test(d2m13$LIX.x, d2m13$LIX.y,paired=TRUE)
t.test(d2m13$RIX.x, d2m13$RIX.y,paired=TRUE)


t.test(d3m13$mean_word_length.x, d3m13$mean_word_length.y,paired=TRUE)
t.test(d3m13$mean_words_per_sentence.x, d3m13$mean_words_per_sentence.y,paired=TRUE)
t.test(d3m13$mean_different_words_per_bucket.x, d3m13$mean_different_words_per_bucket.y,paired=TRUE)
t.test(d3m13$normalized_word_proportion.x, d3m13$normalized_word_proportion.y,paired=TRUE)
t.test(d3m13$FleschReadingEase.x, d3m13$FleschReadingEase.y,paired=TRUE)
t.test(d3m13$FleschKincaidGradeLevel.x, d3m13$FleschKincaidGradeLevel.y,paired=TRUE)
t.test(d3m13$GunningFogIndex.x, d3m13$GunningFogIndex.y,paired=TRUE)
t.test(d3m13$SMOGIndex.x, d3m13$SMOGIndex.y,paired=TRUE)
t.test(d3m13$ColemanLiauIndex.x, d3m13$ColemanLiauIndex.y,paired=TRUE)
t.test(d3m13$LIX.x, d3m13$LIX.y,paired=TRUE)
t.test(d3m13$RIX.x, d3m13$RIX.y,paired=TRUE)


# Key Terms Frequency
t.test(d3m13$total_term_appearance_normalized.x, d3m13$total_term_appearance_normalized.y,paired=TRUE)
t.test(d2m13$total_term_appearance_normalized.x, d2m13$total_term_appearance_normalized.y,paired=TRUE)

# Change in Term Frequencies: colnames(d2m13)
term_sums <- colSums(d2m13[,c(18:308, 325:615)])
term_sums <- term_sums/dim(d2m13)[1]
d2m_terms <- rbind(term_sums[1:291], term_sums[292:length(term_sums)])
d2m_terms_ratio <- (d2m_terms[2,] + 0.0001) / (d2m_terms[1,]+ 0.0001)
d2m_terms <- rbind(d2m_terms, d2m_terms_ratio)
comparison_table_d2 <- t(d2m_terms)
colnames(comparison_table_d2) <- c("mod1", "mod3","ratio")
comparison_table_d2 <- comparison_table_d2[order(comparison_table_d2[,3], decreasing = TRUE),]
write.csv(comparison_table_d2, file = "../palabras_clave/cambio_en_frecuencias_g2.csv")


d3term_sums <- colSums(d3m13[,c(18:308, 325:615)])
d3term_sums <- d3term_sums/dim(d3m13)[1]
d3_terms <- rbind(d3term_sums[1:291], d3term_sums[292:length(term_sums)])
#d3_terms_ratio <- d3_terms[1,] / (d3_terms[2,] + 0.0000000001)
d3_terms_ratio <-  (d3_terms[2,] + 0.0001) /  (d3_terms[1,] + 0.0001)
d3_terms <- rbind(d3_terms, d3_terms_ratio)
comparison_table_d3 <- t(d3_terms)
colnames(comparison_table_d3) <- c("mod1", "mod3","ratio")
comparison_table_d3 <- comparison_table_d3[order(comparison_table_d3[,3], decreasing = TRUE),]
write.csv(comparison_table_d3, file = "../palabras_clave/cambio_en_frecuencias_g3.csv")



# At least one appearance
term_sums <- colSums(d2m13[,c(18:308, 325:615)] > 0)
term_sums <- term_sums/dim(d2m13)[1]
d2m_terms <- rbind(term_sums[1:291], term_sums[292:length(term_sums)])
d2m_terms_ratio <- (d2m_terms[2,] + 0.0001) / (d2m_terms[1,]+ 0.0001)
d2m_terms <- rbind(d2m_terms, d2m_terms_ratio)
comparison_table_d2 <- t(d2m_terms)
colnames(comparison_table_d2) <- c("mod1", "mod3","ratio")
comparison_table_d2 <- comparison_table_d2[order(comparison_table_d2[,3], decreasing = TRUE),]
write.csv(comparison_table_d2, file = "../palabras_clave/proporcion_de_proyectos_con_terminos_g2.csv")


d3term_sums <- colSums(d3m13[,c(18:308, 325:615)] > 0)
d3term_sums <- d3term_sums/dim(d3m13)[1]
d3_terms <- rbind(d3term_sums[1:291], d3term_sums[292:length(term_sums)])
#d3_terms_ratio <- d3_terms[1,] / (d3_terms[2,] + 0.0000000001)
d3_terms_ratio <-  (d3_terms[2,] + 0.0001) /  (d3_terms[1,] + 0.0001)
d3_terms <- rbind(d3_terms, d3_terms_ratio)
comparison_table_d3 <- t(d3_terms)
colnames(comparison_table_d3) <- c("mod1", "mod3","ratio")
comparison_table_d3 <- comparison_table_d3[order(comparison_table_d3[,3], decreasing = TRUE),]
write.csv(comparison_table_d3, file = "../palabras_clave/proporcion_de_proyectos_con_terminos_g3.csv")


# Factor analysis on Terms

just_term_freqs <- d[,20:306]
just_term_freqs = just_term_freqs[,colSums(just_term_freqs) > 0.001]

terms_fit <- factanal(just_term_freqs, 2, rotation="varimax", scores="regression")
print(terms_fit, digits=2, cutoff=.2, sort=TRUE)

# plot factor 1 by factor 2
load <- terms_fit$loadings[,c(1, 2)]
plot(load,type="n")
text(load,labels=rownames(load),cex=.6) 


# Show histogram of the changes.
#d2m13$change_word_length <- d2m13$mean_word_length.y - d2m13$mean_word_length.x
#d2m13$change_in_words_per_sentence <- d2m13$mean_words_per_sentence.y - d2m13$mean_words_per_sentence.x
#d2m13$change_words_per_bucket <- d2m13$mean_different_words_per_bucket.y - d2m13$mean_different_words_per_bucket.x
#d2m13$change_in_normalized_wordprop <- d2m13$normalized_word_proportion.y - d2m13$normalized_word_proportion.x
#d2m13$change_in_FleschKincaidGradeLevel <- d2m13$FleschKincaidGradeLevel.y - d2m13$FleschKincaidGradeLevel.x



qplot(d2m13$change_in_FleschKincaidGradeLevel)
mean(d2m13$change_in_FleschKincaidGradeLevel)

d3m13$change_in_ColemanLiauIndex <- d3m13$ColemanLiauIndex.y - d3m13$ColemanLiauIndex.x
qplot(d3m13$change_in_ColemanLiauIndex)
mean(d3m13$change_in_ColemanLiauIndex)


# Analyze the causes of the changes.
summary(glm(change_in_words_per_sentence ~ mean_word_length.x, data = d2m13))
summary(glm(change_word_length ~ change_words_per_bucket + mean_word_length.x + instructor.x, data = d2m13))



both_gens <- rbind(d2m13, d3m13)

colnames(d)

summary(lm(word_count ~ gen * mod, data = d))
summary(lm(mean_word_length ~ gen * mod, data = d))
summary(lm(mean_words_per_sentence ~ gen * mod, data = d))
summary(lm(mean_different_words_per_bucket ~ gen * mod + instructor, data = d))
summary(lm(FleschReadingEase ~ gen * mod, data = d))
summary(lm(FleschKincaidGradeLevel ~ gen * mod, data = d))
summary(lm(GunningFogIndex ~ gen * mod, data = d))
summary(lm(SMOGIndex ~ gen * mod, data = d))
summary(lm(ColemanLiauIndex ~ gen * mod, data = d))
summary(lm(LIX ~ gen * mod, data = d))
summary(lm(RIX ~ gen * mod, data = d))


