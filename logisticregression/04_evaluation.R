# 04_evaluation.R
# Purpose: Evaluate the model's performance and create visualizations

# Load libraries
library(ggplot2)
library(pROC)

# Load the trained model
model <- readRDS("model.rds")

# Make predictions
test$predicted_income <- predict(model, newdata = test, type = "response")

# Create confusion matrix
confusion_matrix <- table(test$income, test$predicted_income > 0.5)

# Calculate accuracy, recall, and precision
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
recall <- confusion_matrix[2, 2] / sum(confusion_matrix[2, ])
precision <- confusion_matrix[2, 2] / sum(confusion_matrix[, 2])

# Print the evaluation metrics
print(paste("Accuracy: ", accuracy))
print(paste("Recall: ", recall))
print(paste("Precision: ", precision))

# Visualize the confusion matrix
confusion_matrix_plot <- ggplot(data = as.data.frame.table(confusion_matrix), aes(x = Var1, y = Var2, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), vjust = 1) +
  theme_bw() +
  labs(x = "Actual", y = "Predicted", fill = "Frequency") +
  ggtitle("Confusion Matrix")

# ROC Curve
roc_curve <- roc(test$income, test$predicted_income)
roc_plot <- ggplot(data = as.data.frame(roc_curve), aes(x = 1 - specificity, y = sensitivity)) +
  geom_line(color = "blue") +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
  theme_bw() +
  labs(x = "False Positive Rate (1 - Specificity)", y = "True Positive Rate (Sensitivity)") +
  ggtitle("ROC Curve")
print(confusion_matrix_plot)
print(roc_plot)
# Save plots as images
ggsave("confusion_matrix.png", plot = confusion_matrix_plot, width = 6, height = 6, units = "in")
ggsave("roc_curve.png", plot = roc_plot, width = 6, height = 6, units = "in")
