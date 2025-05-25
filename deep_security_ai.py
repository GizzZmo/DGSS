import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense

class DeepSecurityAI:
    def __init__(self):
        self.model = Sequential([
            Dense(64, activation="relu", input_shape=(3,)),  # Input features
            Dense(64, activation="relu"),  # Hidden layer
            Dense(1, activation="sigmoid")  # Output 0 (Normal) or 1 (Threat)
        ])
        self.model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])

    def train_model(self, X_train, y_train):
        """Trains the AI model with historical security data."""
        self.model.fit(X_train, y_train, epochs=50, verbose=1)

    def predict_risk(self, new_event):
        """Predicts if an event is anomalous."""
        prediction = self.model.predict(np.array([new_event]))
        return prediction[0][0] > 0.5  # Risk flagged if above threshold

# Example Usage
historical_data = np.array([
    [5, 10, 0],  # Failed Logins, Vote Spam, Treasury Fraud
    [15, 20, 1], 
    [3, 8, 0], 
    [12, 5, 1]
])
labels = np.array([0, 1, 0, 1])  # 0 = Normal, 1 = Threat

ai_security = DeepSecurityAI()
ai_security.train_model(historical_data, labels)

new_event = np.array([7, 12, 1])  # Suspicious activity
if ai_security.predict_risk(new_event):
    print("🚨 AI Alert: High-risk behavior detected!")
