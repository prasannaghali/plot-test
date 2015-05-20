# Example from: The Art of R Programming by Norman Matloff

# not a good thing to cause bandwidth problems by constantly connecting to archive
abalone_url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
abalone <- read.csv(abalone_url, header=FALSE, sep=",")
names(abalone) <- c("Sex", "Length", "Diameter", "Height", "Whole Weight",
                    "Shucked Weight", "Viscera Weight", "Shell Weight", "Rings")
write.csv(abalone, "abalone.csv", row.names=FALSE)

pdf("abalone-len-sex.pdf")
plot(Length ~ Sex, data=abalone)
dev.off()

pdf("abalone-diamlen.pdf")
grps <- list()
for (gen in c("M","F")) grps[[gen]] <- which(abalone == gen)
abam <- abalone[grps$M,]	# submatrix of abalone data corresponding to males
abaf <- abalone[grps$F,]	# submatrix of abalone data corresponding to females
plot(abam$Length, abam$Diameter)
plot(abaf$Length, abaf$Diameter, pch="x", new=FALSE)
dev.off()

pdf("abalone-ringlen.pdf")
library(ggplot2)
qplot(x=Rings, y=Length, data=abalone)
dev.off()

# Second example:
# sample a line randomly along the X-axis using an uniform distruction in interval (0,1) plus
# noise from normal (gaussian) distribution
num_of_samples <- 40
yinter <- 2
slope <- -3
sigSq <- 0.5
x <- runif(40)
y <- yinter + slope * x + rnorm(num_of_samples, sd = sqrt(sigSq))
plot(x, y)
abline(yinter, slope, col="blue")
dev.print(pdf, "linescatter.pdf")

# Third example - again from: The Art of R Programming by Norman Matloff

# each line contains data for one student:
# average quiz, average assignment, midterm exam, final exam, and
# the final course grade.
# each grade is a range of 0 to 100.
# grading algorithm: q*0.1 + ass*0.3 + mid*0.2 + fin*0.4
quizexam <- read.table("grades.txt", header=FALSE)
names(quizexam) <- c("Quiz", "Assignment", "Midterm", "Final", "Course")

# plot the graph of (quiz, final exam) exam scores
#plot(quizexam[,1], quizexam[,4])
plot(quizexam$Quiz, quizexam$Final, type="p", col="red",
     xlab="Average Quiz Score", ylab="Final Exam Score")

# let's try to predict final exam score from the average quiz score
# by fitting a straight line to the (quiz, final exam) pairs
#in the data
lma <- lm(quizexam$Final ~ quizexam$Quiz)
# lma is a data frame which is a list of vectors with each vector
# corresponding to columns if the data frame is viewed as a matrix
# above could also have been written as:
abline(lma)
dev.print(pdf, "quizexamcorr.pdf")
