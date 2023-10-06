
# Purpose: Build and train the predictive model

# Import libraries
library(caTools)
library(glmnet)

# Split data into train and test sets
set.seed(101)
sample <- sample.split(adult$income , SplitRatio = 0.70)
train <- subset(adult , sample == TRUE)
test <- subset(adult , sample == FALSE)

# Build a logistic regression model
model <- glm(income ~ ., family = binomial(logit), data = train)

# Use stepwise regression (if needed)
# new_step_model <- step(model)

# Save the trained model
saveRDS(model, "model.rds")
